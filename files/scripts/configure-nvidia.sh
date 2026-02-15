#!/bin/bash
set -ouex pipefail

# Configure Nvidia Dynamic Power Management
cat <<EOF > /etc/modprobe.d/nvidia.conf
options nvidia "NVreg_DynamicPowerManagement=0x02"
EOF

chmod 644 /etc/modprobe.d/nvidia.conf
