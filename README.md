# Fedora BlueBuild Nitro (Kinoite & Silverblue)

Custom **Fedora Atomic** (Kinoite/KDE and Silverblue/GNOME) images optimized for the Acer Nitro 5 (AN515-43) and Nvidia hardware. Designed for maximum stability, battery longevity, and peak performance without bloatware.

## 🚀 Key Features

These images are built on the `ublue-os` ecosystem (`kinoite-nvidia:43` and `silverblue-nvidia:43`) and heavily stripped down for the Nitro 5's hardware specs constraints and virtues.

### 🎮 Graphics & Performance

* **Nvidia Drivers:** Proprietary drivers pre-installed in the atomic base.
* **supergfxctl:** Hybrid GPU management service enabled for seamless, glitch-free GPU switching.

### 🔋 Power & Battery Health

* **Nvidia Powerd:** Enabled for dynamic thermal and laptop power balancing.

### 📦 Clean & Lean System (System Debloat)

* **Removed Bloat:** Firefox, virtualization managers (hyperv, vbox), useless Intel drivers, iOS packages, and several background daemons were purged at the root tree.
* **Stripped Asian Input Methods:** All Fcitx5 components (Kinoite) and IBus Asian specs (Silverblue) were purged from the base OS to save space and reduce bloat.
* **Kinoite (KDE):** Removed SDDM (swapped by native Plasma login), Discover (configured via rpm-ostree backend) and Kate.
* **Silverblue (GNOME):** Outdated GNOME Classic extensions, GNOME Tour, and the resource-heavy `gnome-software` were entirely swept from the immutable base.

### 🛠️ Developer & System Tools

* **Default Browser:** **Google Chrome** (RPM) pre-installed and set as default.
* **Terminal:** **Oh My Bash** pre-installed in `/etc/skel` with the **Powerline** theme and productivity plugins (`git`, `bash-completion`) for all new users.
* **Optimized Software Stores:** On Silverblue, Flatpaks are handled natively by the new, lightweight **Bazaar** (via Flathub) instead of the freezing standard GNOME retail store.
* **GNOME Extensions:** Silverblue comes natively packed with essential tools: Rudra, Panel Color Matcher, Status Tray, Kiwi Menu, and Mosaic.
* **Flatpak Hub (Work/GNOME Circle):** Native implementation of the LibreOffice suite under flatpak, plus Foliate, Komikku, TextEditor, Papers, Snapshot, and other office/productivity tools running sandboxed by default.
* **Homebrew:** Linuxbrew manager pre-installed.
* **IDE Setup:** Pre-configured settings ready for Antigravity Code / VSCodium.
* **Typography:** Comprehensive set of dev-friendly Monospace and Sans fonts (Cascadia Code, Fira, JetBrains Mono, Roboto, NerdFonts, etc).

### 🖨️ Printing

* **Epson Drivers:** `epson-inkjet-printer-escpr` injected into the recipe.

## 📁 Project Structure

```
recipes/
├── kinoite-recipe.yml          # KDE Plasma environment config
└── silverblue-recipe.yml       # GNOME environment config
files/scripts/
├── install-chrome.sh           # Chrome RPM & default browser config
├── install-antigravity.sh      # Antigravity Auto-Updater
├── install-oh-my-bash.sh       # Custom shell template (/etc/skel)
└── install-epson-escpr.sh      # Driver installation with Hash Check
files/rootfs/
├── etc/rpm-ostreed.conf                 # Automatic update policy
└── etc/skel/.config/Antigravity/User/   # IDE automated defaults
.github/workflows/
├── build.yml                   # CI/CD (Kinoite & Silverblue Build Matrix)
└── generate-iso.yml            # Auto-ISO Release generation for both
```

## 📥 Installation (Rebase)

To rebase an existing Fedora Atomic installation while keeping your personal files:

1. **Choose your Desktop Environment:**

    **For Kinoite (KDE):**
    ```bash
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/silvaivanilto/fedora-kinoite-nitro-an515-43:latest
    ```

    **For Silverblue (GNOME):**
    ```bash
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/silvaivanilto/fedora-silverblue-nitro-an515-43:latest
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

* **Image Signing:** The images are signed with Sigstore/Cosign.
* **Maintenance:** GitHub Actions automates daily builds incorporating the latest dependencies.
* **ISO Releases:** Check the GitHub "Releases" tab to download physical installation `.iso` files (payable to USB) for both Kinoite and Silverblue, magically generated in the cloud after successful builds.

---
*Built with ❤️ using [BlueBuild](https://blue-build.org/)*
