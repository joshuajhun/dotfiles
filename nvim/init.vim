" Share config with Vim: reuse ~/.vim as the runtime path and load ~/.vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
