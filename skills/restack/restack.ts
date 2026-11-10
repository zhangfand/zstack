#!/usr/bin/env node
// Rebase the branches left in a stack after the PR below them was squash-merged.
//
// Usage: restack.ts [--trunk <branch>] [--remote <name>] [--push] <old-base> <branch>...
//
//   <old-base>  the merged parent's last commit: a SHA, a ref, or "#<N>" for
//               PR N on GitHub, read from refs/pull/<N>/head.
//   <branch>    the surviving branches, bottom first. The last one is the top.
//
// A plain rebase replays the parent's original commits against its squash
// commit and conflicts. `--onto <trunk> <old-base>` replays only the commits
// above the parent, and `--update-refs` moves every branch in between.
//
// Runs on Node 22.18 or later with no install: Node strips the types itself.

import { spawnSync } from "node:child_process";

const USAGE = "usage: restack.ts [--trunk <branch>] [--remote <name>] [--push] <old-base> <branch>...";

type Options = {
  remote: string;
  trunk: string | undefined;
  push: boolean;
  oldBase: string;
  branches: string[];
};

class Failure extends Error {
  readonly code: number;
  constructor(message: string, code = 1) {
    super(message);
    this.code = code;
  }
}

type Run = { ok: boolean; out: string };

// Inherited stdio for the steps the user should see, captured for the queries.
function git(args: string[], opts: { show?: boolean } = {}): Run {
  const r = spawnSync("git", args, {
    encoding: "utf8",
    stdio: opts.show ? "inherit" : ["ignore", "pipe", "pipe"],
  });
  if (r.error) throw new Failure(`cannot run git: ${r.error.message}`);
  return { ok: r.status === 0, out: (r.stdout ?? "").trim() };
}

function gitOrFail(args: string[], what: string): string {
  const r = git(args);
  if (!r.ok) throw new Failure(what);
  return r.out;
}

function parseArgs(argv: string[]): Options {
  let remote = "origin";
  let trunk: string | undefined;
  let push = false;
  const rest: string[] = [];
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    const value = (): string => {
      const v = argv[++i];
      if (v === undefined) throw new Failure(`${a} needs a value\n${USAGE}`, 2);
      return v;
    };
    if (a === "--trunk") trunk = value();
    else if (a === "--remote") remote = value();
    else if (a === "--push") push = true;
    else if (a === "-h" || a === "--help") {
      console.log(USAGE);
      process.exit(0);
    } else if (a === "--") {
      rest.push(...argv.slice(i + 1));
      break;
    } else if (a.startsWith("-") && rest.length === 0) throw new Failure(`unknown flag ${a}\n${USAGE}`, 2);
    else rest.push(a);
  }
  if (rest.length < 2) throw new Failure(USAGE, 2);
  const [oldBase, ...branches] = rest;
  return { remote, trunk, push, oldBase, branches };
}

function defaultTrunk(remote: string): string {
  const r = git(["symbolic-ref", "--quiet", "--short", `refs/remotes/${remote}/HEAD`]);
  return r.ok && r.out ? r.out.replace(`${remote}/`, "") : "main";
}

function checkWorkingTree(branches: string[]): void {
  if (gitOrFail(["status", "--porcelain", "--untracked-files=no"], "git status failed") !== "") {
    throw new Failure("the working tree has uncommitted changes; commit or stash them first");
  }
  // --update-refs skips any branch checked out in a worktree and leaves it
  // stale without a warning. The current branch is fine: rebase moves it.
  const current = git(["symbolic-ref", "--quiet", "--short", "HEAD"]).out;
  const checkedOut = new Set(
    gitOrFail(["worktree", "list", "--porcelain"], "git worktree list failed")
      .split("\n")
      .filter((l) => l.startsWith("branch refs/heads/"))
      .map((l) => l.slice("branch refs/heads/".length)),
  );
  for (const b of branches) {
    if (!git(["rev-parse", "--verify", "--quiet", `refs/heads/${b}`]).ok) {
      throw new Failure(`no local branch ${b}`);
    }
    if (checkedOut.has(b) && b !== current) {
      throw new Failure(`${b} is checked out in another worktree; switch that worktree away first`);
    }
  }
}

function resolveOldBase(oldBase: string, remote: string): string {
  if (!oldBase.startsWith("#")) return oldBase;
  const pr = oldBase.slice(1);
  gitOrFail(["fetch", "--quiet", remote, `refs/pull/${pr}/head`], `cannot fetch refs/pull/${pr}/head from ${remote}`);
  return gitOrFail(["rev-parse", "FETCH_HEAD"], "cannot read FETCH_HEAD");
}

function pushCommand(o: Options): string {
  return `git push --atomic --force-with-lease ${o.remote} ${o.branches.join(" ")}`;
}

function main(argv: string[]): void {
  const o = parseArgs(argv);
  const trunk = o.trunk ?? defaultTrunk(o.remote);
  const top = o.branches[o.branches.length - 1];

  checkWorkingTree(o.branches);
  const oldBase = resolveOldBase(o.oldBase, o.remote);
  const onto = `refs/remotes/${o.remote}/${trunk}`;
  gitOrFail(["fetch", "--quiet", o.remote, `+refs/heads/${trunk}:${onto}`], `cannot fetch ${trunk} from ${o.remote}`);

  if (!git(["merge-base", "--is-ancestor", oldBase, top]).ok) {
    throw new Failure(`${oldBase} is not in ${top}'s history; it is not this stack's old base`);
  }

  if (!git(["rebase", "--update-refs", "--onto", onto, oldBase, top], { show: true }).ok) {
    throw new Failure(
      "real conflict, not a squash artifact. Resolve it and run 'git rebase --continue';\n" +
        `then push with: ${pushCommand(o)}`,
    );
  }

  let below = onto;
  const stale: string[] = [];
  for (const b of o.branches) {
    if (!git(["merge-base", "--is-ancestor", below, b]).ok) stale.push(`${b} does not sit on ${below} after the rebase`);
    below = b;
  }
  if (stale.length > 0) throw new Failure(stale.join("\n"));

  for (const b of o.branches) {
    const n = gitOrFail(["rev-list", "--count", `${onto}..${b}`], `cannot count commits on ${b}`);
    console.log(`${b}: ${n} commit(s) above ${o.remote}/${trunk}`);
  }

  if (o.push) {
    if (!git(["push", "--atomic", "--force-with-lease", o.remote, ...o.branches], { show: true }).ok) {
      throw new Failure("push failed; nothing was pushed");
    }
  } else {
    console.log(`push with: ${pushCommand(o)}`);
  }
}

try {
  main(process.argv.slice(2));
} catch (e) {
  if (e instanceof Failure) {
    console.error(`restack: ${e.message}`);
    process.exit(e.code);
  }
  throw e;
}
