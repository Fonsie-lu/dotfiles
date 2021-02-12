call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'bling/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'psliwka/vim-smoothie'
Plug 'mhinz/vim-startify'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim'
Plug 'airblade/vim-rooter'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
Plug 'ap/vim-css-color'
Plug 'simonsmith/material.vim'

" Plug 'kaicataldo/material.vim'
" Plug 'rafi/awesome-vim-colorschemes'
" Plug 'cocopon/iceberg.vim'
" Plug 'sainnhe/forest-night'
" Plug 'gruvbox-community/gruvbox'
" Plug 'arcticicestudio/nord-vim'

" Initialize plugin system
call plug#end()
