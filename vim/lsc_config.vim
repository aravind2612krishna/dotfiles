" For Tagbar related features - not essential
if has_key(g:plugs, 'vista.vim')
    let g:vista_executive_for = {
                \ 'cpp': 'vim_lsc',
                \ 'python': 'vim_lsc',
                \ }
endif

set completeopt-=preview
set complete=.,w
let g:lsc_auto_map = v:true
let g:lsc_reference_highlights = v:true
let s:ccls_cache_dir = g:storage_home . '/ccls-cache'

" snippets
let g:lsc_enable_snippet_support = v:true

if has_key(g:plugs, 'vim-autoformat')
    xnoremap ,gq :Autoformat<CR>
endif

" \                                                     'filterAndSort': v:false,
" \                                                     'detailedLabel': v:true}
let s:ccls_lsc_server_commands = {
            \ 'cpp': {
            \    'command': 'ccls -v=1 --log-file=ccls.log',
            \    'suppress_stderr': v:true,
            \    'message_hooks': {
            \        'initialize': {
            \            'initializationOptions': {'index': {'threads': 4},
            \                                      'highlight': { 'lsRanges' : v:true },
            \                                      'cache': {'directory': s:ccls_cache_dir},
            \                                      'completion': {'duplicateOptional': v:true}
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

let s:clangd_lsc_server_commands = {
            \ 'cpp': {
            \    'command': 'clangd --clang-tidy --completion-style=detailed -clang-tidy-checks=-*,clang-analyzer*,bugprone*',
            \    'suppress_stderr': v:true,
            \  },
            \ 'c': {
            \    'command': 'clangd --clang-tidy --completion-style=detailed -clang-tidy-checks=-*,clang-analyzer*,bugprone*',
            \    'suppress_stderr': v:true,
            \ },
            \ 'python' : 'pyls',
            \}

let g:lsc_server_commands = s:ccls_lsc_server_commands

let g:lsc_auto_map = {
            \ 'defaults': v:true,
            \ 'NextReference': ']r', 
            \ 'PreviousReference': '[r',
            \ 'Completion': 'completefunc'
            \ }

let g:lsc_trace_level = 'error'
highlight link lscCurrentParameter Todo
highlight link lscReference PmenuSel
highlight link lscDiagnosticError SpellBad
highlight link lscDiagnosticWarning Underlined
highlight link lscDiagnosticInfo WildMenu
highlight link lscDiagnosticHint WildMenu
