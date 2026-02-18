#!/bin/bash
set -ouex pipefail

# Configure GRUB for dual-boot and saving default entry
GRUB_FILE="/etc/default/grub"
[ ! -f "$GRUB_FILE" ] && touch "$GRUB_FILE"

if grep -q "GRUB_DISABLE_OS_PROBER" "$GRUB_FILE"; then
    sed -i 's/^GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' "$GRUB_FILE"
else
    echo "GRUB_DISABLE_OS_PROBER=false" >> "$GRUB_FILE"
fi

if grep -q "GRUB_SAVEDEFAULT" "$GRUB_FILE"; then
    sed -i 's/^GRUB_SAVEDEFAULT=.*/GRUB_SAVEDEFAULT=true/' "$GRUB_FILE"
else
    echo "GRUB_SAVEDEFAULT=true" >> "$GRUB_FILE"
fi

if grep -q "GRUB_DEFAULT" "$GRUB_FILE"; then
    sed -i 's/^GRUB_DEFAULT=.*/GRUB_DEFAULT=saved/' "$GRUB_FILE"
else
    echo "GRUB_DEFAULT=saved" >> "$GRUB_FILE"
fi

# Note: grub2-mkconfig is currently broken on Fedora Atomic with Composefs enabled.
# Automatic dual-boot detection is disabled to prevent errors.
# Users should use the BIOS/UEFI boot menu to select Windows.
