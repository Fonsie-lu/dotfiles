call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'bling/vim-airline'
Plug 'arcticicestudio/nord-vim'
Plug 'easymotion/vim-easymotion'
Plug 'psliwka/vim-smoothie'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'brooth/far.vim'
Plug 'airblade/vim-rooter'

" Initialize plugin system
call plug#end()
