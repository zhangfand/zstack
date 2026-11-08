---
name: research-first
description: Before building a new workflow or skill for a repetitive task, survey how others already solved it, test the candidates against the real tools, synthesize one that fits the user, get sign-off, then write it as a skill. Use when the user wants a new workflow, process, or skill, or asks how others handle a recurring task.
---

# Research first, then build the workflow

A repetitive task has usually been solved many times already. This skill finds those solutions, proves which parts hold on the user's own tools, and only then writes the workflow as a skill. The miss it prevents: a home-made workflow that repeats a known mistake, or skips a mechanism the tool already ships.

## Steps

1. **Frame the task.** Write down the verb the task really is, the user's constraints, and what done looks like. List every assumption, the user's included, as a hypothesis to test in step 4.

2. **Read the raw material first.** Look at the user's actual setup before the web: the files, installed tools, existing skills and config that the workflow will touch. Note what the setup already shows about how the user works.

3. **Survey prior art.** Cover four sources:
   - the official docs of every tool the workflow runs in;
   - named public implementations of the same workflow, read in their source, not their README alone;
   - generic tools that solve the general case;
   - the same problem in an adjacent field.

   Open each primary source. A search snippet is not a source. For each approach, record what it gives, where it falls short for this user, and what to take from it.

4. **Test the deciding questions.** Each choice between candidates turns on a few facts. Turn each fact into an experiment against the real tool: a headless run, a canary word planted in each input, at least three runs per arm, and a control arm without the change. Report only what ran, with counts. Name what could not be tested and why.

5. **Synthesize one recommendation.** Combine the surviving parts into one workflow, split by the situations the user meets, from the most common to the rarest. Give each rejected option one line with the reason.

6. **Get sign-off.** Present a document with the recommendation first, then the test results, the prior-art table, the workflow, the proposed changes, and the open questions. Do not write the skill until the user agrees with the direction.

7. **Write the skill.** Follow the rulebooks for the content it contains, keep project names out of anything meant for every repo, and add it to the plugin's index. Rerun the step 4 experiments against the finished skill and put the counts in the PR.

8. **Record what lasts.** Save the facts a later session would otherwise rediscover, such as tool behavior the docs do not state, to memory.
