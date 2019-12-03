" Basic stuff {{{
let mapleader = ','            " Leader key
let g:mapleader = ','          " Leader key
set nocompatible
set hidden                     " Abandoned buffer hide
set noshowmode                 " Status related
set history=500                " depth of command history
set noautoread                 " when file is changed outside vim, auto read?
set laststatus=2
filetype plugin on
filetype indent on
set wildmenu                   " command suggesions in ex
set ruler
set cmdheight=1
set backspace=eol,start,indent " backspace works on eol, indent, etc.
set whichwrap+=<,>,h,l
set ignorecase                 " Ignore case when reading
set smartcase                  " if even one char in searchstr is uppercase it will not ignore case
set hlsearch                   " search highlight
set incsearch                  " search as you type
set lazyredraw                 " redraw performance
set foldcolumn=1               " fold level column
set background=dark            " Dark/light background
set termguicolors
" }}}

" encoding related
set encoding=utf-8
set ffs=unix,dos,mac
set ai                         " Auto indent
set si                         " Smart indent
set nowrap                     " Wrap lines
set fdo-=search                " Open folds for search

" Gui related options 
set guioptions+=c  "use console dialogs
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar 
set guioptions-=e  "tabline like console

" Tab-key related settings 
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" vim settings for c/c++
set cindent 
set cino=t0,:0,(0,N-s
autocmd! FileType cpp setlocal commentstring=//%s
autocmd! FileType c setlocal commentstring=//%s

" remap jj to escape
inoremap jj <Esc>

" Pane switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Tab navigation
map <leader>l :tabnext<cr>
map <leader>k :tabprevious<cr>
map <S-H> :bprev<cr>
map <S-L> :bnext<cr>

" Return to last edit position when opening files
au BufReadPost * if line(" '\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Toggle paste mode on and off
map <leader>o :setlocal paste!<cr>

" save
nnoremap :<S-W><CR> :w<CR>
set foldmethod=marker          " Foldmethod

" textwidth
set tw=0
set fo+=t
set nowrap linebreak nolist
set colorcolumn=108

" syntax
syntax on

" vim autocomplete setting
" set complete-=i " ignore headers
set complete-=t " ignore tags
" set complete-=b " ignore other loaded buffers
" set complete-=u " ignore other unloaded buffers

" Numbering related
set number

" behaviour of makesession command
" set sessionoptions=buffers,curdir,folds,resize,winpos,winsize
set sessionoptions=buffers,curdir

if exists('g:fvim_loaded') 
    nnoremap <BS> h
endif

" set nobackup " prevents creation of ~files - lsp related
" set nowritebackup

" clipboard
" set clipboard=unnamedplus

" completion messages disabling
set shortmess+=c

" histogram based diff
if has('nvim-0.3.2') || has("patch-8.1.0360")
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" open files relative to current path {{{
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
map <leader>c :cd <C-R>=expand("%:p:h") . "/" <CR>
map <leader>w :w <C-R>=expand("%:p:h") . "/" <CR>
" }}}
