#!/bin/bash
set -ouex pipefail

# Configure GRUB for dual-boot and saving default entry
GRUB_FILE="/etc/default/grub"
[ ! -f "$GRUB_FILE" ] && touch "$GRUB_FILE"

grep -q "GRUB_DISABLE_OS_PROBER" "$GRUB_FILE" && sed -i 's/^GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' "$GRUB_FILE" || echo "GRUB_DISABLE_OS_PROBER=false" >> "$GRUB_FILE"
grep -q "GRUB_SAVEDEFAULT" "$GRUB_FILE" && sed -i 's/^GRUB_SAVEDEFAULT=.*/GRUB_SAVEDEFAULT=true/' "$GRUB_FILE" || echo "GRUB_SAVEDEFAULT=true" >> "$GRUB_FILE"
grep -q "GRUB_DEFAULT" "$GRUB_FILE" && sed -i 's/^GRUB_DEFAULT=.*/GRUB_DEFAULT=saved/' "$GRUB_FILE" || echo "GRUB_DEFAULT=saved" >> "$GRUB_FILE"
