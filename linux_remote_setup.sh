#!/bin/bash

# Setup vim on this linux machine
# make sure you have git and vim installed

set -xe

#create shortcut for bootstrap code
#ln -s ~/.vim/vim_bootstrap ~/.vimrc

nvim_shortcut() {
# shortcut for neovim so it can find this config
mkdir -p "$HOME/.config/nvim"
cat << EOF >> "$HOME/.config/nvim/init.vim"
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOF
}

nvim_install() {
# install neovim if bin dir exist and neovim not yet present
mkdir -p "$HOME/bin"
if [[ ( ! -x "$HOME/bin/nvim")  ]]; then
    pushd "$HOME/bin"
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod u+x nvim.appimage
    mv nvim.appimage nvim
    #pip3 install neovim
    popd
fi
}

plugin_install() {
# Run and install plugins
vim +PlugInstall +qall
}

nvim_shortcut
nvim_install
