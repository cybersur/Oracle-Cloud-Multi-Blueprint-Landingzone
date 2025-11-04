# -----------------------------------------------------
# Demo: Pull OCI Multicloud AWS Landing Zone Blueprint
# -----------------------------------------------------
# Author: Dr. Rigoberto Garcia
# Date: 10/29/2025
# -----------------------------------------------------
 
Write-Host "`n=== DEMO: Pulling OCI Multicloud AWS Landing Zone Upstream ===`n" -ForegroundColor Cyan
 
# Auto-detect repo root
$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$targetPath = Join-Path $repoRoot "src\layer0_baseline\catalogs\multicloud_aws\upstream"
 
# Remove any old folder
if (Test-Path $targetPath) {
    Write-Host "Removing existing multicloud AWS upstream..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $targetPath
}
 
# Clone fresh repo
$repo = "https://github.com/oci-landing-zones/terraform-oci-multicloud-aws.git"
Write-Host "Cloning from: $repo" -ForegroundColor Green
git clone $repo $targetPath
 
if ($LASTEXITCODE -eq 0) {
    Write-Host "`n Successfully pulled OCI Multicloud AWS upstream into:`n$targetPath" -ForegroundColor Green
} else {
    Write-Host "`n Failed to clone the OCI Multicloud AWS repository. Please verify network or permissions." -ForegroundColor Red
}
 
Write-Host "`n=== DEMO COMPLETE ===`n" -ForegroundColor Cyan
