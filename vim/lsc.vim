" lsc
Plug 'natebosch/vim-lsc'

" Formatting

" {{{ vim-clang-format
" Plug 'rhysd/vim-clang-format'
" Plug 'Kypert/vim-clang-format', { 'branch' : 'fix/issues/98' }
" Plug 'kana/vim-operator-user'
" }}}

" {{{ neoformat
" Plug 'sbdchd/neoformat'
" let g:neoformat_try_formatprg = 1
" let g:neoformat_only_msg_on_error = 1
" " let g:neoformat_enabled_python = ['autopep8', 'yapf', 'docformatter']
" let g:neoformat_enabled_python = ['black']
" let g:neoformat_enabled_cpp = ['clang-format']
" let g:neoformat_enabled_c = ['clang-format']
" }}}

" {{{ vim-auto-format
Plug 'Chiel92/vim-autoformat'
nnoremap ,gq :Autoformat<CR>
xnoremap ,gq :Autoformat<CR>
" }}}

set completeopt-=preview
set complete=.,w

" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'
" imap <expr> <silent> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" imap <expr> <silent> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" smap <expr> <silent> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" imap <expr> <silent> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <silent> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" imap <expr> <silent> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" smap <expr> <silent> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
let g:lsc_auto_map = v:true
let g:lsc_reference_highlights = v:true
let s:ccls_cache_dir = g:storage_home . '/ccls-cache'
let g:lsc_server_commands = {
            \ 'cpp': {
            \    'command': 'ccls',
            \    'suppress_stderr': v:true,
            \    'message_hooks': {
            \        'initialize': {
            \            'initializationOptions': {'index': {'threads': 4},
            \                                      'highlight': { 'lsRanges' : v:true },
            \                                      'cache': {'directory': s:ccls_cache_dir}
            \                                     },
            \            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
            \        },
            \    },
            \  },
            \ 'c': {
            \    'command': 'ccls',
            \    'suppress_stderr': v:true,
            \    'message_hooks': {
            \        'initialize': {
            \            'initializationOptions': {'index': {'threads': 4}, 
            \                                      'highlight': { 'lsRanges' : v:true },
            \                                      'cache': {'directory': s:ccls_cache_dir}
            \                                     },
            \            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
            \        },
            \    },
            \  },
            \ 'python' : 'pyls',
            \}

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'hrsh7th/deoplete-vim-lsc'
" " Deoplete
" set cmdheight=2
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1
" let g:echodoc#enable_at_startup = 1
" let g:echodoc#highlight_arguments="Visual"
" function! SetDeopleteSettings()
"     call deoplete#custom#source('_',  'max_menu_width', 0)
"     call deoplete#custom#source('_',  'max_abbr_width', 0)
"     call deoplete#custom#source('_',  'max_kind_width', 0)
" endfunction

let g:lsc_auto_map = {
            \ 'defaults': v:true,
            \ 'NextReference': ']r', 
            \ 'PreviousReference': '[r',
            \ 'Completion': 'omnifunc'
            \ }
" let g:lsc_enable_autocomplete = v:false
Plug 'Shougo/echodoc.vim'

let g:lsc_trace_level = 'off'
highlight link lscCurrentParameter Todo
highlight link lscReference PmenuSel
highlight link lscDiagnosticError SpellBad
highlight link lscDiagnosticWarning Underlined
highlight link lscDiagnosticInfo WildMenu
highlight link lscDiagnosticHint WildMenu
