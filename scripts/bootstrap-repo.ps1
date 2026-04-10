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

Write-Host "Harness root: $repoRoot"
Write-Host "Git: $git"

$gitDir = Join-Path $repoRoot ".git"
if (-not (Test-Path $gitDir)) {
    Write-Host "Initializing git repository..."
    & $git -C $repoRoot init -b main
}

$mainBranch = "unknown"
try {
    $mainBranch = (& $git -C $repoRoot branch --show-current).Trim()
    if (-not $mainBranch) {
        $mainBranch = "main"
    }
} catch {
    $mainBranch = "main"
}

Write-Host "Active branch: $mainBranch"

$gitignorePath = Join-Path $repoRoot ".gitignore"
$entries = @(
    "_worktrees/",
    "reports/runs/*.log",
    "reports/runs/*.tmp"
)

if (-not (Test-Path $gitignorePath)) {
    Set-Content -Encoding UTF8 $gitignorePath ""
}

$currentIgnore = Get-Content $gitignorePath -ErrorAction SilentlyContinue
foreach ($entry in $entries) {
    if ($currentIgnore -notcontains $entry) {
        Add-Content -Encoding UTF8 $gitignorePath $entry
    }
}

Write-Host "Ensured .gitignore entries for harness worktrees and transient run output."
Write-Host ""
Write-Host "Next steps"
Write-Host "1. Review specs/feature-001.md"
Write-Host "2. Commit the scaffold once you are satisfied"
Write-Host "3. Create task worktrees with scripts/new-worktree.ps1"
