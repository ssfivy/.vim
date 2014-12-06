# Setup vim on this linux machine
# make sure you have git and vim installed

#install vundle, our vim plugin manager
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle

#tell vundle to download all our plugins
vim +PluginInstall +qall

#create shortcut for bootstrap code
ln -s ~/.vim/vim_bootstrap ~/.vimrc

#shortcut for vimperator
ln -s ~/.vim/vimperatorrc ~/.vimperatorrc
