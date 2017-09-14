call plug#begin('~/.config/nvim/plugged')

" Install fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Install NERDtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Install ag
Plug 'rking/ag.vim'

call plug#end()

" Converts tabs to 2 spaces
set tabstop=2 shiftwidth=2 expandtab
