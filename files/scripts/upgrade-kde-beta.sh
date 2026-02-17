#!/bin/bash
set -ouex pipefail

# Upgrade KDE Plasma packages from the kde-beta COPR
dnf5 -y upgrade --refresh --repo='copr:copr.fedorainfracloud.org:group_kdesig:kde-beta'
