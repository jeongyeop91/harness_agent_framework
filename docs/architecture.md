# Architecture

## Objective

Provide a small local harness around Codex CLI so one human can give direction while multiple agent roles handle planning, implementation, and verification.

## Principles

- The harness is document-driven, not chat-history-driven
- Specs are the system of record for active work
- Parallel work is isolated by git worktree
- Verification gates decide progress, not optimism
- The orchestrator integrates results and publishes the final status

## Core Components

### 1. Spec Layer

- Stores the current problem statement, scope, constraints, file ownership, and verification commands
- One active feature or milestone should map to one spec file

### 2. Role Layer

- Planner refines scope and architecture
- Builder implements owned tasks
- QA verifies behavior and checks for regression risk
- Orchestrator sequences all stages and writes reports

### 3. Workspace Layer

- Main repository stays clean and owns docs plus integration
- Parallel implementation uses dedicated git worktrees
- Each worktree owns one task at a time

### 4. Report Layer

- Final status is written to `reports/final/`
- Optional step-by-step logs can be written to `reports/runs/`

## State Model

- `draft`: spec exists but task slicing is incomplete
- `ready`: owned tasks and verification commands are defined
- `in_progress`: one or more builder tasks are running
- `qa`: implementation is complete and verification is active
- `done`: checks passed and final report is written
- `blocked`: missing dependency, policy, failing checks, or merge conflict

## Non-Goals For v1

- Full unattended deployment
- Cross-machine orchestration
- Shared memory service
- Automatic conflict resolution between overlapping code edits
