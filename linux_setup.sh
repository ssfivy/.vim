#!/bin/bash

# Setup vim on this linux machine
# make sure you have git and vim installed

# Do stuff that needs sudo first

# shell script linter
APT_TOOLS="shellcheck"
# clangd, a c/c++ language server, version 8 minimum
APT_TOOLS+="clang-tools-9"
# powerline fonts to make things pretty
APT_TOOLS+="fonts-powerline"

sudo apt install "$APT_TOOLS"

#install vundle, our vim plugin manager
#git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#tell vundle to download all our plugins
vim +PluginInstall +qall

#create shortcut for bootstrap code
ln -s ~/.vim/vim_bootstrap ~/.vimrc

#shortcut for vimperator
ln -s ~/.vim/vimperatorrc ~/.vimperatorrc

# shortcut for neovim so it can find this config
mkdir -p "$HOME/.config/nvim"
cat << EOF >> "$HOME/.config/nvim/init.vim"
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOF

# install neovim if bin dir exist and neovim not yet present
if [[ ( -d "$HOME/bin") && ( ! -x "$HOME/bin/nvim.appimage")  ]]; then
    pushd "$HOME/bin"
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod u+x nvim.appimage
    popd
fi


