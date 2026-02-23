# Enable AMD P-State Active Mode for Ryzen Processors
enable-amd-pstate:
    rpm-ostree kargs --append='amd_pstate=active'
    echo "Done! Please reboot to apply."
