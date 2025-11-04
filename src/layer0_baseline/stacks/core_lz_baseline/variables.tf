# ======================================================================
#  Created by: Dr. Rigoberto Garcia 11/01/2025
#  description: Variables for Layer 0 Baseline core stack
#  notes: This file defines the input variables
# ======================================================================

variable "region" {
  description = "OCI region"
  type        = string
}

variable "tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
}

variable "baseline_compartment" {
  description = "Baseline compartment from layer 0"
  type        = string
  default     = "core-lz-baseline"
}

variable "network_cidr_block" {
  description = "VPC CIDR for foundation network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
