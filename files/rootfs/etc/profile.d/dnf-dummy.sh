if [[ $- == *i* ]]; then
    # /usr/local/bin/dnf is a wrapper that redirects to docs
    alias pacman='/usr/local/bin/dnf'
    alias apt='/usr/local/bin/dnf'
    alias yum='/usr/local/bin/dnf'
fi
