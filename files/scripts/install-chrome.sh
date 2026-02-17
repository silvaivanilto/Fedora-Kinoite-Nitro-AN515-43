#!/bin/bash
set -ouex pipefail

# Add Google Chrome repository
cat <<EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF

# Install Google Chrome
rpm-ostree install google-chrome-stable

# Set Chrome as default browser for new users
mkdir -p /etc/skel/.config
cat <<EOF > /etc/skel/.config/mimeapps.list
[Default Applications]
x-scheme-handler/http=google-chrome.desktop
x-scheme-handler/https=google-chrome.desktop
text/html=google-chrome.desktop
application/xhtml+xml=google-chrome.desktop
EOF
