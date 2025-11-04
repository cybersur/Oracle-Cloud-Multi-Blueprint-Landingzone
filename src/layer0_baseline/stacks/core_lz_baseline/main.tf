# ======================================================================
#  Created by: Dr. Rigoberto Garcia 11/01/2025
#  description: Orchestrator to deploy Layer 0 Baseline
#  notes: This module deploys the core Layer 0 Baseline using the
# ======================================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}

provider "oci" {
  region = var.region
}

# Consume the baseline outputs as input
module "foundation_lz" {
  source                 = "../../layer0_baseline/stacks/core_lz_baseline"
  tenancy_ocid           = var.tenancy_ocid
  baseline_compartment   = var.baseline_compartment
  network_cidr_block     = var.network_cidr_block
  environment            = var.environment
}
