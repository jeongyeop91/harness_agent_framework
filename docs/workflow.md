# Workflow

## Default Sequence

1. Create or update a spec in `specs/`
2. Orchestrator confirms scope, task ownership, and verification commands
3. Planner refines architecture or contract decisions if needed
4. Orchestrator creates one task per isolated implementation track
5. Builder runs each track in a dedicated git worktree
6. QA verifies the integrated result
7. Orchestrator writes the final report

## Split Rules

- Split only when tasks can own different files or modules
- Do not split when the next step depends on a shared unresolved design decision
- Prefer two or three parallel tasks, not many small ones

## Worktree Rules

- One worktree per implementation task
- Name worktrees by task id
- Merge or cherry-pick only after the task-specific verification passes
- The orchestrator owns final integration in the main workspace

## Required Task Fields

- goal
- in-scope items
- out-of-scope items
- owned files or directories
- dependencies
- verification commands
- completion criteria

## QA Gate

- Run the commands defined in the spec
- Check for broken contracts, regressions, and missing docs
- Record exact failures, not vague status

## Final Report Contents

- completed work
- incomplete work
- verification results
- known risks
- next approval point
