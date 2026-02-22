# Configure Windows to appear in the GRUB boot menu
configure-grub-windows:
    #!/usr/bin/env bash
    set -e

    if [ "$EUID" -ne 0 ]; then
      echo "Elevating privileges..."
      exec sudo "$0" "$@"
    fi

    if ! command -v os-prober &> /dev/null; then
        echo "os-prober is not installed."
        exit 1
    fi

    grub2-editenv - set timeout=10

    WIN_PART=$(os-prober | head -n 1 | cut -d: -f1 | cut -d@ -f1)
    
    if [ -z "$WIN_PART" ]; then
        echo "Could not detect Windows installation."
        exit 1
    fi
    
    WIN_UUID=$(lsblk -no UUID "$WIN_PART")

    if [ -z "$WIN_UUID" ]; then
        echo "Could not extract UUID."
        exit 1
    fi

    cat <<EOF > /boot/grub2/windows.cfg
menuentry "Windows" --class windows --class os {
    insmod part_gpt
    insmod fat
    insmod chain
    search --no-floppy --fs-uuid --set=root $WIN_UUID
    chainloader /EFI/Microsoft/Boot/bootmgfw.efi
}
EOF

    if [ -f /boot/grub2/grub.cfg ]; then
        if ! grep -q "windows.cfg" /boot/grub2/grub.cfg; then
            echo "source \$prefix/windows.cfg" >> /boot/grub2/grub.cfg
        fi
    fi

    echo "Windows successfully added to your GRUB boot menu!"
