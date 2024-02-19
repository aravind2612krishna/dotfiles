" Basic stuff {{{
let mapleader = ' '            " Leader key
let g:mapleader = ' '          " Leader key
set nocompatible
set hidden                     " Abandoned buffer hide
set noshowmode                 " Status related
set noshowcmd
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
set wrapscan                   " search [don't] wrap
if exists('g:neovide')
    set nolazyredraw
else
    set nolazyredraw
    " set lazyredraw                 " redraw performance
endif
set foldcolumn=0               " fold level column
" set background=dark            " Dark/light background
set termguicolors
set virtualedit=block,onemore  " Allows you to move your cursor off the end of lines while in visual block mode, and allows your cursor to go one space off the end of the line when in normal mode.
set sidescroll=2               " when scrolling past last char outside the screen, number of extra chars to show
" }}}

" completion menu height
set pumheight=4

" encoding related
set encoding=utf-8
set ffs=unix,dos,mac
set ai                         " Auto indent
set si                         " Smart indent
set nowrap                     " Wrap lines

" Open folds for search
set fdo=block,hor,jump,mark,percent,quickfix,search

" Gui related options 
set guioptions-=c  "use console dialogs
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
if has('nvim')
    tnoremap jj 
endif

" Pane switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Tab navigation
map <S-H> :tabprev<cr>
map <S-L> :tabnext<cr>
map <C-S-H> :bprev<cr>
map <C-S-L> :bnext<cr>

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
set linebreak nolist
" set colorcolumn=0

" syntax
syntax on

" vim autocomplete setting
set complete=.,w

" Numbering related
set number
set norelativenumber

" behaviour of makesession command
set sessionoptions=buffers,curdir,tabpages

if exists('g:fvim_loaded') 
    nnoremap <BS> h
endif

" set nobackup " prevents creation of ~files - lsp related
" set nowritebackup

" clipboard
set clipboard=unnamedplus

" completion messages disabling
set shortmess+=c

" histogram based diff
if has('nvim')
    set diffopt=filler,internal,algorithm:patience,indent-heuristic
endif

" open files relative to current path {{{
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
map <leader>c :cd <C-R>=expand("%:p:h") . "/" <CR>
map <leader>w :w <C-R>=expand("%:p:h") . "/" <CR>
" }}}

" Help Neovim check if file has changed on disc
" https://github.com/neovim/neovim/issues/2127
augroup checktime
    autocmd!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
augroup END

set updatetime=500

" mouse
set mouse=a

" signcolumn
" set signcolumn=yes:2

" Loc list and quick fix mappings, putting in basic so that these mappings can
" be overriden by other rcs
nmap <M-n> :lnext<CR>
nmap <M-p> :lprev<CR>
nmap <M-q> :lclose<CR>
nnoremap <M-e> :topleft lopen<CR>

" QuickFix List
nmap <C-n> :cnext<CR>zzzv
nmap <C-p> :cprev<CR>zzzv
nmap <C-q> :cclose<CR>
nnoremap <C-e> :topleft copen<CR>

" augroup CursorLines
"     autocmd!
"     au WinLeave * set nocursorline nocursorcolumn
"     au WinEnter * set cursorline nocursorcolumn
" augroup END


" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
"             \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
"             \,sm:block-blinkwait175-blinkoff150-blinkon175
