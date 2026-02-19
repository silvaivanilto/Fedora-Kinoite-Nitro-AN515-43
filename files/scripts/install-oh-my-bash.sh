#!/bin/bash
set -ouex pipefail

# Config
THEME="powerline"
PLUGINS="git bash-completion extract fzf history-substring-search"

# Install OMB to skel
rm -rf /etc/skel/.oh-my-bash
git clone --depth=1 https://github.com/ohmybash/oh-my-bash.git /etc/skel/.oh-my-bash

# Setup .bashrc
cp /etc/skel/.oh-my-bash/templates/bashrc.osh-template /etc/skel/.bashrc
sed -i "s/OSH_THEME=\"font\"/OSH_THEME=\"$THEME\"/" /etc/skel/.bashrc
sed -i "s/plugins=(git)/plugins=($PLUGINS)/" /etc/skel/.bashrc

# Fedora defaults & Terminal aesthetics
cat <<EOF >> /etc/skel/.bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
printf '\e[4 q'
EOF
