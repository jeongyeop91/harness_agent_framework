param(
    [Parameter(Mandatory = $true)]
    [string]$TaskId,

    [string]$BaseBranch = "main",

    [string]$WorktreeRoot = "..\\_worktrees"
)

$ErrorActionPreference = "Stop"

function Resolve-GitExe {
    $command = Get-Command git -ErrorAction SilentlyContinue
    if ($command) {
        return $command.Source
    }

    $candidates = @(
        "C:\\Program Files\\Git\\cmd\\git.exe",
        "C:\\Program Files\\Git\\bin\\git.exe",
        "C:\\Program Files (x86)\\Git\\cmd\\git.exe",
        "C:\\Program Files (x86)\\Git\\bin\\git.exe"
    )

    foreach ($candidate in $candidates) {
        if (Test-Path $candidate) {
            return $candidate
        }
    }

    throw "git executable not found. Install Git or add it to PATH."
}

$git = Resolve-GitExe
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$worktreeBase = [System.IO.Path]::GetFullPath((Join-Path $repoRoot $WorktreeRoot))
$branchName = "task/$TaskId"
$worktreePath = Join-Path $worktreeBase $TaskId

& $git -C $repoRoot rev-parse --is-inside-work-tree | Out-Null

New-Item -ItemType Directory -Force -Path $worktreeBase | Out-Null

$existingBranch = & $git -C $repoRoot branch --list $branchName
if ($existingBranch) {
    throw "Branch '$branchName' already exists. Pick a new task id or remove the existing branch first."
}

Write-Host "Repository: $repoRoot"
Write-Host "Git: $git"
Write-Host "Base branch: $BaseBranch"
Write-Host "Branch: $branchName"
Write-Host "Worktree: $worktreePath"

& $git -C $repoRoot fetch --all --prune
& $git -C $repoRoot worktree add "$worktreePath" -b $branchName $BaseBranch

Write-Host ""
Write-Host "Created worktree successfully."
Write-Host "Path: $worktreePath"
Write-Host "Branch: $branchName"
