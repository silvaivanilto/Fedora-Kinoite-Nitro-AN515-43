#!/bin/bash
set -ouex pipefail

# 1. Install TLP repository for Fedora 43
rpm -ivh https://repo.linrunner.de/fedora/tlp/repos/releases/tlp-release.fc43.noarch.rpm

# 2. Remove conflicting packages (must be removed BEFORE TLP install)
rpm-ostree override remove tuned tuned-ppd

# 3. Install TLP packages
rpm-ostree install tlp tlp-pd tlp-rdw

# 4. Configure battery thresholds for Acer Nitro 5 (AN515-43)
mkdir -p /etc/tlp.d
cat <<EOF > /etc/tlp.d/01-nitro5.conf
# Acer Nitro 5 (AN515-43) — Battery Health Configuration
# Start charging at 75%, stop at 80%
START_CHARGE_THRESH_BAT0=75
STOP_CHARGE_THRESH_BAT0=80
EOF
chmod 644 /etc/tlp.d/01-nitro5.conf

# 5. Enable TLP services
systemctl enable tlp.service
systemctl enable tlp-pd.service

# 6. Mask rfkill to prevent conflicts with TLP
systemctl mask systemd-rfkill.service systemd-rfkill.socket
