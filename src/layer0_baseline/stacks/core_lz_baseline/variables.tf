cat > variables.tf <<'EOF'
variable "region"           { type = string }
variable "tenancy_ocid"     { type = string }
variable "fingerprint"      { type = string }
variable "compartment_root_ocid" { type = string }
variable "compartment_cgp_ocid"  { type = string }
variable "compartment_gi_ocid"   { type = string }
variable "compartment_sc_ocid"   { type = string }
variable "compartment_ss_ocid"   { type = string }
variable "compartment_oa_ocid"   { type = string }
variable "vcn_cidr" { type = string }
variable "web_subnet_cidr" { type = string }
variable "app_subnet_cidr" { type = string }
EOF
