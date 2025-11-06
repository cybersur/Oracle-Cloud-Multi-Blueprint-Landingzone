# ======================================================================
#  Created by: Dr. Rigoberto Garcia 11/01/2025
#  description: Orchestrator to deploy Layer 0 Baseline
#  notes: This module deploys the core Layer 0 Baseline using the
# ======================================================================

terraform {
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

module "vcn" {
  source                = "../terraform-oci-vcn"
  tenancy_id            = var.tenancy_id
  compartment_id        = var.compartment_id
  label_prefix          = var.label_prefix
  vcn_cidrs             = ["10.17.0.0/16"]
  create_internet_gateway = true
  create_nat_gateway      = true
  create_service_gateway  = true
}

