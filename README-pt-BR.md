# Fedora Kinoite Nitro

Imagem customizada do **Fedora Kinoite** (Nvidia) otimizada para o notebook Acer Nitro 5 (AN515-43). Desenvolvida para estabilidade, longevidade de bateria e desempenho máximo.

## 🚀 Principais Recursos

Esta imagem é baseada no `ghcr.io/ublue-os/kinoite-nvidia:43` e fortemente customizada para o hardware Nitro 5.

### 🎮 Gráficos & Desempenho

* **Base:** `ghcr.io/ublue-os/kinoite-nvidia:43` (Fedora Atomic 43).
* **Drivers Nvidia:** Drivers proprietários pré-instalados.
* **supergfxctl:** Serviço de gerenciamento híbrido de GPU habilitado para troca contínua entre placas de vídeo.

* **Experiência Nativa:** Utiliza o Gerenciador de Login Plasma nativo do Fedora 43 e as configurações de sistema.
* **Discover:** Suporte completo ao **rpm-ostree** habilitado dentro do Discover para gerenciamento de sistema via interface gráfica.

### 🔋 Energia & Vida Útil da Bateria

* **Nvidia Powerd:** Habilitado para balanceamento dinâmico térmico e de energia.

### 🛠️ Ferramentas de Desenvolvedor e Sistema

* **Navegador Padrão:** **Google Chrome** (RPM) pré-instalado e definido como padrão.
* **Terminal:** **Oh My Bash** pré-instalado em `/etc/skel` com o tema **Powerline** e plugins de produtividade (`git`, `bash-completion`).
* **Gerenciamento de Contêineres:** **Distrobox** (pré-instalado via ublue base).
* **Homebrew:** Gerenciador Linuxbrew pré-instalado e configurado com atualizações automáticas diárias.
* **Configuração de IDEs e Editores:** Configurações automáticas da loja de extensões para Antigravity Code/VSCodium em novos usuários.
* **Tipografia:** Enriquecida com um conjunto abrangente de fontes Sans e Monospace amigáveis para desenvolvedores (Cascadia Code, Fira, JetBrains Mono, Roboto, NerdFonts, etc.) configuradas nativamente pelo BlueBuild.

### 🖨️ Impressão

* **Drivers Epson:** `epson-inkjet-printer-escpr` instalado com verificação de integridade via SHA256.

### 📦 Sistema Limpo e Enxuto

* **Remoção de Bloatwares:** Firefox, SDDM, Kate e suas dependências em segundo plano foram removidos.
* **Métodos de Entrada Asiáticos Removidos:** Todos os componentes do Fcitx5, motores, integrações GTK/Qt e pacotes de fontes asiáticas foram inteiramente expurgados do sistema base para economizar espaço e reduzir o excesso.
* **Integração Plasma:** Widgets supérfluos como `supergfxctl-plasmoid` foram retirados (usando a lógica nativa do ujust/supergfxctl em seu lugar).
* **KWrite:** Mantido como editor de texto RPM nativo.
* **Flatpaks:** Flathub (focado no sistema) configurado com uma seleção curada de aplicativos KDE.

## 📁 Estrutura do Projeto

```
recipes/
└── recipe.yml                  # Configuração principal do BlueBuild
files/scripts/
├── swap-display-manager.sh     # Troca SDDM → Plasma Login Manager
├── install-chrome.sh           # Instalação e config padrão do Chrome RPM
├── install-antigravity.sh      # Autoupdater do Antigravity
├── install-oh-my-bash.sh       # Template customizado de shell (/etc/skel)
└── install-epson-escpr.sh      # Instalação de drivers c/ checagem de Hash
files/rootfs/
├── etc/rpm-ostreed.conf                 # Política de atualização automática
└── etc/skel/.config/Antigravity/User/   # Padrões automáticos da IDE
.github/workflows/
├── build.yml                   # CI/CD + Assinatura de imagem (Cosign)
└── generate-iso.yml            # Geração de ISO de Instalação Automática
```

## 📥 Instalação

Para fazer rebase de uma instalação existente do Fedora Atomic (Silverblue/Kinoite):

1. **Rebase para a imagem assinada (Recomendado):**

    ```bash
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/silvaivanilto/fedora-kinoite-nitro-an515-43:latest
    ```

2. **Reiniciar:**

    ```bash
    systemctl reboot
    ```

### 🪟 Dual Boot (Windows)

Para inicializar no Windows:

1. **Reinicie** o computador.
2. Selecione a opção **Windows** no gerenciador de boot **rEFInd**.

## 🔐 Verificação e Manutenção

* **Assinatura de Imagem:** A imagem é assinada usando Sigstore/Cosign.
* **Manutenção:** O GitHub Actions e as dependências de build são atualizados automaticamente via **Dependabot**.
* **Lançamentos ISO:** Cheque a aba de "Releases" (Lançamentos) no Github para baixar ISOs de instalação geradas automaticamente.

---
*Construído com ❤️ usando [BlueBuild](https://blue-build.org/)*
