# Harness

Local multi-agent harness skeleton for Codex CLI driven product work.

## Goal

Turn a product idea into a repeatable loop:

1. Capture intent in a spec
2. Slice work into owned tasks
3. Run builder work in isolated worktrees
4. Run QA and review gates
5. Publish a final report with completion state and risks

## v1 Roles

- `orchestrator`: task slicing, dependency control, final report
- `planner`: requirements clarification, architecture decisions, spec updates
- `builder`: implementation in an isolated worktree
- `qa`: verification, regression review, release readiness

## Repository Layout

- `docs/`: stable system and workflow rules
- `specs/`: feature or milestone specs
- `reports/`: run outputs and final summaries
- `scripts/`: local orchestration helpers
- `.codex/`: project-level Codex configuration and prompt assets

## First Run

1. Write the product or milestone brief in `specs/feature-001.md`
2. Review `docs/workflow.md`
3. Adjust `.codex/config.toml` for your local risk tolerance
4. Run `scripts/invoke-harness.ps1` from this directory
