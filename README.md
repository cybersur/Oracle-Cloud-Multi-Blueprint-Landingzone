# Oracle OCI Cloud Multi-Blueprint Landing Zone with Orchestrator (Dev/Test)

This repository defines the Terraform deployment structure for the TGS Dev/Test Tenant.

## Plan Overview
1. Centralized Governance Plane
2. Operational Plane (Cell-Isolated Environments)
3. Orchestration and Automation Plane

Each layer is represented under `src/` and deployed via environment folders in `env/`.
