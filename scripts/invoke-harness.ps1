$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot

Write-Host "Harness root: $root"
Write-Host ""
Write-Host "v1 flow"
Write-Host "1. Review AGENTS.md and specs/feature-001.md"
Write-Host "2. Use .codex/prompts/planner.md to refine the spec"
Write-Host "3. Use .codex/prompts/orchestrator.md to slice owned tasks"
Write-Host "4. Create git worktrees for parallel-safe builder tasks"
Write-Host "5. Use .codex/prompts/qa.md after integration"
Write-Host "6. Write the final report under reports/final/"
Write-Host ""
Write-Host "This script is a runbook entry point, not a full automation runner."
