if [[ $- == *i* ]]; then
    # /usr/bin/dnf is a dummy wrapper that opens docs
    alias pacman='/usr/local/bin/dnf'
    alias apt='/usr/local/bin/dnf'
    alias yum='/usr/local/bin/dnf'
fi
