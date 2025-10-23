# Understanding the "Orchestration Flow Design"
 
## 1. What is the purpose of the "Operatinal Flow" Design?
 
The operational flow design defines the **operational flow** of the Orchestrator within the **Layer 0 Baseline** of the OCI Landing Zone repository.  
It mean to describe how blueprints are registered, validated, synchronized, and deployed through automated workflows.
 
The orchestration framework is designed to enable **multi-blueprint**, **multi-environment**, and **multi-tenant** deployments while maintaining governance, repeatability, and auditability.
 
---
 
## 2. High-Level Objectives
 
| Objective                 | Description                                                                                          |
|---------------------------|------------------------------------------------------------------------------------------------------|
| **Centralized Control**   | The Orchestrator acts as a single control plane for blueprint execution across Dev, Test, and Prod.  |
| **Blueprint Automation**  | Automatically discovers and synchronizes new or updated blueprints from the catalog.                 |
| **State Management**      |Ensures every blueprint maintains a dedicated backend and vault state.                                |
| **Lifecycle Consistency** | Enforces consistent initialization, validation, deployment, and teardown across all blueprints.      |
| **Audit & Compliance**    | Tracks each orchestration action with timestamped registry updates for traceability.                 |
 
---
 
## 3. Orchestration Components
 
| Component | Path | Function |
|---------------------------|---------------------------------------------------------|----------------------------------------------------------|
| **Orchestration Hub**     | `src/layer0_baseline/orchestrator/orchestration_hub.tf` | Central brain coordinating all orchestration activities. |
| **Workflow Engine**       | `src/layer0_baseline/orchestrator/workflow_engine.tf`   | Executes pipelines (init → plan → apply → validate).     |
| **Service Catalog**       | `src/layer0_baseline/orchestrator/service_catalog.tf`   | Maintains blueprint registration and version metadata.   |
| **Artifact Registry**     | `src/layer0_baseline/orchestrator/artifact_registry.tf` | Stores templates, plans, and deployment artifacts.       |
| **Blueprint Catalogs**    | `src/layer0_baseline/catalogs/`                      | YAML definitions for deployable OCI landing zone blueprints.|
| **Pipelines**             | `src/layer0_baseline/pipelines/`            | YAML workflows automating synchronization, validation, and bootstrap.|
| **State Backend & Vault** | `src/layer0_baseline/state/`                            | Manages Terraform remote state and secret encryption.    |
 
---
 
## 4. Orchestration Flow Overview
 
The orchestration flow follows a four-phase lifecycle: **Discovery → Validation → Deployment → Post-Ops**.
 
```mermaid
flowchart TD
A[Blueprint Registry] --> B[Orchestrator Hub]
B --> C[Workflow Engine]
C --> D[Service Catalog]
D --> E[Artifact Registry]
E --> F[OCI Deployment Targets]
F --> G[State & Vault Update]
G --> H[Registry Sync and Report]