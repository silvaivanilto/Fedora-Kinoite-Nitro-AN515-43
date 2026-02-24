# Fedora BlueBuild Nitro (Kinoite)

Imagem customizada do **Fedora Atomic** (Kinoite/KDE) otimizada para o notebook Acer Nitro 5 (AN515-43) com hardware Nvidia. Desenvolvida para estabilidade, longevidade de bateria e desempenho máximo sem a presença de bloatwares.

## 🚀 Principais Recursos

A imagem é baseada no ecossistema **ublue-os** (`kinoite-nvidia:43`), herdando sua base sólida e sendo fortemente otimizada para o hardware do Nitro 5.

### 🍱 Herança ublue-os (Nativo)

* **Drivers Nvidia:** Drivers proprietários pré-instalados na base atômica.
* **Serviços:** `supergfxctl` (troca de GPU) e `nvidia-powerd` (balanço térmico) já configurados.
* **Homebrew:** Gerenciador Linuxbrew nativo (`brew`).

### 🛠️ Nossas Otimizações (Nitro 5)

* **Debloat de Sistema:** 
    * **Remoção de Bloatwares:** Firefox e utilitários Fedora removidos na raiz.
    * **Limpeza de Hardware:** Erradicamos drivers e firmwares Intel para economizar espaço, já que o Nitro 5 é AMD/Nvidia.

* **Limpeza de Localização:** Purga de métodos de entrada e fontes asiáticas.
* **Software Customizado:** 
    * **Google Chrome:** Instalação automatizada via RPM.
    * **Oh My Bash:** Pré-configurado em `/etc/skel`.
    * **Antigravity:** Serviço de auto-atualização do sistema.
    * **Impressoras:** Drivers Epson (`escpr`) com verificação de hash.
* **Faxina:** Remoção de resíduos do sistema e ícones inúteis da GUI.

### 🧰 Arsenal CLI Nativo (Base Ublue)

Como parte do ecossistema Ublue, a imagem inclui utilitários de ponta pré-instalados na raiz:

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
├── install-antigravity.sh      # Autoupdater do Antigravity
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
