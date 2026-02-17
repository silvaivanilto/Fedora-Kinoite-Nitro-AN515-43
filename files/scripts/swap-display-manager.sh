#!/bin/bash
set -ouex pipefail

# 1. Atomic swap: Remove SDDM + Install Plasma Login Manager in one transaction
rpm-ostree override remove \
    kde-settings-sddm \
    sddm \
    sddm-breeze \
    sddm-kcm \
    sddm-wayland-plasma \
    --install kcm-plasmalogin \
    --install plasma-login-manager

# 2. Enable Plasma Login Manager service (safe now that SDDM is gone)
systemctl enable plasmalogin.service
