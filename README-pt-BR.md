# Fedora BlueBuild Nitro (Kinoite)

Imagem customizada do **Fedora Atomic** (Kinoite/KDE) otimizada para o notebook Acer Nitro 5 (AN515-43) com hardware Nvidia. Desenvolvida para estabilidade, longevidade de bateria e desempenho máximo sem a presença de bloatwares.

## 🚀 Principais Recursos

A imagem é baseada no ecossistema `ublue-os` (imagem `kinoite-nvidia:43`) e fortemente enxuta para as limitações e virtudes de hardware do Nitro 5.

### 🎮 Gráficos & Desempenho

* **Drivers Nvidia:** Drivers proprietários pré-instalados na base atômica.
* **RPMFusion Freeworld:** Drivers base capados de fábrica (`mesa-va-drivers`, `mesa-vdpau-drivers`) foram substituídos por versões completas do RPMFusion para garantir aceleração de hardware nativa (VA-API/VDPAU) no YouTube e Navegadores usando sua placa Híbrida AMD/Nvidia.
* **supergfxctl:** Serviço de gerenciamento híbrido de GPU habilitado para troca contínua e sem falhas entra as placas de vídeo.

### 🔋 Energia & Vida Útil da Bateria

* **Nvidia Powerd:** Habilitado para balanceamento dinâmico térmico e de energia do Laptop.

### 📦 Sistema Limpo e Enxuto (Debloat)

* **Remoção de Bloatwares:** Firefox, Utilitários do Fedora (Toolbox, Configuração de Firewall) e deamon/handlers secundários do KDE Plasma (drkonqi, tela de boas-vindas) foram removidos na raiz.
* **Firmwares e Blobs Intel Removidos:** Todos os drivers gráficos (media/vaapi), codecs de hardware nativos e placas Wi-Fi/Bluetooth do ecossistema Intel (`iwlwifi-*`, `iwlegacy-*`) foram erradicados da imagem, economizando dezenas de megabytes já que o Acer Nitro utiliza chipsets AMD e Nvidia.
* **Componentes Asiáticos Removidos:** Todos os componentes do Fcitx5, motores do IBus, bibliotecas de métodos de entrada e fontes secundárias Asiáticas (Balinese, CJK, Javanese, Sundanese) foram expurgados do sistema base para economizar espaço e reduzir o excesso gráfico.
* **Kinoite (KDE):** Removidos SDDM (substituído pelo login nativo do Plasma) e o editor Kate.

### 🛠️ Ferramentas de Desenvolvedor e Sistema

* **Navegador Padrão:** **Google Chrome** (RPM) pré-instalado e definido como padrão.
* **Terminal Shell:** **Oh My Bash** pré-instalado em `/etc/skel` com o tema **Powerline** e plugins de produtividade (`git`, `bash-completion`, `fzf`) para todos os novos usuários.
* **Aplicativos Flatpak:** Implementação nativa de aplicativos essenciais rodando por padrão sandboxed via user/Flathub.
* **Homebrew:** Gerenciador Linuxbrew pré-instalado (`brew`).
* **Configuração de IDEs:** Configurações automáticas prontas para VSCodium.
* **Tipografia:** Conjunto abrangente de fontes Sans e Monospace amigáveis para desenvolvedores (Cascadia Code, Fira, JetBrains Mono, Roboto, NerdFonts, etc).

### 🧰 Arsenal CLI Básico

A imagem vêm preparada com os melhores utilitários GNU e TUI pré-instalados na raiz para gerenciamento limpo via Terminal:

* **Gerenciamento de Contêineres:**
  * `podman`: O substituto nativo da RedHat (daemonless) para manipulação de contêineres Docker via linha de comando.
  * `buildah` e `skopeo`: Para construir a nível nativo e inspecionar ou copiar imagens de SO em contêiner ou OCI.
  * `distrobox`: Solução pilar para desenvolvedores; permite instalar qualquer Linux (Ubuntu, Arch) via terminal integrado na sua `/home` usando contêineres e acessar os softwares mantendo o Fedora intocado.

