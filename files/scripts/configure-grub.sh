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

# Create firstboot service to detect Windows and update GRUB automatically
# Workaround: grub2-probe returns error on composefs (Fedora Atomic)
# but grub2-mkconfig still generates a valid config with os-prober entries
cat <<'EOF' > /etc/systemd/system/grub-os-detect.service
[Unit]
Description=Detect other OSes (Windows) and update GRUB configuration
After=local-fs.target boot-efi.mount
ConditionPathExists=!/var/lib/.grub-os-detect-done

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'os-prober && grub2-mkconfig -o /etc/grub2-efi.cfg 2>/dev/null; touch /var/lib/.grub-os-detect-done'
EOF

systemctl enable grub-os-detect.service
