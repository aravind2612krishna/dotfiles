" file finding
" LeaderF/FZF {{{

" FZF {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
" }}}

let useLeaderF = v:false
let useClap = v:false

if has('nvim') && has('win32')
    let useLeaderF = v:false
    let useClap = v:true
endif

if useLeaderF
    Plug 'Yggdroot/LeaderF'
    let g:Lf_WindowPosition = 'popup'
    nnoremap <leader>m :LeaderfMru<CR>
    nnoremap <leader>f :LeaderfFile<CR>
    nnoremap <leader>b :LeaderfBuffer<CR>
elseif useClap
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
    nnoremap <leader>m :Clap history<CR>
    nnoremap <leader>f :Clap files<CR>
    nnoremap <leader>b :Clap buffers<CR>
else
    nnoremap <leader>m :FZFMru<CR>
    nnoremap <leader>f :FZF<CR>
    nnoremap <leader>b :Buffers<CR>
    " general
    " let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
    " let $FZF_DEFAULT_OPTS="--reverse " " top to bottom
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
