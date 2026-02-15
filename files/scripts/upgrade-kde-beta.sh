#!/bin/bash
set -ouex pipefail

# Update to the latest versions (COPR managed in recipe.yml)
dnf update -y
