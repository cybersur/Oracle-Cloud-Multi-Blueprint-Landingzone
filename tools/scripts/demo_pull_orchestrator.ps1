# ============================================================
# DEMO: Pull Orchestrator Upstream for OCI Landing Zone
# Author: Dr. Rigoberto Garcia
# ============================================================
 
Write-Host "`n=== DEMO: Pulling Orchestrator Blueprint Upstream ===`n"
 
# Define target path
$target = "src\layer0_baseline\catalogs\orchestrator\upstream"
 
# Remove existing folder if it exists (force)
if (Test-Path $target) {
    Write-Host "Removing old orchestrator upstream..."
    Remove-Item -Recurse -Force $target
}
 
# Clone latest OCI Orchestrator blueprint from official repo
$repo = "https://github.com/oci-landing-zones/terraform-oci-modules-orchestrator.git"
Write-Host "Cloning from: $repo"
git clone $repo $target
 
if ($LASTEXITCODE -eq 0) {
    Write-Host "`n Successfully pulled Orchestrator upstream into:`n$target"
} else {
    Write-Host "`n Failed to pull Orchestrator upstream. Check connection or path."
}
 
Write-Host "`n=== DEMO COMPLETE ===`n"
