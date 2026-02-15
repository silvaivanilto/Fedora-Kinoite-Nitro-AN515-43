#!/bin/bash
set -ouex pipefail

echo "Configuring Root Theme Synchronization Service..."

# 1. Create a systemd service to sync root KDE config with the primary user (Wheel group)
# This ensures that apps run as root share the same visual theme and settings.
cat <<EOF > /etc/systemd/system/root-theme-sync.service
[Unit]
Description=Sync root KDE theme with primary admin user
After=local-fs.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c ' \\
    TARGET_USER=\$(getent group wheel | cut -d: -f4 | tr "," "\n" | grep -v "^root$" | head -n1); \\
    if [ -n "\$TARGET_USER" ]; then \\
        U_HOME=\$(getent passwd "\$TARGET_USER" | cut -d: -f6); \\
        if [ -d "\$U_HOME/.config" ]; then \\
            mkdir -p /root/.config; \\
            ln -sf "\$U_HOME/.config/kdeglobals" /root/.config/kdeglobals; \\
            ln -sf "\$U_HOME/.config/katerc" /root/.config/katerc; \\
            ln -sf "\$U_HOME/.config/kcminputrc" /root/.config/kcminputrc; \\
        fi; \\
    fi'

[Install]
WantedBy=multi-user.target
EOF

# 2. Enable the service
systemctl enable root-theme-sync.service

echo "Root theme synchronization configured successfully."
