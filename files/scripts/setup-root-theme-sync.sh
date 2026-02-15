#!/bin/bash
set -ouex pipefail

# Create root theme sync service
cat <<EOF > /etc/systemd/system/root-theme-sync.service
[Unit]
Description=Sync root KDE theme with primary admin user
After=local-fs.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c ' \\
    TARGET_USER=\$(getent group wheel | cut -d: -f4 | tr "," "\n" | grep -v "^root$" | head -n1); \\
    U_HOME=\$(getent passwd "\$TARGET_USER" | cut -d: -f6); \\
    mkdir -p /root/.config; \\
    ln -sf \$U_HOME/.config/kdeglobals /root/.config/kdeglobals; \\
    ln -sf \$U_HOME/.config/katerc /root/.config/katerc; '

[Install]
WantedBy=multi-user.target
EOF

systemctl enable root-theme-sync.service