* **Produtividade em Terminal:**
  * `tmux`: Multiplexador de terminal que permite dividir a mesma tela em dezenas de sessões assíncronas em texto.
  * `fzf`: *"Fuzzy-finder"* (anexado ao *Oh My Bash*) para navegação inteligente e buscas de arquivos ou metadados de histórico via prompt.
  * `jq`: Um processador robusto em C puro para exibir, fatiar e filtrar dados de arquivos `.json` diretamente na interface CLI.
  * `xxd`: Editor de hexdump, exibe e codifica conteúdo binário para desenvolvedores C/Assembler investigarem binários nativos.
  * `tree`: Lista profunda do layout orgânico das sub-pastas do sistema em diagrama de texto.
  * `vim-enhanced` / `nano`: Seus clássicos e essenciais editores de texto no escuro absoluto.

* **Monitoramento & Hardware (Monitores e TUI):**
  * `htop`: Terminal User Interface colorido em TUI com suporte a gráficos e medidores visuais robustos para medir Processador (CPU) / RAM.
  * `nvtop`: Essencial TUI task manager para os chips Nvidia e AMD do Nitro 5 que traça o estresse gráfico do sistema nativamente.
  * `powerstat`: Medidor sensível de consumo de energia; traça picos elétricos puros em *Watts* exatos drenados na bateria usando integração no Kernel.
  * `lshw` e `dmidecode`: Trazem o esqueleto bruto com ID do seu hardware pela BIOS através de dumping completo do sistema.
  * `nvme-cli`: Ferramenta CLI de baixo-nível que emite laudos profundos de hardware e temperatura dos SSDs M.2 do seu Acer.

* **Rede & Internet:**
  * `curl`: Transferência bruta ou debug de URLs e cabeçalhos em múltiplos protocolos diretos no shell.
  * `rsync`: O pilar dos backups em Linux; transfere sincronizando massivamente diretórios para armazenamentos remotos mantendo hardlinks perfeitos.
  * `iproute2` (`ip`, `ss`): Kit mestre nativo Linux focado em roteamento bruto manual do PC.
  * `traceroute`, `mtr` e `nmap` (`iputils`): Essenciais sondas para tráfego bruto por protocolos IP, medir saltos e checar de portas.
  * `bind-utils` (`dig`, `nslookup`): Debugadores pesados de roteamento para testar resolução de internet nos servidores DNS.

* **Compactação & Media:**
  * `tar`, `gzip`, `xz`, `bzip2`: Core system de compactação Linux.
  * `7zip`, `zip`, `unzip`: Utilitários customizados e implementados na receita para lidar com arquivos híbridos trazidos da cultura do Windows.
  * `ffmpeg`: Arsenal imenso e poderoso em linha de comando de conversores de código para recodificar áudios e vídeos ou rodar streaming/script via Linux base.

### 🖨️ Impressão

* **Drivers Epson:** `epson-inkjet-printer-escpr` injetado na receita.

## 📁 Estrutura do Projeto

```
recipes/
└── recipe.yml                  # Configuração do ambiente KDE Plasma
files/scripts/
├── install-chrome.sh           # Instalação e config padrão do Chrome RPM
├── install-oh-my-bash.sh       # Template customizado de shell
├── install-epson-escpr.sh      # Instalação de drivers c/ checagem de Hash
├── system-cleanup.sh           # Limpeza de GUI e resíduos do sistema
└── swap-display-manager.sh     # Troca de SDDM para Plasma Login
files/rootfs/
└── etc/                        # Configurações de sistema (fonts, xdg)
└── usr/share/ublue-os/just/    # Comandos ujust customizados
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
    
O sistema pesquisará com segurança em seu SSD, localizará o módulo EFI da Microsoft e o vinculará permanentemente à sua tela de boot com um **tempo de espera de 30 segundos** para escolha do SO. Se algum dia você *formatar/reinstalar o Windows* futuramente, basta rodar este comando novamente para atualizar o novo UUID da partição repavimentada!

## 🔐 Verificação e Lançamentos

* **Assinatura:** A imagem é assinada remotamente usando Sigstore/Cosign.
* **Manutenção Automática:** O GitHub Actions automatiza compilações diárias com as dependências mais recentes.
* **ISOs (Lançamentos):** Acesse a aba de **Releases** no Github para baixar o arquivo `.iso` de instalação física (USB), gerado magicamente na nuvem após o build de sucesso.

---
*Construído com ❤️ usando [BlueBuild](https://blue-build.org/)*
