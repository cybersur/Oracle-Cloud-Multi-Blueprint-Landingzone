cat > 10_tf_init.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMP_ENV="${SCRIPT_DIR}/../../compartments/state/compartments.env"
FPRINT_ENV="${SCRIPT_DIR}/../../compartments/state/fingerprint.env"
source "${COMP_ENV}"
source "${FPRINT_ENV}"

PROFILE="${OCI_CLI_PROFILE:-DEFAULT}"
TENANCY_OCID="$(grep -A4 "^\[${PROFILE}\]" ~/.oci/config | awk -F= '/tenancy/ {print $2}' | xargs)"
REGION="$(grep -A4 "^\[${PROFILE}\]" ~/.oci/config | awk -F= '/region/ {print $2}' | xargs)"

cat > terraform.tfvars <<EOF
region                 = "${REGION}"
tenancy_ocid           = "${TENANCY_OCID}"
fingerprint            = "${DEMO_FINGERPRINT}"
compartment_root_ocid  = "${ROOT_OCID}"
compartment_cgp_ocid   = "${CGP_OCID}"
compartment_gi_ocid    = "${RIGO_CORE_LZ_GI_SC01_OCID}"
compartment_sc_ocid    = "${RIGO_CORE_LZ_SC_SC02_OCID}"
compartment_ss_ocid    = "${RIGO_CORE_LZ_SS_SC03_OCID}"
compartment_oa_ocid    = "${RIGO_CORE_LZ_OA_SC04_OCID}"
vcn_cidr        = "10.10.0.0/16"
web_subnet_cidr = "10.10.1.0/24"
app_subnet_cidr = "10.10.2.0/24"
EOF

terraform init -upgrade
echo "terraform.tfvars ready (fingerprint ${DEMO_FINGERPRINT})"
EOF
chmod +x 10_tf_init.sh
