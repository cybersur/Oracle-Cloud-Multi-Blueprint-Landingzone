# -----------------------------------------------------
# Demo: Pull Oracle Multi-OE Blueprint from Upstream
# -----------------------------------------------------
# Author: Dr. Rigoberto Garcia
# Demo Date: 10/29/25
# Purpose: Demonstrate upstream integration workflow for Multi-OE blueprints
# Repo Path: C:\Users\Administrator\Desktop\Tek Systems Files\oracle-landing-zones\p-pm-tgs-oci-landingzone
# -----------------------------------------

$repoRoot        = "C:\Users\Administrator\Desktop\Tek Systems Files\oracle-landing-zones\p-pm-tgs-oci-landingzone"
$upstreamRepo    = "$repoRoot\src\layer0_baseline\catalogs\operating-entities\upstream"
$sourceBlueprint = "$upstreamRepo\blueprints\multi-oe"
$targetCatalog   = "$repoRoot\src\layer0_baseline\catalogs\multi_oe\upstream"

Write-Host "`n=== Understanding the first Step: Navigate to repository root ===" -ForegroundColor Cyan
Set-Location $repoRoot
Write-Host "Current Directory: $(Get-Location)" -ForegroundColor Yellow

Write-Host "`n=== Next we will: Pull latest Oracle Multi-OE upstream ===" -ForegroundColor Cyan
git -C $upstreamRepo pull origin main

Write-Host "`n=== Now that we have copied validated the udates we will: Prepare local target directory ===" -ForegroundColor Cyan
if (-not (Test-Path $targetCatalog)) {
    New-Item -ItemType Directory -Path $targetCatalog | Out-Null
    Write-Host "Created target path: $targetCatalog" -ForegroundColor Green
} else {
    Write-Host "Target path already exists: $targetCatalog" -ForegroundColor Yellow
}

Write-Host "`n=== Now that we are pointing to the right directory  we begin: Copy Oracle Multi-OE blueprint to local upstream ===" -ForegroundColor Cyan
Copy-Item -Path "$sourceBlueprint\*" -Destination $targetCatalog -Recurse -Force

Write-Host "`n=== Now we have sucessfully pulled for the upstream Oracle Repo and we are: Display new Multi-OE structure ===" -ForegroundColor Cyan
Get-ChildItem -Path $targetCatalog -Recurse | Select-Object FullName

Write-Host "`n 10/29/25 Multi-OE sync complete at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Green
