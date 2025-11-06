# ======================================================================
#  Created by: Dr. Rigoberto Garcia 11/01/2025
#  description: Orchestrator to deploy Layer 0 Baseline
#  notes: This module deploys the core Layer 0 Baseline using the
# ======================================================================



resource "oci_core_subnet" "public_subnet" {
  compartment_id      = var.compartment_id
  vcn_id              = "ocid1.vcn.oc1.iad.amaaaaaaigxokeyaaxcbswjsevwjkjfztny3bmld5bfj3k4stj3rozkblx6a"
  cidr_block          = "10.17.1.0/24"
  display_name        = "${var.label_prefix}-public-subnet"
  prohibit_public_ip_on_vnic = false
  route_table_id      = oci_core_route_table.ig[0].id
  security_list_ids   = [oci_core_default_security_list.lockdown[0].id]
}

resource "oci_core_subnet" "private_subnet" {
  compartment_id      = var.compartment_id
  vcn_id              = "ocid1.vcn.oc1.iad.amaaaaaaigxokeyaaxcbswjsevwjkjfztny3bmld5bfj3k4stj3rozkblx6a"
  cidr_block          = "10.17.2.0/24"
  display_name        = "${var.label_prefix}-private-subnet"
  prohibit_public_ip_on_vnic = true
  route_table_id      = oci_core_route_table.nat[0].id
  security_list_ids   = [oci_core_default_security_list.lockdown[0].id]
}

output "public_subnet_id" {
  value = oci_core_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = oci_core_subnet.private_subnet.id
}
