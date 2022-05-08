#!/bin/sh

# Setup vim on this macos machine
# make sure you have git and vim installed

set -xe

# Do stuff that needs sudo first

# shell script linter
#APT_TOOLS="shellcheck"
# clangd, a c/c++ language server, version 8 minimum
#APT_TOOLS+=" clangd-10"
# powerline fonts to make things pretty
#APT_TOOLS+=" fonts-powerline"

#echo "$APT_TOOLS" | xargs sudo -H -E apt install -y

#PIP_TOOLS="autopep8 "
#PIP_TOOLS+="bandit "
#PIP_TOOLS+="pylint "
#PIP_TOOLS+="pyflakes "
#PIP_TOOLS+="flake8 "

#sudo -H -E python3 -m pip install --upgrade pip setuptools wheel
#echo "$PIP_TOOLS" | xargs pip3 install  --user

# COnfigure tools
#sudo -H -E update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-10 10

#create shortcut for bootstrap code
ln -s ~/.vim/vim_bootstrap ~/.vimrc

#shortcut for vimperator
#ln -s ~/.vim/vimperatorrc ~/.vimperatorrc

# shortcut for neovim so it can find this config
mkdir -p "$HOME/.config/nvim"
cat << EOF > "$HOME/.config/nvim/init.vim"
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOF

# Run and install plugins
vim +PlugInstall +qall
