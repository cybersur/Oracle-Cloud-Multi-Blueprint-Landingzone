# Repository Structure Overview

 
## 1. Purpose

This document defines the folder hierarchy and architectural layout of the **p-pm-tgs-oci-landingzone** repository.  
It serves as the baseline reference for understanding how blueprints, orchestrator components, pipelines, and documentation are organized.  

This repository supports **multi-blueprint orchestration**, **multi-layer infrastructure deployment**, and **governed automation** aligned to Oracle Cloud Infrastructure (OCI) best practices.

---

## 2. Layered Architecture Model

The repository is divided into **four functional layers**, each representing a stage in the OCI Landing Zone lifecycle.

 
| Layer       |   Name      |                          Primary Purpose                               |               Example Components                       |
|-------------|-------------|------------------------------------------------------------------------|--------------------------------------------------------|
| **Layer 0** | Baseline    | Establish orchestration engine, catalogs, state backend, and pipelines | Orchestrator Hub, Blueprint Catalogs, Vault, Pipelines |
| **Layer 1** | Foundation  | Define tenancy-wide resources, networking, security, and governance    | VCNs, DRGs, NSGs, Tag Namespaces, Policies             |
| **Layer 2** | Operational | Deploy workloads and compartmentalized “cells” for Dev/Test/Prod       | Compute, Storage, Service Gateways                     |
| **Layer 3** | Automation  | Provide CI/CD, tfvars, teardown, and blueprint delivery pipelines      | GitHub Actions, Lint/Validate, Deploy/Destroy          |

 
This separation ensures **modularity**, **reusability**, and **governed deployment sequencing**.

 ---

 ## 3. Top-Level Directory Layout

 p-pm-tgs-oci-landingzone/
│
├── README.md
├── .gitignore
│
├── docs/                        # Architectural and governance documentation
│   ├── architecture/            # Design documents for structure, flow, and catalogs
│   └── governance/              # Branch policy and repo rules
│
├── src/                         # Source Terraform and orchestration logic
│   ├── layer0_baseline/         # Orchestrator baseline and blueprint catalogs
│   │   ├── orchestrator/        # Terraform orchestrator modules (hub, engine, registry)
│   │   ├── catalogs/            # YAML blueprints + registry.json
│   │   ├── pipelines/           # CI/CD pipelines for sync, validation, bootstrap
│   │   ├── state/               # Backend + Vault configuration
│ │ └── config/ # Optional IAM, Tag, and tenancy metadata
│ │
│ ├── layer1_foundation/ # Core networking, governance, security modules
│ ├── layer2_operational/ # Environment “cells” (Dev/Test/Prod)
│ └── layer3_automation/ # CI/CD and tfvars orchestration
│
├── env/ # Environment-specific Terraform entrypoints
│ ├── dev/
│ ├── test/
│ └── prod/
│
├── tools/ # Helper modules, scripts, and templates
│ ├── scripts/ # PowerShell/Bash automation utilities
│ ├── modules/ # Shared Terraform modules for orchestration & governance
│ └── templates/ # JSON/YAML templates for service catalogs
│
└── .github/workflows/ # GitHub Actions automation (validation, sync, bootstrap)

 

