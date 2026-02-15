#!/bin/bash
set -ouex pipefail

# Verify and install Epson RPM
RPM="/tmp/rpms/epson-inkjet-printer-escpr-1.8.6-1.x86_64.rpm"
HASH="9181f44577296c3c0e441642be9e6ea05827d545b1a654cd0a1d659c30d57162"

[ ! -f "$RPM" ] && exit 1
[ "$(sha256sum "$RPM" | awk '{print $1}')" != "$HASH" ] && exit 1

rpm -ivh --nodigest --nosignature "$RPM"
