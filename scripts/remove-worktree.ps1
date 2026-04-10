param(
    [Parameter(Mandatory = $true)]
    [string]$TaskId,

    [switch]$KeepBranch,

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

if (-not (Test-Path $worktreePath)) {
    throw "Worktree path not found: $worktreePath"
}

Write-Host "Repository: $repoRoot"
Write-Host "Git: $git"
Write-Host "Removing worktree: $worktreePath"

& $git -C $repoRoot worktree remove "$worktreePath"

if (-not $KeepBranch) {
    Write-Host "Deleting branch: $branchName"
    & $git -C $repoRoot branch -D $branchName
}

Write-Host ""
Write-Host "Removed worktree successfully."
if ($KeepBranch) {
    Write-Host "Branch kept: $branchName"
}
