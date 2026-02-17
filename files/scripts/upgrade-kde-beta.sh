#!/bin/bash
set -ouex pipefail

# Sync all installed packages to the latest available versions
# from all configured repos (Fedora + kde-beta COPR)
# distro-sync picks the newest version regardless of which repo provides it
dnf5 -y --refresh distro-sync
