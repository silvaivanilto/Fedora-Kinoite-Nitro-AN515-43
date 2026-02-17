#!/bin/bash
set -ouex pipefail

# Update to the latest versions (highest version priority).
dnf update -y
