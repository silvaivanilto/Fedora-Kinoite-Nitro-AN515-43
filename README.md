# Fedora BlueBuild Nitro (Kinoite)

Custom **Fedora Atomic** (Kinoite/KDE) image optimized for the Acer Nitro 5 (AN515-43) and Nvidia hardware. Designed for maximum stability, battery longevity, and peak performance without bloatware.

## 🚀 Key Features

This image is built on the `ublue-os` ecosystem (`kinoite-nvidia:43`) and heavily stripped down for the Nitro 5's hardware specs constraints and virtues.

### 🎮 Graphics & Performance

* **Nvidia Drivers:** Proprietary drivers pre-installed in the atomic base.
* **supergfxctl:** Hybrid GPU management service enabled for seamless, glitch-free GPU switching.

### 🔋 Power & Battery Health

* **Nvidia Powerd:** Enabled for dynamic thermal and laptop power balancing.

### 📦 Clean & Lean System (System Debloat)

* **Removed Bloat:** Firefox, Fedora utilities (Toolbox, Firewall Config), and several background/error handlers from Plasma (drkonqi, welcome screen) were purged at the root tree.
* **Stripped Asian Input Methods & Fonts:** All Fcitx5 components, IBus engines, input base libraries, and unused Noto Asian fonts (Balinese, CJK, Javanese, Sundanese) were purged from the base OS to save space and reduce bloat.
* **Kinoite (KDE):** Removed SDDM (swapped by native Plasma login), and Kate.

### 🛠️ Developer & System Tools

* **Default Browser:** **Google Chrome** (RPM) pre-installed and set as default.
* **Terminal:** **Oh My Bash** pre-installed in `/etc/skel` with the **Powerline** theme and productivity plugins (`git`, `bash-completion`) for all new users.
* **Flatpak Hub:** Native implementation of essential apps running sandboxed by default.
* **Homebrew:** Linuxbrew manager pre-installed.
* **IDE Setup:** Pre-configured settings ready for Antigravity Code / VSCodium.
* **Typography:** Comprehensive set of dev-friendly Monospace and Sans fonts (Cascadia Code, Fira, JetBrains Mono, Roboto, NerdFonts, etc).

### 🖨️ Printing

* **Epson Drivers:** `epson-inkjet-printer-escpr` injected into the recipe.

## 📁 Project Structure

```
recipes/
└── recipe.yml                  # KDE Plasma environment config
files/scripts/
├── install-chrome.sh           # Chrome RPM & default browser config
├── install-antigravity.sh      # Antigravity Auto-Updater
├── install-oh-my-bash.sh       # Custom shell template (/etc/skel)
└── install-epson-escpr.sh      # Driver installation with Hash Check
files/rootfs/
└── etc/skel/.config/Antigravity/User/   # IDE automated defaults
.github/workflows/
├── build.yml                   # CI/CD
└── generate-iso.yml            # Auto-ISO Release generation
```

## 📥 Installation (Rebase)

To rebase an existing Fedora Atomic installation while keeping your personal files:

```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/silvaivanilto/fedora-kinoite-nitro-an515-43:latest
```

**Reboot:**
```bash
systemctl reboot
```

### 🪟 Dual Boot (Windows & GRUB)

Since Fedora Kinoite 41+, the GRUB bootloader is statically chained and hides other OS probing by default. To securely bring the Windows boot option back to your main GRUB screen, an automated `ujust` command was built to dynamically map its UUID:

1. **Boot into your newly installed Fedora Kinoite system.**
2. **Open the Terminal and run:**
    ```bash
    ujust configure-grub-windows
    ```
    
The system will safely search your drive, locate the Microsoft EFI module, and link it permanently to your boot screen with a **30-second timeout** for OS selection. If you ever *format/reinstall Windows* in the future, simply run this command again to update the new partition UUID!

## 🔐 Verification & Maintenance

* **Image Signing:** The images are signed with Sigstore/Cosign.
* **Maintenance:** GitHub Actions automates daily builds incorporating the latest dependencies.
* **ISO Releases:** Check the GitHub "Releases" tab to download physical installation `.iso` files for Kinoite, magically generated in the cloud after successful builds.

---
*Built with ❤️ using [BlueBuild](https://blue-build.org/)*
