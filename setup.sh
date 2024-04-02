# mkdir -p ~/.config/zellij/
rsync --archive --delete zellij/*.kdl ~/.config/zellij
rsync --archive zellij/\.* ~
([[ ! -d ~/.vim/pack/osc/start/ ]] && mkdir -p ~/.vim/pack/osc/start/ && cd ~/.vim/pack/osc/start/ && git clone https://github.com/ojroques/vim-oscyank)
rsync --archive .editorconfig ~/.editorconfig
