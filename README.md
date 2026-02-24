# Fedora BlueBuild Nitro (Kinoite)

Custom **Fedora Atomic** (Kinoite/KDE) image optimized for the Acer Nitro 5 (AN515-43) and Nvidia hardware. Designed for maximum stability, battery longevity, and peak performance without bloatware.

## 🚀 Key Features

This image is built on the `ublue-os` ecosystem (`kinoite-nvidia:43`) and heavily stripped down for the Nitro 5's hardware specs constraints and virtues.

### 🎮 Graphics & Performance

* **Nvidia Drivers:** Proprietary drivers pre-installed in the atomic base.
* **RPMFusion Freeworld:** Restricted factory drivers (`mesa-va-drivers`, `mesa-vdpau-drivers`) were swapped for full RPMFusion versions to unlock absolute native hardware acceleration (VA-API/VDPAU) in YouTube and Browsers on your Hybrid AMD/Nvidia GPU.
* **supergfxctl:** Hybrid GPU management service enabled for seamless, glitch-free GPU switching.

### 🔋 Power & Battery Health

* **Nvidia Powerd:** Enabled for dynamic thermal and laptop power balancing.

### 📦 Clean & Lean System (System Debloat)

* **Removed Bloat:** Firefox, Fedora utilities (Toolbox, Firewall Config), and several background/error handlers from Plasma (drkonqi, welcome screen) were purged at the root tree.
* **Intel Firmwares & Blobs Purged:** All Intel ecosystem graphics drivers (media/vaapi) and Wi-Fi/Bluetooth cards (`iwlwifi-*`, `iwlegacy-*`) have been eradicated from the image, saving dozens of megabytes since the Acer Nitro exclusively uses AMD and Nvidia chipsets.
* **Stripped Asian Input Methods & Fonts:** All Fcitx5 components, IBus engines, input base libraries, and unused Noto Asian fonts (Balinese, CJK, Javanese, Sundanese) were purged from the base OS to save space and reduce bloat.
* **Kinoite (KDE):** Removed SDDM (swapped by native Plasma login), and Kate.

### 🛠️ Developer & System Tools

* **Default Browser:** **Google Chrome** (RPM) pre-installed and set as default.
* **Terminal Shell:** **Oh My Bash** pre-installed in `/etc/skel` with the **Powerline** theme and productivity plugins (`git`, `bash-completion`, `fzf`) for all new users.
* **Flatpak Hub:** Native implementation of essential apps running sandboxed by default.
* **Homebrew:** Linuxbrew manager pre-installed (`brew`).
* **IDE Setup:** Pre-configured settings ready for VSCodium.
* **Typography:** Comprehensive set of dev-friendly Monospace and Sans fonts (Cascadia Code, Fira, JetBrains Mono, Roboto, NerdFonts, etc).

### 🧰 Basic CLI Arsenal

The image comes packed with top-tier GNU and TUI utilities pre-installed at the root tree for clean Terminal management:

* **Container Management:**
  * `podman`: RedHat's native daemonless replacement to manage Docker containers through the command line.
  * `buildah` and `skopeo`: To build, inspect, sign, and transfer OCI container images at a native level.
  * `distrobox`: A pillar solution for developers; allows installing any Linux (Ubuntu, Arch) via terminal integrated into your `/home` using containers, accessing software while keeping Fedora untouched.

* **Terminal Productivity:**
  * `tmux`: Terminal multiplexer that allows splitting the same screen into dozens of asynchronous text sessions.
  * `fzf`: *"Fuzzy-finder"* (attached to *Oh My Bash*) for smart navigation and searching files or history metadata via prompt.
  * `jq`: A robust pure C processor to display, slice, and filter data from `.json` files directly in the CLI interface.
  * `xxd`: Hexdump editor, displays and encodes binary content for C/Assembler devs to investigate native binaries.
  * `tree`: Deep listing of the system's organic sub-folder layout in a text diagram.
  * `vim-enhanced` / `nano`: Classic and essential text editors in absolute darkness.

* **Hardware & Monitoring (Monitors and TUIs):**
  * `htop`: Colorful Terminal User Interface (TUI) with graphics support and robust visual meters to measure CPU / RAM.
  * `nvtop`: Essential TUI task manager for the Nitro 5's Nvidia and AMD chips that natively traces the system's graphic stress.
  * `powerstat`: Sensitive power consumption meter; traces pure electrical spikes in exact *Watts* drained from the battery using Kernel integration.
  * `lshw` and `dmidecode`: Bring the raw skeleton with your hardware's ID from the BIOS via full system dumping.
  * `nvme-cli`: Low-level CLI tool that issues deep hardware and temperature reports of your Acer's M.2 SSDs.

* **Network & Internet:**
  * `curl`: Raw transfer or debugging of URLs and headers across multiple protocols directly in the shell.
  * `rsync`: The pillar of Linux backups; massively syncs directories to remote storages keeping perfect hardlinks.
  * `iproute2` (`ip`, `ss`): Native Linux master kit focused on raw manual PC routing.
  * `traceroute`, `mtr`, and `nmap` (`iputils`): Essential probes for raw traffic via IP protocols, measuring hops and checking ports.
  * `bind-utils` (`dig`, `nslookup`): Heavy routing debuggers to test internet resolution on DNS servers.

* **Archivers & Media:**
  * `tar`, `gzip`, `xz`, `bzip2`: Linux core compression system.
  * `7zip`, `zip`, `unzip`: Customized utilities implemented in the recipe to handle hybrid archives brought from Windows culture.
  * `ffmpeg`: Huge and powerful command-line arsenal of codecs to re-encode audio and video or run streaming/scripts via Linux base.

### 🖨️ Printing

* **Epson Drivers:** `epson-inkjet-printer-escpr` injected into the recipe.

## 📁 Project Structure

```
recipes/
└── recipe.yml                  # KDE Plasma environment config
files/scripts/
├── install-chrome.sh           # Chrome RPM & default browser config
├── install-oh-my-bash.sh       # Custom shell template
├── install-epson-escpr.sh      # Driver installation with Hash Check
├── system-cleanup.sh           # GUI cleanup & residue removal
└── swap-display-manager.sh     # SDDM to Plasma Login swap
files/rootfs/
└── etc/                        # System configurations (fonts, xdg)
└── usr/share/ublue-os/just/    # Custom ujust commands
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
