# vim: set ft=make :

# Configura o sistema para permitir a troca de boot para o Windows
[group("system")]
setup-dual-boot:
    echo "Configurando efibootmgr para uso sem senha..."
    # Apenas garante que o arquivo de sudoers existe (o build já o coloca lá, mas isto garante a aplicação)
    sudo chmod 440 /etc/sudoers.d/efibootmgr-config
    echo "Pronto! Agora você pode usar o comando 'boot-windows' no terminal."