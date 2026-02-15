#!/bin/bash
set -ouex pipefail

# Install Epson Inkjet Printer Drivers (ESC/P-R)
# We use local RPMs to ensure build reproducibility and stability.

echo "Installing Epson printer drivers from local repository..."

# In BlueBuild, files/ are typically available in the build context
# We use dnf to handle potential local dependencies if any (though lsb is usually the only one)
# We use rpm directly with --nodigest --nosignature because older Epson RPMs 
# often lack the digests required by newer RPM/DNF versions in Fedora 43+.
# Security: Verify checksum before installing unsigned RPM
RPM_FILE="/tmp/files/rpms/epson-inkjet-printer-escpr-1.8.6-1.x86_64.rpm"
# TODO: Replace with the actual SHA256 hash of your RPM file
EXPECTED_HASH="PLACEHOLDER_HASH_REPLACE_ME_WITH_REAL_SHA256"

if [ -f "$RPM_FILE" ]; then
    echo "Verifying integrity of $RPM_FILE..."
    CURRENT_HASH=$(sha256sum "$RPM_FILE" | awk '{print $1}')
    
    if [ "$CURRENT_HASH" != "$EXPECTED_HASH" ]; then
        echo "ERROR: Security Check Failed! Hash mismatch for $RPM_FILE"
        echo "Expected: $EXPECTED_HASH"
        echo "Got:      $CURRENT_HASH"
        echo "This file may have been tampered with or corrupted."
        exit 1
    fi
    
    echo "Hash verified successfully. Installing..."
    rpm -ivh --nodigest --nosignature "$RPM_FILE"
else
    echo "ERROR: RPM file not found: $RPM_FILE"
    exit 1
fi

echo "Epson drivers installed successfully."
