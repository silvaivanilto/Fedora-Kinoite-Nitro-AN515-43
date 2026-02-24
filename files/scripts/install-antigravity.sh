#!/bin/bash
set -ouex pipefail

# Add Antigravity RPM repository
cat <<EOF > /etc/yum.repos.d/antigravity.repo
[antigravity-rpm]
name=Antigravity RPM Repository
baseurl=https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm
enabled=1
gpgcheck=0
EOF

# Install Antigravity
rpm-ostree install antigravity
