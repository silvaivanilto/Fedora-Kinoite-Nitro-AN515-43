# Switch between Graphics Modes using supergfxctl
configure-graphics-mode:
    #!/usr/bin/env bash
    set -e

    if [ "$EUID" -ne 0 ]; then
      echo "Elevating privileges..."
      exec sudo "$0" "$@"
    fi

    if ! command -v supergfxctl &> /dev/null; then
        echo "supergfxctl is not installed or not available in the path!"
        exit 1
    fi

    echo "Please select a graphics mode for your Acer Nitro 5:"
    options=("Power Save" "Balanced" "Virtual Machine" "External GPU" "Max Performance" "Quit")
    
    PS3="Enter your choice (1-6): "
    select opt in "${options[@]}"
    do
        case $opt in
            "Power Save")
                echo "Switching to Integrated mode..."
                supergfxctl --mode Integrated
                break
                ;;
            "Balanced")
                echo "Switching to Hybrid mode..."
                supergfxctl --mode Hybrid
                break
                ;;
            "Virtual Machine")
                echo "Switching to VFIO mode..."
                supergfxctl --mode Vfio
                break
                ;;
            "External GPU")
                echo "Switching to External GPU mode..."
                supergfxctl --mode AsusEgpu
                break
                ;;
            "Max Performance")
                echo "Switching to Dedicated GPU mode..."
                supergfxctl --mode AsusMuxDgpu
                break
                ;;
            "Quit")
                echo "Exiting."
                exit 0
                ;;
            *) echo "Invalid option $REPLY, please try again.";;
        esac
    done

    echo "Graphics mode updated successfully!"
    echo "Note: A logout or reboot is usually required for the graphics switch to completely take effect."
