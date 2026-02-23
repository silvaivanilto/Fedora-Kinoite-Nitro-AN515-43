#!/usr/bin/env bash

# Set strict mode
set -ouex pipefail

echo "=================================================="
echo "          Hiding Terminal Application Icons       "
echo "=================================================="

# Delete the .desktop files so they don't appear in the KDE App Menu
# The binaries (htop, nvtop) will remain fully functional via terminal.
rm -f /usr/share/applications/htop.desktop
rm -f /usr/share/applications/nvtop.desktop

echo "Icons successfully removed!"
