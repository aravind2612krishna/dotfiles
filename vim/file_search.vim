" file finding
" LeaderF/FZF {{{

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
" Border style (rounded / sharp / horizontal)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Todo', 'border': 'sharp' } }

" Plug 'Yggdroot/LeaderF'
" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
" Plug 'wincent/command-t'
" Plug 'ctrlpvim/ctrlp.vim'

nnoremap <leader>m :FZFMru<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>b :Buffers<CR>

if has_key(g:plugs, "LeaderF")
    Plug 'Yggdroot/LeaderF'
    let g:Lf_WindowPosition = 'popup'
    nnoremap <leader>m :LeaderfMru<CR>
    nnoremap <leader>f :LeaderfFile<CR>
    nnoremap <leader>b :LeaderfBuffer<CR>
endif

if has_key(g:plugs, "vim-clap")
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
    nnoremap <leader>m :Clap history<CR>
    nnoremap <leader>f :Clap files<CR>
    nnoremap <leader>b :Clap buffers<CR>
endif

" }}}

" in-file searching
Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 8

if executable('rg')
    map <leader>r :AsyncRun rg -in <C-R><C-W> <C-R>=expand("%:.:h") <CR>
else
    if executable('grep')
        map <leader>r :AsyncRun grep -Rn <C-R><C-W> <C-R>=expand("%:p:h") . "/*" <CR>
    endif
endif
