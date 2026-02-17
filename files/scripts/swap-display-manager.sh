#!/bin/bash
set -ouex pipefail

# 1. Install Plasma Login Manager
rpm-ostree install \
    kcm-plasmalogin \
    plasma-login-manager

# 2. Enable Plasma Login Manager service
systemctl enable plasmalogin.service

# 3. Remove SDDM (safe now that Plasma Login is installed)
rpm-ostree override remove \
    kde-settings-sddm \
    sddm \
    sddm-breeze \
    sddm-kcm \
    sddm-wayland-plasma
