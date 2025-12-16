#!/bin/bash
set -e

echo "=========================================="
echo "   SimpleDNS — Bootstrap Installer"
echo "=========================================="

# STEP 1 — Ensure SSH key
if [[ ! -f ~/.ssh/id_ed25519 ]]; then
  echo "[INFO] No SSH key found — generating one..."
  ssh-keygen -t ed25519 -C "simpledns-bootstrap" -f ~/.ssh/id_ed25519 -N ""
fi

PUBKEY=$(cat ~/.ssh/id_ed25519.pub)

echo
echo "=========================================="
echo " ADD THIS SSH PUBLIC KEY TO GITHUB:"
echo " GitHub → Settings → SSH and GPG Keys → New SSH Key"
echo "=========================================="
echo "$PUBKEY"
echo "------------------------------------------"
read -p "Press ENTER once added to GitHub..."

echo "[INFO] Testing SSH connection..."
ssh -T git@github.com || true

# STEP 2 — Clone SimpleDNS
echo "[INFO] Cloning SimpleDNS..."
rm -rf SimpleDNS 2>/dev/null || true
git clone git@github.com:msbenjamin12/SimpleDNS.git

# STEP 3 — Run real installer (root-required)
echo "[INFO] Running SimpleDNS installer..."
cd SimpleDNS/install
sudo bash setup.sh

echo
echo "=========================================="
echo "[INFO] Bootstrap complete"
echo "=========================================="
