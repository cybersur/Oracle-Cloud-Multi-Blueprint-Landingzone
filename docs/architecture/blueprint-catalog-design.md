# Blueprint Catalog Design
 
## 1. What is the Purpose of the Blueprint Catalog?
 
The Blueprint Catalog defines the structure, metadata, and synchronization model for managing multiple **OCI Landing Zone blueprints** within this repository.  
It allows the orchestrator to discover, version, and deploy pre-defined configurations such as:
 
- **Core Landing Zone (Core-LZ)**
- **One-OE Blueprint**
- **Multi-OE Blueprint**
 
Each blueprint represents a complete, deployable set of Terraform modules and configuration templates aligned to Oracle Cloud best practices.
 
---
 
## 2. What are the Design Objectives?
 
| Objective           | Description                                                                                     |
|---------------------|-------------------------------------------------------------------------------------------------|
| **Standardization** | Maintain consistent directory and metadata structures for all blueprints.                       |
| **Version Control** | Track each blueprint version, update source references, and allow rollbacks.                    |
| **Synchronization** | Automatically pull blueprint updates from Oracle public repositories or internal mirrors.       |
| **Interoperability** | Ensure compatibility with the orchestrator module and pipeline definitions.                    |
| **Auditability** | Provide transparent change tracking and verification of blueprint integrity.                       |
 
---
 "
## 3. How is the "Directory Structure" organized?
 
All blueprints live under the **Layer 0 Baseline Catalogs** directory: