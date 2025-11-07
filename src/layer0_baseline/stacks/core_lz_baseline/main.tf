cat > main.tf <<'EOF'
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
  region       = var.region
  tenancy_ocid = var.tenancy_ocid
}

locals {
  tags = {
    DemoOwner       = "Dr. Rigoberto Garcia"
    DemoProject     = "p-pm-tgs-oci-landingzone"
    DemoFingerprint = var.fingerprint
  }
  name_suffix = "-${var.fingerprint}"
}

data "oci_core_services" "all_services" {}

resource "oci_core_vcn" "core_vcn" {
  compartment_id = var.compartment_ss_ocid
  cidr_block     = var.vcn_cidr
  display_name   = "rigo-core-lz-vcn${local.name_suffix}"
  freeform_tags  = local.tags
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ss_ocid
  display_name   = "rigo-core-lz-igw${local.name_suffix}"
  vcn_id         = oci_core_vcn.core_vcn.id
  is_enabled     = true
  freeform_tags  = local.tags
}

resource "oci_core_nat_gateway" "ngw" {
  compartment_id = var.compartment_ss_ocid
  display_name   = "rigo-core-lz-nat${local.name_suffix}"
  vcn_id         = oci_core_vcn.core_vcn.id
  freeform_tags  = local.tags
}

resource "oci_core_service_gateway" "sgw" {
  compartment_id = var.compartment_ss_ocid
  display_name   = "rigo-core-lz-sgw${local.name_suffix}"
  vcn_id         = oci_core_vcn.core_vcn.id
  services {
    service_id = data.oci_core_services.all_services.services[0].id
  }
  freeform_tags  = local.tags
}

resource "oci_core_route_table" "public_rt" {
  compartment_id = var.compartment_ss_ocid
  vcn_id         = oci_core_vcn.core_vcn.id
  display_name   = "rigo-core-lz-rt-public${local.name_suffix}"
  route_rules = [{
    network_entity_id = oci_core_internet_gateway.igw.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    description       = "Public egress"
  }]
  freeform_tags  = local.tags
}

resource "oci_core_route_table" "private_rt" {
  compartment_id = var.compartment_ss_ocid
  vcn_id         = oci_core_vcn.core_vcn.id
  display_name   = "rigo-core-lz-rt-private${local.name_suffix}"
  route_rules = [
    {
      network_entity_id = oci_core_nat_gateway.ngw.id
      destination       = "0.0.0.0/0"
      destination_type  = "CIDR_BLOCK"
      description       = "Private egress via NAT"
    },
    {
      network_entity_id = oci_core_service_gateway.sgw.id
      destination_type  = "SERVICE_CIDR_BLOCK"
      destination       = data.oci_core_services.all_services.services[0].cidr_block
      description       = "OCI services via SGW"
    }
  ]
  freeform_tags  = local.tags
}

resource "oci_core_subnet" "web_subnet" {
  compartment_id    = var.compartment_ss_ocid
  vcn_id            = oci_core_vcn.core_vcn.id
  cidr_block        = var.web_subnet_cidr
  display_name      = "rigo-web-subnet${local.name_suffix}"
  prohibit_public_ip_on_vnic = false
  route_table_id    = oci_core_route_table.public_rt.id
  dns_label         = "web"
  freeform_tags     = local.tags
}

resource "oci_core_subnet" "app_subnet" {
  compartment_id    = var.compartment_ss_ocid
  vcn_id            = oci_core_vcn.core_vcn.id
  cidr_block        = var.app_subnet_cidr
  display_name      = "rigo-app-subnet${local.name_suffix}"
  prohibit_public_ip_on_vnic = true
  route_table_id    = oci_core_route_table.private_rt.id
  dns_label         = "app"
  freeform_tags     = local.tags
}
EOF
