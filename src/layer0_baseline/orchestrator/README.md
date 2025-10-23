# Orchestrator Overview

The Layer 0 Orchestrator controls blueprint registration, pipeline execution,
and orchestration workflows for OCI Landing Zone deployments.

## Components
|        File          |                         Purpose                        |
|----------------------|--------------------------------------------------------|
| orchestration_hub.tf | Central controller for orchestration logic             |
| workflow_engine.tf   | Handles workflow orchestration and execution           |
| artifact_registry.tf | Manages plan artifacts and deployment metadata         |
| service_catalog.tf   | Defines deployable blueprints for all OCI environments |

The orchestrator will later interface with the CI/CD pipelines
to automate blueprint sync, validation, and deployment.
