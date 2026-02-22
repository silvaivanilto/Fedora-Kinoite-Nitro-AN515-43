# Fedora BlueBuild Nitro (Kinoite)

Imagem customizada do **Fedora Atomic** (Kinoite/KDE) otimizada para o notebook Acer Nitro 5 (AN515-43) com hardware Nvidia. Desenvolvida para estabilidade, longevidade de bateria e desempenho máximo sem a presença de bloatwares.

## 🚀 Principais Recursos

A imagem é baseada no ecossistema `ublue-os` (imagem `kinoite-nvidia:43`) e fortemente enxuta para as limitações e virtudes de hardware do Nitro 5.

### 🎮 Gráficos & Desempenho

* **Drivers Nvidia:** Drivers proprietários pré-instalados na base atômica.
* **supergfxctl:** Serviço de gerenciamento híbrido de GPU habilitado para troca contínua e sem falhas entra as placas de vídeo.

### 🔋 Energia & Vida Útil da Bateria

* **Nvidia Powerd:** Habilitado para balanceamento dinâmico térmico e de energia do Laptop.

### 📦 Sistema Limpo e Enxuto (Debloat)

* **Remoção de Bloatwares:** Firefox, gerenciadores de virtualização (hyperv, vbox), drivers Intel sem utilidade, pacotes iOS, entre outros daemons em segundo plano foram removidos na raiz.
* **Métodos de Entrada Asiáticos Removidos:** Todos os componentes do Fcitx5 foram expurgados do sistema base para economizar espaço e reduzir o excesso gráfico.
* **Kinoite (KDE):** Removidos SDDM (substituído pelo login Plasma nativo), Discover (configurado apenas para uso de Flatpaks) e Kate.

### 🛠️ Ferramentas de Desenvolvedor e Sistema

* **Navegador Padrão:** **Google Chrome** (RPM) pré-instalado e definido como padrão.
* **Terminal:** **Oh My Bash** pré-instalado em `/etc/skel` com o tema **Powerline** e plugins de produtividade (`git`, `bash-completion`) para todos os novos usuários.
* **Aplicativos Flatpak:** Implementação nativa de aplicativos essenciais rodando por padrão sandboxed via user/Flathub.
* **Homebrew:** Gerenciador Linuxbrew pré-instalado.
* **Configuração de IDEs:** Configurações automáticas prontas para Antigravity Code / VSCodium.
* **Tipografia:** Conjunto abrangente de fontes Sans e Monospace amigáveis para desenvolvedores (Cascadia Code, Fira, JetBrains Mono, Roboto, NerdFonts, etc).

### 🖨️ Impressão

* **Drivers Epson:** `epson-inkjet-printer-escpr` injetado na receita.

## 📁 Estrutura do Projeto

```
recipes/
└── recipe.yml                  # Configuração do ambiente KDE Plasma
files/scripts/
├── install-chrome.sh           # Instalação e config padrão do Chrome RPM
├── install-antigravity.sh      # Autoupdater do Antigravity
├── install-oh-my-bash.sh       # Template customizado de shell (/etc/skel)
└── install-epson-escpr.sh      # Instalação de drivers c/ checagem de Hash
files/rootfs/
└── etc/skel/.config/Antigravity/User/   # Padrões automáticos da IDE
.github/workflows/
├── build.yml                   # CI/CD
└── generate-iso.yml            # Geração de ISO da imagem
```

## 📥 Instalação (Rebase)

Para fazer rebase de uma instalação existente do Fedora Atomic mantendo seus arquivos:

```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/silvaivanilto/fedora-kinoite-nitro-an515-43:latest
```

**Reinicie o PC:**
```bash
systemctl reboot
```

### 🪟 Dual Boot (Windows & GRUB)

A partir do Fedora Kinoite 41+, o gerenciador de boot GRUB tornou-se estático e ignora varreduras de outros sistemas operacionais por padrão. Para trazer com segurança a opção de boot do Windows de volta para a sua tela inicial do GRUB, preparamos um comando `ujust` automatizado focado em mapeamento imutável de UUID:

1. **Inicie o seu sistema Fedora Kinoite recém-instalado.**
2. **Abra o Terminal e rode:**
    ```bash
    ujust configure-grub-windows
    ```
    
O sistema pesquisará com segurança em seu SSD, localizará o módulo EFI da Microsoft e o vinculará permanentemente à sua tela de boot. Se algum dia você *formatar/reinstalar o Windows* futuramente, basta rodar este recortes comando novamente para atualizar o novo UUID da partição repavimentada!

## 🔐 Verificação e Lançamentos

* **Assinatura:** A imagem é assinada remotamente usando Sigstore/Cosign.
* **Manutenção Automática:** O GitHub Actions automatiza compilações diárias com as dependências mais recentes.
* **ISOs (Lançamentos):** Acesse a aba de **Releases** no Github para baixar o arquivo `.iso` de instalação física (USB), gerado magicamente na nuvem após o build de sucesso.

---
*Construído com ❤️ usando [BlueBuild](https://blue-build.org/)*
