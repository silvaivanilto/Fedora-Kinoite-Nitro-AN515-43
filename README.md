# Fedora Kinoite Nitro (Bleeding Edge)

Custom **Fedora Kinoite** (Nvidia) image optimized for the Acer Nitro 5 (AN515-43). Designed for stability, battery longevity, and peak performance.

## 🚀 Key Features

This image is built on `ghcr.io/ublue-os/kinoite-nvidia:43` and heavily customized for the Nitro 5 hardware.

### 🎮 Graphics & Performance
*   **Base:** `ghcr.io/ublue-os/kinoite-nvidia:43` (Fedora Atomic 43).
*   **Nvidia Drivers:** Proprietary drivers pre-installed with **Dynamic Power Management** enabled (`NVreg_DynamicPowerManagement=0x02`).
*   **Native Experience:** Uses the native Fedora 43 Plasma Login Manager and system settings.
*   **Discover:** Full **rpm-ostree** support enabled within Discover for GUI system management.

### 🔋 Power & Battery Health
*   **TLP:** Advanced power management with specific **Acer Nitro 5 Battery Thresholds** (Start: 75% / Stop: 80%).
*   **TLP-PD:** TLP Power Profiles Daemon (v1.9+) integrated for advanced profile switching.
*   **Nvidia Powerd:** Enabled for dynamic thermal and power balancing.
*   **Radio Management:** `systemd-rfkill` masked to prevent conflicts with TLP's radio state management.

### 🛠️ Developer & System Tools
*   **Default Browser:** **Google Chrome** (RPM) pre-installed and set as default.
*   **Terminal:** **Oh My Bash** pre-installed in `/etc/skel` with the **Powerline** theme and productivity plugins (`git`, `bash-completion`).
*   **Container Management:** **Distrobox** (replaces Toolbox).
*   **Homebrew:** Linuxbrew manager pre-installed and configured with daily auto-update/upgrade timers.
*   **Theme Sync:** Custom systemd service to sync root user theme with the primary user (Wheel group).

### 🖨️ Printing
*   **Epson Drivers:** `epson-inkjet-printer-escpr` installed with SHA256 integrity verification for reliability.

### 📦 Clean & Lean System
*   **Removed Bloat:** Firefox, SDDM, fcitx5, tuned, and Toolbox have been removed.
*   **Flatpaks:** Flathub (system-wide) configured with a curated selection of KDE apps.

## 📁 Project Structure

```
recipes/
└── recipe.yml                  # Main BlueBuild configuration
files/scripts/
├── swap-display-manager.sh     # Swaps SDDM → Plasma Login Manager
├── setup-tlp.sh                # Full TLP setup: repo, packages, config & services
├── install-chrome.sh           # Chrome RPM & default browser config
├── install-antigravity.sh      # Antigravity Auto-Updater
├── install-oh-my-bash.sh       # Custom shell template (/etc/skel)
├── configure-nvidia.sh         # Dynamic Power Management setup
├── setup-root-theme-sync.sh    # Syncs visual settings to root
├── configure-grub.sh           # Atomic-safe GRUB configuration
└── install-epson-escpr.sh      # Driver installation with Hash Check
.github/workflows/
├── build.yml                   # CI/CD + Image Signing (Cosign)
└── generate-iso.yml            # Auto-ISO Release generation
```

## 📥 Installation

To rebase an existing Fedora Atomic (Silverblue/Kinoite) installation:

1.  **Rebase to the signed image (Recommended):**
    ```bash
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/silvaivanilto/fedora-kinoite-nitro-an515-43:latest
    ```

2.  **Reboot:**
    ```bash
    systemctl reboot
    ```

### 🪟 Dual Boot & GRUB
The image is configured to detect other OSs and remember your last boot choice. For this to take effect on an Atomic system, run:
```bash
# For UEFI systems (modern laptops)
sudo grub2-mkconfig -o /etc/grub2-efi.cfg
```

## 🔐 Verification & Maintenance
*   **Image Signing:** The image is signed with Sigstore/Cosign.
*   **Maintenance:** GitHub Actions and build dependencies are automatically updated via **Dependabot**.
*   **ISO Release:** Check the "Releases" tab for automatically generated installation ISOs.

---
*Built with ❤️ using [BlueBuild](https://blue-build.org/)*
