#!/usr/bin/env bash
set -ouex pipefail

rm -f /usr/share/applications/htop.desktop
rm -f /usr/share/applications/nvtop.desktop

# Remove Mozilla/Firefox residues
rm -rf /usr/lib/mozilla
rm -rf /usr/lib64/mozilla
rm -rf /etc/skel/.mozilla
