" Neovim Config

" Sourced Files
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/airline.vim
source ~/.config/nvim/coc.vim

" Settings
set relativenumber
set number
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab
set termguicolors
set hidden          " no warning for unsaved files
set updatetime=300
set showmatch       " Moving to matching braces
set matchtime=2
set mat=2
set mouse=a
set hlsearch
set showcmd         " Show command in Status Line
set autoread        " Reloads externally changed files
colorscheme nord
nnoremap <leader>y "+y
set clipboard+=unnamedplus

" Key Bindings
let mapleader = "\<Space>"
nnoremap <leader>s :w<cr>   
nnoremap <leader>x :q!<cr>   
nnoremap <leader>b :wq<cr>   
nnoremap q :q<cr>
map  <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)

inoremap jk <ESC>
inoremap jl <ESC>$a;<ESC>
inoremap jö <ESC>$a{<RETURN>
nnoremap <Tab> %
" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" NerdTree / NerdCommenter
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
let g:NERDTreeGitStatusWithFlags = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeIgnore = ['^node_modules$']

" FZF
map <C-f> <ESC><ESC>:Files!<CR>
map <C-S-F> <ESC><ESC>:Rg!<CR>
inoremap <C-f> <ESC><ESC>:BLines<CR>

" vimtex
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_enable = 1

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" Tag Bar
nmap <F8> :TagbarToggle<CR>

" FAR
set lazyredraw            " improve scrolling performance when navigating through large results
set regexpengine=1        " use old regexp engine
set ignorecase smartcase  " ignore case only when the pattern contains no capital letters

" shortcut for far.vim replace
nnoremap <silent> <F3>  :Farr<cr>
vnoremap <silent> <F3>  :Farr<cr>
nnoremap <F4>  :%s///g<Left><Left>

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-highlight',
  \ 'coc-css',
  \ 'coc-yaml',
  \ 'coc-vetur',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-git', 
  \ 'coc-vimtex', 
  \ 'coc-json', 
  \ ]
