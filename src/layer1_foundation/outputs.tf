# ======================================================================
#  Created by: Dr. Rigoberto Garcia 11/01/2025
#  description: Terraform outputs for Layer 0 Baseline core stack
#  notes: outputs for Layer 0 Baseline core stack
# ======================================================================

output "foundation_compartment" {
  value = var.baseline_compartment
}

output "network_cidr" {
  value = var.network_cidr_block
}
