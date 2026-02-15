#!/bin/bash
set -ouex pipefail

# Configure battery thresholds and power profile
mkdir -p /etc/tlp.d
cat <<EOF > /etc/tlp.d/99-nitro-5.conf
START_CHARGE_THRESH_BAT0=75
STOP_CHARGE_THRESH_BAT0=80
PCIE_ASPM_ON_BAT=powersave
EOF
