#!/bin/sh

# mkdir -p ~/.config/zellij/
rsync --archive --delete zellij/*.kdl ~/.config/zellij
for file in configs/*; do
    fbasename=$(basename "$file")
    (
        set -x
        cp -ui "$file" ~/."$fbasename"
    )
done

mkdir -p ~/.vim/pack/osc/start/
(cd ~/.vim/pack/osc/start && [ ! -d "vim-oscyank" ] && git clone https://github.com/ojroques/vim-oscyank)
(cd ~/.vim/pack/osc/start && [ ! -d "vim-oscyank" ] && git clone git@github.com:ojroques/vim-oscyank.git)

echo "set runtimepath+=$(
    cd vim/
    pwd
)" >~/.vimrc
echo "set runtimepath+=$(
    cd ~/.vim/pack/osc/start/vim-oscyank
    pwd
)" >>~/.vimrc
echo "runtime vimrc" >>~/.vimrc

mkdir -p ~/.config/kitty
cp -r kitty.conf ~/.config/kitty/kitty.conf
