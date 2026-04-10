# Harness Working Guide

## Purpose

- Build a local multi-agent product-development harness
- Keep orchestration, implementation, and verification separated
- Prefer small, auditable steps over fully autonomous drift

## Read Order

1. `AGENTS.md`
2. `README.md`
3. `docs/architecture.md`
4. `docs/workflow.md`
5. `docs/roles.md`
6. `docs/runbook.md`
7. Relevant spec in `specs/`

## Execution Rules

- The orchestrator owns task slicing and final integration
- Split work only when file ownership is explicit
- Do not let multiple agents edit the same file in parallel
- Use one spec per feature or milestone
- Update the spec before changing scope
- Keep changes small and verifiable
- Record final outcomes in `reports/`

## Multi-Agent Rules

- Default v1 roles: `orchestrator`, `planner`, `builder`, `qa`
- Use separate git worktrees for parallel code changes
- Prefer worktree-per-task, not worktree-per-role
- Define API or contract decisions before parallel implementation starts
- QA runs after implementation, never in parallel with unresolved schema changes

## Verification Rules

- Every implementation task must define its verification commands in the spec
- Prefer deterministic checks: build, test, lint, smoke script
- If verification cannot run, record the gap in the report

## Documentation Rules

- AI-facing operational docs stay in English
- Keep headings short and stable
- Prefer checklists and concrete rules over prose
