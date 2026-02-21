# Switch between Graphics Modes (Integrated, Hybrid, VFIO, AsusEgpu, AsusMuxDgpu) using supergfxctl
configure-graphics-mode:
    #!/usr/bin/env bash
    set -e

    if ! command -v supergfxctl &> /dev/null; then
        echo "❌ supergfxctl is not installed or not available in the path!"
        exit 1
    fi

    echo "✨ Please select a graphics mode for your Acer Nitro 5:"
    options=("Power Save (Integrated)" "Balanced (Hybrid)" "Virtual Machine (VFIO)" "External GPU (AsusEgpu)" "Max Performance (AsusMuxDgpu)" "Quit")
    
    PS3="Enter your choice (1-6): "
    select opt in "${options[@]}"
    do
        case $opt in
            "Power Save (Integrated)")
                echo "🔄 Switching to Integrated mode..."
                supergfxctl --mode Integrated
                break
                ;;
            "Balanced (Hybrid)")
                echo "🔄 Switching to Hybrid mode..."
                supergfxctl --mode Hybrid
                break
                ;;
            "Virtual Machine (VFIO)")
                echo "🔄 Switching to VFIO (Virtual Function I/O) mode..."
                supergfxctl --mode Vfio
                break
                ;;
            "External GPU (AsusEgpu)")
                echo "🔄 Switching to External GPU (AsusEgpu) mode..."
                supergfxctl --mode AsusEgpu
                break
                ;;
            "Max Performance (AsusMuxDgpu)")
                echo "🔄 Switching to Dedicated GPU (AsusMuxDgpu) mode..."
                supergfxctl --mode AsusMuxDgpu
                break
                ;;
            "Quit")
                echo "Exiting."
                exit 0
                ;;
            *) echo "⚠️ Invalid option $REPLY, please try again.";;
        esac
    done

    echo "🎉 Graphics mode updated successfully!"
    echo "⚠️  Note: A logout or reboot is usually required for the graphics switch to completely take effect."
