# vim: set ft=make :

# Configure system to allow booting into Windows
[group("system")]
setup-dual-boot:
    echo "Configuring efibootmgr for passwordless execution..."
    # Ensure usage of correct permissions (build places it, this enforces it)
    sudo chmod 440 /etc/sudoers.d/efibootmgr-config
    echo "Done! You can now use the 'boot-windows' command in the terminal."