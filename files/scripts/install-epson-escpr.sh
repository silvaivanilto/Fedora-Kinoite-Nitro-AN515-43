#!/bin/bash
set -ouex pipefail

# Verify and install Epson RPM
RPM="/tmp/rpms/epson-inkjet-printer-escpr-1.8.6-1.x86_64.rpm"
HASH="9181f44577296c3c0e441642be9e6ea05827d545b1a654cd0a1d659c30d57162"

if [ ! -f "$RPM" ]; then
    echo "Error: Epson RPM not found at $RPM"
    exit 1
fi

if [ "$(sha256sum "$RPM" | awk '{print $1}')" != "$HASH" ]; then
    echo "Error: Epson RPM hash mismatch. Expected $HASH"
    exit 1
fi

rpm -ivh --nodigest --nosignature "$RPM"
