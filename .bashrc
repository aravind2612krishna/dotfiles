if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

[ -f "$HOME"/sources/dotfiles/configs/bashrc ] && . "$HOME"/sources/dotfiles/configs/bashrc
