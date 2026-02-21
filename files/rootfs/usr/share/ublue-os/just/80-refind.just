# Setup the beautiful RONBM graphical theme in rEFInd on your Nitro
setup-refind-theme:
    #!/usr/bin/env bash
    set -e

    if [ "$EUID" -ne 0 ]; then
      echo "Please run this ujust command with sudo: sudo ujust setup-refind-theme"
      exit 1
    fi

    # Detect where the EFI partition is mounted and the rEFInd folder
    EFI_MOUNT=""
    if [ -d "/boot/efi/EFI/refind" ]; then
        EFI_MOUNT="/boot/efi/EFI/refind"
    elif [ -d "/boot/EFI/refind" ]; then
        EFI_MOUNT="/boot/EFI/refind"
    else
        echo "❌ rEFInd folder not found in /boot/efi/EFI or /boot/EFI."
        echo "❌ Have you installed rEFInd on this system yet?"
        exit 1
    fi

    echo "✨ Installing and configuring the RONBM Theme for rEFInd..."

    # 1. Create the themes root folder if necessary
    mkdir -p "$EFI_MOUNT/themes"

    # 2. Clone the repository in a temporary folder (avoiding clutter in Downloads)
    cd /tmp
    echo "⬇️  Cloning the theme from GitHub..."
    rm -rf RONBM
    git clone --quiet https://github.com/gutlessCGH/RONBM.git

    # 3. Copy to the safe location in rEFInd
    echo "📂 Copying theme files..."
    rm -rf "$EFI_MOUNT/themes/RONBM"
    cp -r RONBM "$EFI_MOUNT/themes/RONBM"

    # 4. Add to refind.conf (Without duplicating the line)
    CONF_FILE="$EFI_MOUNT/refind.conf"
    if [ -f "$CONF_FILE" ]; then
        if ! grep -q "include themes/RONBM/theme.conf" "$CONF_FILE"; then
            echo "include themes/RONBM/theme.conf" >> "$CONF_FILE"
            echo "✅ Theme configured in refind.conf!"
        else
            echo "✅ The theme was already enabled in refind.conf!"
        fi
    else
        echo "⚠️  Could not find the configuration file '$CONF_FILE'."
    fi

    # 5. Cleanup traces (Downloads)
    rm -rf /tmp/RONBM

    # 6. Hide GRUB Menu (Fedora Kinoite 41+)
    echo "⚙️  Optimizing Boot Chainload (Hiding GRUB Menu)..."
    grub2-editenv - set menu_auto_hide=1 menu_hide_ok=1 boot_success=1
    
    # Extract auto-hide logic to a separate file
    if [ -f /etc/grub.d/12_menu_auto_hide ]; then
        sh -c '/etc/grub.d/12_menu_auto_hide > /boot/grub2/12_menu_auto_hide.cfg'
    fi
    
    # Integrate logic into main GRUB config (check if not already included)
    if [ -f /boot/grub2/grub.cfg ]; then
        if ! grep -q "12_menu_auto_hide.cfg" /boot/grub2/grub.cfg; then
            echo "source \$prefix/12_menu_auto_hide.cfg" >> /boot/grub2/grub.cfg
        fi
    fi

    echo "🎉 RONBM Theme successfully installed and GRUB successfully hidden! Reboot your PC to see the new rEFInd."
