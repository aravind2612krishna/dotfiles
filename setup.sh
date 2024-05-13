#!/bin/sh

# mkdir -p ~/.config/zellij/
rsync --archive --delete zellij/*.kdl ~/.config/zellij
rsync --archive zellij/\.* ~
rsync --archive editorconfig ~/.editorconfig

mkdir -p ~/.vim/pack/osc/start/
(cd ~/.vim/pack/osc/start && [ ! -d "vim-oscyank" ] && git clone https://github.com/ojroques/vim-oscyank)
(cd ~/.vim/pack/osc/start && [ ! -d "vim-oscyank" ] && git clone git@github.com:ojroques/vim-oscyank.git)

echo "set runtimepath+=$(cd vim/; pwd)" > ~/.vimrc
echo "set runtimepath+=$(cd ~/.vim/pack/osc/start/vim-oscyank; pwd)" >> ~/.vimrc
echo "runtime vimrc" >> ~/.vimrc
