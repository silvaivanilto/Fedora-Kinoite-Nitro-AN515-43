# Fedora BlueBuild Nitro (Kinoite & Silverblue)

Imagens customizadas do **Fedora Atomic** (Kinoite/KDE e Silverblue/GNOME) otimizadas para o notebook Acer Nitro 5 (AN515-43) com hardware Nvidia. Desenvolvidas para estabilidade, longevidade de bateria e desempenho máximo sem a presença de bloatwares.

## 🚀 Principais Recursos

As imagens são baseadas no ecossistema `ublue-os` (imagens `kinoite-nvidia:43` e `silverblue-nvidia:43`) e fortemente enxutas para as limitações e virtudes de hardware do Nitro 5.

### 🎮 Gráficos & Desempenho

* **Drivers Nvidia:** Drivers proprietários pré-instalados na base atômica.
* **supergfxctl:** Serviço de gerenciamento híbrido de GPU habilitado para troca contínua e sem falhas entra as placas de vídeo.

### 🔋 Energia & Vida Útil da Bateria

* **Nvidia Powerd:** Habilitado para balanceamento dinâmico térmico e de energia do Laptop.

### 📦 Sistema Limpo e Enxuto (Debloat)

* **Remoção de Bloatwares:** Firefox, gerenciadores de virtualização (hyperv, vbox), drivers Intel sem utilidade, pacotes iOS, entre outros daemons em segundo plano foram removidos na raiz.
* **Métodos de Entrada Asiáticos Removidos:** Todos os componentes do Fcitx5 (no Kinoite) e IBus asian specs (no Silverblue) foram expurgados do sistema base para economizar espaço e reduzir o excesso gráfico.
* **Kinoite (KDE):** Removidos SDDM (substituído pelo login Plasma nativo), Discover (configurado via rpm-ostree backend) e Kate.
* **Silverblue (GNOME):** Extensões antigas do GNOME Classic, GNOME Tour e o pesado `gnome-software` foram completamente varridos da base imutável.

### 🛠️ Ferramentas de Desenvolvedor e Sistema

* **Navegador Padrão:** **Google Chrome** (RPM) pré-instalado e definido como padrão.
* **Terminal:** **Oh My Bash** pré-instalado em `/etc/skel` com o tema **Powerline** e plugins de produtividade (`git`, `bash-completion`) para todos os novos usuários.
* **Lojas Otimizadas:** Para o uso de flatpaks, o Silverblue utiliza nativamente o novo e levíssimo **Bazaar** (via Flathub) em substituição aos travamentos da loja GNOME padrão.
* **Extensões do GNOME:** O Silverblue já possui implementado nativamente extensões essenciais como: Rudra, Panel Color Matcher, Status Tray, Kiwi Menu e Mosaic.
* **Aplicativos Flatpak (Trabalho/GNOME Circle):** Implementação nativa da suíte LibreOffice em flatpak, além de Foliate, Komikku, TextEditor, Papers, Snapshot e demais ferramentas de escritório rodando por padrão sandboxed via user/Flathub.
* **Homebrew:** Gerenciador Linuxbrew pré-instalado.
* **Configuração de IDEs:** Configurações automáticas prontas para Antigravity Code / VSCodium.
* **Tipografia:** Conjunto abrangente de fontes Sans e Monospace amigáveis para desenvolvedores (Cascadia Code, Fira, JetBrains Mono, Roboto, NerdFonts, etc).

### 🖨️ Impressão

* **Drivers Epson:** `epson-inkjet-printer-escpr` injetado na receita.

## 📁 Estrutura do Projeto

```
recipes/
├── kinoite-recipe.yml          # Configuração do ambiente KDE Plasma
└── silverblue-recipe.yml       # Configuração do ambiente GNOME
files/scripts/
├── install-chrome.sh           # Instalação e config padrão do Chrome RPM
├── install-antigravity.sh      # Autoupdater do Antigravity
├── install-oh-my-bash.sh       # Template customizado de shell (/etc/skel)
└── install-epson-escpr.sh      # Instalação de drivers c/ checagem de Hash
files/rootfs/
├── etc/rpm-ostreed.conf                 # Política de atualização automática
└── etc/skel/.config/Antigravity/User/   # Padrões automáticos da IDE
.github/workflows/
├── build.yml                   # CI/CD (Matriz de build Kinoite/Silverblue)
└── generate-iso.yml            # Geração de ISO das duas imagens
```

## 📥 Instalação (Rebase)

Para fazer rebase de uma instalação existente do Fedora Atomic mantendo seus arquivos:

1. **Escolha sua Interface Gráfica:**

    **Para Kinoite (KDE):**
    ```bash
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/silvaivanilto/fedora-kinoite-nitro-an515-43:latest
    ```

    **Para Silverblue (GNOME):**
    ```bash
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/silvaivanilto/fedora-silverblue-nitro-an515-43:latest
    ```

2. **Reinicie o PC:**
    ```bash
    systemctl reboot
    ```

### 🪟 Dual Boot (Windows)

Para inicializar no Windows:
1. **Reinicie** o computador.
2. Selecione a opção **Windows** no gerenciador de boot secundário **rEFInd**.

## 🔐 Verificação e Lançamentos

* **Assinatura:** As imagens são assinadas remotamente usando Sigstore/Cosign.
* **Manutenção Automática:** O GitHub Actions automatiza compilações diárias com as dependências mais recentes.
* **ISOs (Lançamentos):** Acesse a aba de **Releases** no Github para baixar arquivos `.iso` de instalação física (USB) tanto para o Kinoite quanto para o Silverblue, gerados magicamente na nuvem após os builds de sucesso.

---
*Construído com ❤️ usando [BlueBuild](https://blue-build.org/)*
