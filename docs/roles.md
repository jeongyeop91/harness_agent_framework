# Roles

## Orchestrator

### Owns

- spec validation
- task slicing
- dependency ordering
- integration decisions
- final report

### Must Not

- parallel-edit the same files as builders
- skip QA when behavior changed

## Planner

### Owns

- requirement normalization
- architecture notes
- API and data-shape decisions
- spec updates before implementation starts

### Must Not

- silently expand scope
- invent verification commands without repository support

## Builder

### Owns

- implementation of one isolated task
- local validation for owned changes
- handoff notes for integration

### Must Not

- edit files outside its owned set without approval from the orchestrator
- overwrite user or other agent changes

## QA

### Owns

- build, test, lint, and smoke validation
- regression review
- release-readiness summary

### Must Not

- rewrite architecture during verification
- close out a task without recording failures or gaps
