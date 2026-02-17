#!/bin/bash
set -ouex pipefail

# Find the kde-beta COPR repository ID
REPO_ID=$(dnf5 repo list --enabled 2>/dev/null | grep -i kde-beta | awk '{print $1}')

if [ -z "$REPO_ID" ]; then
    echo "ERROR: kde-beta COPR repository not found"
    exit 1
fi

# Get only the packages available in the kde-beta COPR
PACKAGES=$(dnf5 repoquery --available --repo="$REPO_ID" --queryformat='%{name}' 2>/dev/null | sort -u | tr '\n' ' ')

if [ -n "$PACKAGES" ]; then
    echo "Upgrading KDE packages from $REPO_ID..."
    dnf5 -y upgrade $PACKAGES
else
    echo "No packages to upgrade from $REPO_ID"
fi
