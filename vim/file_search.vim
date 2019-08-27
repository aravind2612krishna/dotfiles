" file finding
" LeaderF/FZF {{{
if v:false " has('nvim')
    Plug 'Yggdroot/LeaderF'
    nnoremap <leader>m :LeaderfMru<CR>
    nnoremap <leader><Space> :LeaderfFile<CR>
    nnoremap <leader>b :LeaderfBuffer<CR>
else
    " FZF {{{
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'pbogut/fzf-mru.vim'
    " }}}
    nnoremap <leader>m :FZFMru<CR>
    nnoremap <leader>f :FZF<CR>
    nnoremap <leader>b :Buffers<CR>
endif
" }}}

" in-file searching
Plug 'skywind3000/asyncrun.vim'

if executable('rg')
    map <leader>r :AsyncRun rg -in <C-R><C-W> <C-R>=expand("%:.:h") <CR>
    copen topleft
else
    if executable('grep')
        map <leader>r :AsyncRun grep -Rn <C-R><C-W> <C-R>=expand("%:p:h") . "/*" <CR>
        copen topleft
    endif
endif
