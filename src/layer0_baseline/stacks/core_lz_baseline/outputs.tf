cat > outputs.tf <<'EOF'
output "fingerprint"   { value = var.fingerprint }
output "vcn_id"        { value = oci_core_vcn.core_vcn.id }
output "web_subnet_id" { value = oci_core_subnet.web_subnet.id }
output "app_subnet_id" { value = oci_core_subnet.app_subnet.id }
EOF
