# Runbook

## Prepare

1. Open this repository in a terminal
2. Run `powershell -ExecutionPolicy Bypass -File scripts/bootstrap-repo.ps1` once
3. Confirm `git status`
4. Create or update a spec in `specs/`
5. Review `AGENTS.md`, `docs/workflow.md`, and `docs/roles.md`
6. Confirm Git is installed and reachable by PATH or a standard Windows Git path

## Suggested Local Flow

1. Planner pass
   - refine spec
   - define owned files
   - define verification commands
2. Orchestrator pass
   - create task ids
   - identify parallel-safe tasks
   - create worktrees if needed
3. Builder pass
   - run implementation in isolated worktrees
   - perform local checks
4. QA pass
   - verify integrated result
   - record findings
5. Finalize
   - write report under `reports/final/`

## Worktree Commands

- Bootstrap repo: `powershell -ExecutionPolicy Bypass -File scripts/bootstrap-repo.ps1`
- Create: `powershell -ExecutionPolicy Bypass -File scripts/new-worktree.ps1 -TaskId feature-001-api`
- Remove and delete branch: `powershell -ExecutionPolicy Bypass -File scripts/remove-worktree.ps1 -TaskId feature-001-api`
- Remove and keep branch: `powershell -ExecutionPolicy Bypass -File scripts/remove-worktree.ps1 -TaskId feature-001-api -KeepBranch`

## Minimum Report Template

- Summary:
- Completed:
- Not completed:
- Verification:
- Risks:
- Next action:

## Failure Handling

- If scope changed, update the spec first
- If worktrees collide on the same file set, stop parallel work and re-slice
- If verification is blocked, record the exact blocker in the report
