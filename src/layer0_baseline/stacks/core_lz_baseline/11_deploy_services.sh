cat > 11_deploy_services.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
terraform apply -auto-approve
echo
echo "🧾 Deployed networking. Check OCI Console → Compartments (filter by tag DemoFingerprint)."
EOF
chmod +x 11_deploy_services.sh
