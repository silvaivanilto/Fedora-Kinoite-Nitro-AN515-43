# Fedora Kinoite Nitro

Custom **Fedora Kinoite** (Nvidia) image optimized for the Acer Nitro 5 (AN515-43). Designed for stability, battery longevity, and peak performance.

## 🚀 Key Features

This image is built on `ghcr.io/ublue-os/kinoite-nvidia:43` and heavily customized for the Nitro 5 hardware.

### 🎮 Graphics & Performance

* **Base:** `ghcr.io/ublue-os/kinoite-nvidia:43` (Fedora Atomic 43).
* **Nvidia Drivers:** Proprietary drivers pre-installed.
* **supergfxctl:** Hybrid GPU management service enabled for seamless GPU switching.

* **Native Experience:** Uses the native Fedora 43 Plasma Login Manager and system settings.
* **Discover:** Full **rpm-ostree** support enabled within Discover for GUI system management.

### 🔋 Power & Battery Health

* **Nvidia Powerd:** Enabled for dynamic thermal and power balancing.

### 🛠️ Developer & System Tools

* **Default Browser:** **Google Chrome** (RPM) pre-installed and set as default.
* **Terminal:** **Oh My Bash** pre-installed in `/etc/skel` with the **Powerline** theme and productivity plugins (`git`, `bash-completion`).
* **Container Management:** **Distrobox** (pre-installed via ublue base).
* **Homebrew:** Linuxbrew manager pre-installed and configured with daily auto-update/upgrade timers.
* **IDEs & Editor Setup:** Pre-configured settings for the Antigravity Code/VSCodium extension marketplace for all new users.
* **Typography:** Enriched with a comprehensive set of dev-friendly Monospace and Sans fonts (Cascadia Code, Fira, JetBrains Mono, Roboto, NerdFonts, etc.) configured natively via BlueBuild.

### 🖨️ Printing

* **Epson Drivers:** `epson-inkjet-printer-escpr` installed with SHA256 integrity verification for reliability.

### 📦 Clean & Lean System

* **Removed Bloat:** Firefox, SDDM, Kate, and their background dependencies.
* **Stripped Asian Input Methods:** All Fcitx5 components, engines, GTK/Qt integrations and Asian font packs were entirely purged from the base OS to save space and reduce bloat.
* **Plasma Integration:** Extraneous widgets like `supergfxctl-plasmoid` have been stripped (using native ujust/supergfxctl logic instead).
* **KWrite:** Kept as native RPM text editor.
* **Flatpaks:** Flathub (system-wide) configured with a curated selection of KDE apps.

## 📁 Project Structure

```
recipes/
└── recipe.yml                  # Main BlueBuild configuration
files/scripts/
├── swap-display-manager.sh     # Swaps SDDM → Plasma Login Manager
├── install-chrome.sh           # Chrome RPM & default browser config
├── install-antigravity.sh      # Antigravity Auto-Updater
├── install-oh-my-bash.sh       # Custom shell template (/etc/skel)
└── install-epson-escpr.sh      # Driver installation with Hash Check
files/rootfs/
├── etc/rpm-ostreed.conf                 # Automatic update policy
└── etc/skel/.config/Antigravity/User/   # IDE automated defaults
.github/workflows/
├── build.yml                   # CI/CD + Image Signing (Cosign)
└── generate-iso.yml            # Auto-ISO Release generation
```

## 📥 Installation

To rebase an existing Fedora Atomic (Silverblue/Kinoite) installation:

1. **Rebase to the signed image (Recommended):**

    ```bash
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/silvaivanilto/fedora-kinoite-nitro-an515-43:latest
    ```

2. **Reboot:**

    ```bash
    systemctl reboot
    ```

### 🪟 Dual Boot (Windows)

To boot into Windows:

1. **Restart** your computer.
2. Select the **Windows** option in the **rEFInd** boot manager.

## 🔐 Verification & Maintenance

* **Image Signing:** The image is signed with Sigstore/Cosign.
* **Maintenance:** GitHub Actions and build dependencies are automatically updated via **Dependabot**.
* **ISO Release:** Check the "Releases" tab for automatically generated installation ISOs.

---
*Built with ❤️ using [BlueBuild](https://blue-build.org/)*
