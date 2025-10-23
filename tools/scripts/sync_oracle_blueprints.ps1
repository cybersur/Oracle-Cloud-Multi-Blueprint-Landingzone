# ======================================================================
#  Created by: Dr. Rigoberto Garcia
#  Created on: 10/23/2025
#  Updated on: 10/23/2025
#  Purpose: Pull (mirror/update) upstream Oracle blueprint repos into Layer 0
#  Notes:   Reads src/layer0_baseline/catalogs/blueprint-sources.json,
#           clones/fetches each source, copies into catalog subfolders,
#           updates registry timestamps, and optionally commits changes.
# ======================================================================

param(
  [switch]$Commit,          # If set, commit changes
  [string]$CommitBranch = "auto/blueprint-sync"
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path "$PSScriptRoot\..\..\").Path
Set-Location $repoRoot

$manifestPath = "src\layer0_baseline\catalogs\blueprint-sources.json"
if (!(Test-Path $manifestPath)) {
  Write-Error "Manifest not found: $manifestPath"
}

# Load manifest
$manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json
$sources  = $manifest.sources

function Ensure-Dir($path) {
  if (!(Test-Path $path)) { New-Item -ItemType Directory -Force -Path $path | Out-Null }
}

# Optional: create working branch for commits
if ($Commit) {
  git rev-parse --is-inside-work-tree | Out-Null
  $currentBranch = (git rev-parse --abbrev-ref HEAD).Trim()
  if ($currentBranch -ne $CommitBranch) {
    git checkout -B $CommitBranch | Out-Null
  }
}

foreach ($src in $sources) {
  Write-Host "🔄 Syncing [$($src.id)] from $($src.url) @ $($src.ref)"

  $dest = $src.dest
  Ensure-Dir $dest

  if (!(Test-Path (Join-Path $dest ".git"))) {
    # First-time clone (shallow)
    git clone --depth 1 --branch $($src.ref) $($src.url) $dest
  } else {
    Push-Location $dest
    git fetch --depth 1 origin $($src.ref)
    git checkout $($src.ref)
    git reset --hard origin/$($src.ref)
    Pop-Location
  }

  # Optionally prune unwanted paths in dest based on excludePaths
  foreach ($ex in $src.excludePaths) {
    Get-ChildItem -Path (Join-Path $dest $ex) -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
  }
}

# Update registry lastUpdated (if present)
$registryPath = "src\layer0_baseline\catalogs\blueprint-registry.json"
if (Test-Path $registryPath) {
  $reg = Get-Content $registryPath -Raw | ConvertFrom-Json
  $reg.lastUpdated = (Get-Date).ToString("yyyy-MM-dd")
  ($reg | ConvertTo-Json -Depth 10) | Out-File -FilePath $registryPath -Encoding utf8
  Write-Host "Updated $registryPath lastUpdated"
}

if ($Commit) {
    git add "src/layer0_baseline/catalogs"
    if (-not [string]::IsNullOrWhiteSpace($(git status --porcelain))) {
      git -c user.name="Blueprint Sync Bot" -c user.email="sync-bot@users.noreply.github.com" commit -m "chore: sync oracle blueprints ($(Get-Date -Format 'yyyy-MM-dd HH:mm'))"
      git push origin $CommitBranch
      Write-Host "Changes pushed to $CommitBranch"
    } else {
      Write-Host "No changes detected; nothing to commit."
    }
  }
  
  Write-Host "Sync complete."
  
