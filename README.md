# Fedora Kinoite Nitro (Bleeding Edge)

Custom **Fedora Kinoite** (Nvidia) image optimized for the Acer Nitro 5 (AN515-43). Designed for stability, battery longevity, and peak performance.

## 🚀 Key Features

This image is built on `ghcr.io/ublue-os/kinoite-nvidia:43` and heavily customized for the Nitro 5 hardware.

### 🎮 Graphics & Performance
*   **Base:** `ghcr.io/ublue-os/kinoite-nvidia:43` (Fedora Atomic 43).
*   **Nvidia Drivers:** Proprietary drivers pre-installed with **Dynamic Power Management** enabled (`NVreg_DynamicPowerManagement=0x02`).
*   **supergfxctl:** Hybrid GPU management service enabled for seamless GPU switching.
*   **KDE Bleeding Edge:** Plasma packages updated from the `@kdesig/kde-beta` COPR at every build.
*   **Native Experience:** Uses the native Fedora 43 Plasma Login Manager and system settings.
*   **Discover:** Full **rpm-ostree** support enabled within Discover for GUI system management.

### 🔋 Power & Battery Health
*   **Nvidia Powerd:** Enabled for dynamic thermal and power balancing.

### 🛠️ Developer & System Tools
*   **Default Browser:** **Google Chrome** (RPM) pre-installed and set as default.
*   **Terminal:** **Oh My Bash** pre-installed in `/etc/skel` with the **Powerline** theme and productivity plugins (`git`, `bash-completion`).
*   **Container Management:** **Distrobox** (replaces Toolbox).
*   **Homebrew:** Linuxbrew manager pre-installed and configured with daily auto-update/upgrade timers.
*   **Theme Sync:** Custom systemd service to sync root user theme with the primary user (Wheel group).

### 🖨️ Printing
*   **Epson Drivers:** `epson-inkjet-printer-escpr` installed with SHA256 integrity verification for reliability.

### 📦 Clean & Lean System
*   **Removed Bloat:** Firefox, SDDM, Kate, fcitx5, and Toolbox have been removed.
*   **KWrite Flatpak:** KWrite installed via Flathub for easier updates.
*   **Flatpaks:** Flathub (system-wide) configured with a curated selection of KDE apps.

## 📁 Project Structure

```
recipes/
└── recipe.yml                  # Main BlueBuild configuration
files/scripts/
├── swap-display-manager.sh     # Swaps SDDM → Plasma Login Manager
├── install-chrome.sh           # Chrome RPM & default browser config
├── install-antigravity.sh      # Antigravity Auto-Updater
├── install-oh-my-bash.sh       # Custom shell template (/etc/skel)
├── configure-nvidia.sh         # Dynamic Power Management setup
├── setup-root-theme-sync.sh    # Syncs visual settings to root
├── install-epson-escpr.sh      # Driver installation with Hash Check
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

### 🪟 Dual Boot (Windows)
To quickly reboot into Windows from Fedora:

1.  Open a terminal.
2.  Run the command:
    ```bash
    boot-windows
    ```
    *(This sets the EFI `BootNext` variable to Windows and restarts immediately)*

**Implementation Details:**
- **Script:** `/usr/bin/boot-windows` (executable via `chmod +x` in post-install).
- **Logic:** Uses `efibootmgr` to find the Windows boot entry index and sets it for the next boot.
- **Permissions:** Configured via `/etc/sudoers.d/efibootmgr-config` to allow `wheel` group execution without password.
- **Automation:** Managed via `just setup-dual-boot` (recipe in `/usr/share/ublue-os/just/86-custom-windows.just`).

## 🔐 Verification & Maintenance
*   **Image Signing:** The image is signed with Sigstore/Cosign.
*   **Maintenance:** GitHub Actions and build dependencies are automatically updated via **Dependabot**.
*   **ISO Release:** Check the "Releases" tab for automatically generated installation ISOs.

---
*Built with ❤️ using [BlueBuild](https://blue-build.org/)*
