# ======================================================================
#  Created by: Dr. Rigoberto Garcia
#  Created on: 10/21/2025
#  Updated on: 10/23/2025
#  Purpose: Educational purpose, to introduce a best practice or organizing the code when using Orchestrator, or Tenant Factories
#  Notes:   Part of the p-pm-tgs-oci-landingzone repository for Tek Systems Global Services.
# ======================================================================


# Layer 0 — Baseline & Orchestrator Foundation

I understand that some might look at this repo architecture and will say, that is not needed.  Its a waste of time.  However think about this, what happens as the architecture gets complex, is not a best practice to organize our code.  Developers are use to dump things anywhere.  This repository has been intentionally structured in **layers** to separate responsibility, reduce blast radius, and allow each plane of operation to evolve independently.  

True autonomy comes from a clear implementation of architecture.  In this repo, each layer represents a distinct phase in the Landing Zone’s lifecycle — from orchestration and governance at the top, to networking, operations, and automation at the bottom.  This help also with the Epic and Stories.  By focusing in layers you asure that the architecture is modular.   Changes from the Vendor, will not affect the Dev/Prod/Test architectures and the Customer can choose what to put into the production areas in Layer 1-N.

This design mirrors how Oracle Cloud Infrastructure (OCI) itself organizes its core constructs: identity, networking, compartments, and governance.

---

## Why a Layered Architecture?

Layering enforces **clean separation of concerns**.  

In an enterprise-grade Landing Zone, every configuration, policy, and deployment activity must align with strict governance and compliance controls.  
By dividing the repository into purpose-driven layers, we can:

- **Isolate change impact** — modifications in a higher layer (e.g., orchestration) never directly break infrastructure in lower layers.  
- **Support parallel development** — networking, security, and operations teams can all work on their respective layers without merge conflicts or dependency deadlocks.  
- **Enable controlled deployment pipelines** — CI/CD can deploy each layer sequentially or selectively, enforcing validation gates between them.  
- **Promote reusability and blueprinting** — each layer can be versioned, reused, or replaced across tenants, realms, or environments.

The result is an infrastructure system that is not only automated but **intentionally modular and self-governed**.

---

## What is Layer 0?

**Layer 0 (Baseline)** is the **root of orchestration** — the intelligent control plane that defines how all other layers behave, synchronize, and evolve.  
It is not a network layer, nor does it deploy workloads. Instead, it provides the **metadata, logic, and automation** that orchestrate everything else.

Layer 0 establishes:

1. **The Orchestrator** — the central hub that manages blueprint registration, validation, and execution pipelines.  
   It defines how new landing zones, compartments, or cells are created and governed.

2. **Blueprint Catalogs** — the structured library of deployable templates:
   - `core_lz` — the Core Landing Zone baseline.
   - `one_oe` — the One-Operational-Environment blueprint.
   - `multi_oe` — the Multi-Operational-Environment orchestration for complex, multi-tenant deployments.

3. **Pipelines** — YAML-based automation workflows that handle:
   - Repository bootstrap
   - Blueprint synchronization
   - Policy and module validation before deployment

4. **State Management** — definitions for backend state, storage, and vault integration, ensuring consistent control of Terraform execution.

Together, these elements make Layer 0 the **governance and automation nucleus** of the entire Landing Zone.  

It is the point of synchronization between code, documentation, and runtime automation — where architecture meets execution.

---

## Layer 0 Objectives

- Define how every blueprint, module, and environment is discovered and orchestrated.  
- Act as the **single source of truth** for orchestration metadata (`repository_manifest.yaml`).  
- Standardize pipelines for syncing OCI blueprints and deploying infrastructure layers.  
- Govern how the repository interacts with external systems — GitHub Actions, Azure DevOps, or OCI Resource Manager.  
- Provide future extensibility for audit trails, version tagging, and automated compliance validation.

---

## Layer 0 Structure

