# -----------------------------------------
# Demo: Sync and copy Oracle One-OE blueprint
# -----------------------------------------
# Author: Dr. Rigoberto Garcia
# Demo Date: 10/29/25
# Purpose: Demonstrate upstream integration workflow for One-OE blueprints
# Repo Path: C:\Users\Administrator\Desktop\Tek Systems Files\oracle-landing-zones\p-pm-tgs-oci-landingzone
# -----------------------------------------

# Define paths
$repoRoot = "C:\Users\Administrator\Desktop\Tek Systems Files\oracle-landing-zones\p-pm-tgs-oci-landingzone"
$upstreamRepo = "$repoRoot\src\layer0_baseline\catalogs\operating-entities\upstream"
$sourceBlueprint = "$upstreamRepo\blueprints\one-oe"
$targetCatalog = "$repoRoot\src\layer0_baseline\catalogs\one_oe\upstream"

Write-Host "=== Understanding the first Step: Navigate to repository root ===" -ForegroundColor Cyan
Set-Location $repoRoot
Write-Host "Current Directory: $(Get-Location)" -ForegroundColor Yellow

# Sync latest upstream from Oracle
Write-Host "`n=== Next we will: Pull latest updates from Oracle upstream ===" -ForegroundColor Cyan
git -C $upstreamRepo pull origin main

# You must ensure the target directory exists, before this operation or the will be a cascade failure.
Write-Host "`n=== Now that we have copied validated the udates we will: Preparing target directory ===" -ForegroundColor Cyan
if (-Not (Test-Path $targetCatalog)) {
    New-Item -ItemType Directory -Path $targetCatalog | Out-Null
    Write-Host "Created target path: $targetCatalog" -ForegroundColor Green
} else {
    Write-Host "Target path already exists: $targetCatalog" -ForegroundColor Yellow
}

# Copy blueprint
Write-Host "`n=== Now that we are pointing to the right directory  we begin: Copying Oracle One-OE blueprint to local upstream ===" -ForegroundColor Cyan
Copy-Item -Path "$sourceBlueprint\*" -Destination $targetCatalog -Recurse -Force

# Display the new folder structure
Write-Host "`n=== Now we have sucessfully pulled for the upstream Oracle Repo and we are: Displaying local One-OE upstream structure ===" -ForegroundColor Cyan
Get-ChildItem -Path $targetCatalog -Recurse | Select-Object FullName

Write-Host "`n 10/29/25 DEMO COMPLETE: Oracle One-OE blueprint successfully pulled and synced!" -ForegroundColor Green
