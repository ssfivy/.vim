#!/bin/bash

# Setup vim on this linux machine
# make sure you have git and vim installed

# Do stuff that needs sudo first

# shell script linter
APT_TOOLS="shellcheck"
# clangd, a c/c++ language server, version 8 minimum
APT_TOOLS+=" clangd-9"
# powerline fonts to make things pretty
APT_TOOLS+=" fonts-powerline"

echo "$APT_TOOLS" | xargs sudo apt install -y

APT_TOOLS="autopep8 "
APT_TOOLS+="bandit "
APT_TOOLS+="pylint "
APT_TOOLS+="pyflakes "
APT_TOOLS+="flake8 "

echo "$PIP_TOOLS" | xargs pip install  --user

# COnfigure tools
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 9

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
    mv nvim.appimage nvim
    pip3 install neovim
    popd
fi


