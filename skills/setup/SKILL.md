---
name: setup
description: Install or repair zstack on this machine for Claude Code and Codex. Use for /zstack:setup, a new machine, a cloud environment, or after updating zstack. Never writes into a repo.
disable-model-invocation: true
---

# Set up zstack on this machine

zstack lives at user level, so every repo gets it and no repo gets a commit. Claude Code gets the plugin, whose SessionStart hook adds the rulebook index and the precedence rule to every session. Codex gets the same text in its global `AGENTS.md`, and the skills linked into `~/.agents/skills`.

## Steps

1. **Claude Code plugin.** Run `claude plugin list` and look for `zstack@zstack`, enabled at user scope. If it is missing, install it:

   ```sh
   claude plugin install zstack --marketplace zhangfand/zstack
   ```

   For a clone you are editing, add the clone as the marketplace instead (`claude plugin marketplace add <path to clone>`), so edits load at the next session with no version bump. In a container that has no SSH key for GitHub, set `CLAUDE_CODE_PLUGIN_PREFER_HTTPS=1` first.

2. **Auto-update.** Third-party marketplaces do not auto-update. Tell the user to run `/plugin`, open **Marketplaces**, select `zstack`, and choose **Enable auto-update**. You cannot do this step for them.

3. **Find the zstack root** for Codex. Read `installLocation` for `zstack` in `~/.claude/plugins/known_marketplaces.json`. That directory follows marketplace updates, unlike the versioned plugin cache. Without Claude Code, use a clone of `zhangfand/zstack`.

4. **Codex.** Run `sh <root>/scripts/setup-codex.sh <root>`. It rewrites only the block between `<!-- zstack:begin -->` and `<!-- zstack:end -->` in `~/.codex/AGENTS.md` (or `AGENTS.override.md` when that exists), and only the `zstack-*` links in `~/.agents/skills`. Skip this step when the machine has no `~/.codex`.

5. **Report** what changed, quoting the script's output, and which steps the user still owes.

## When to run it again

- After zstack adds a rulebook or a skill, because the Codex block and links are a snapshot. Claude Code needs no rerun.
- On a new machine, and in a cloud environment's setup script (steps 1 and 4 only).

## What this skill never does

- Write into a repo: no `CLAUDE.md`, `CLAUDE.local.md`, `.gitignore` or settings file there. A user who wants zstack off in one repo sets `"enabledPlugins": {"zstack@zstack": false}` in that repo's `.claude/settings.local.json`.
- Edit `~/.claude/CLAUDE.md` or `~/.claude/rules/`. The hook already carries the text, and a second copy drifts.
