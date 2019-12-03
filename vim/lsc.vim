" lsc
Plug 'natebosch/vim-lsc'
Plug 'rhysd/vim-clang-format'
Plug 'kana/vim-operator-user'
Plug 'bfrg/vim-cpp-modern'

" For semantic coloring {{{
if has('nvim')
    Plug 'jackguo380/vim-lsp-cxx-highlight', {'for' : 'cpp'}
    let g:lsp_cxx_hl_use_text_props = 1 " Without this scrolling slow
endif
" }}}

autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
let g:lsc_auto_map = v:true
let g:lsc_reference_highlights = v:true
let s:ccls_cache_dir = substitute(expand('~'), '\', '/', 'g') . '/ccls-cache'
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

    " \ 'cpp': { 'command': 'C:\tools\llvm_build_8x\Release\bin\clangd.exe', 'suppress_stderr': v:false },
    " \ 'c': { 'command': 'C:\tools\llvm_build_8x\Release\bin\clangd.exe', 'suppress_stderr': v:false },

let g:lsc_trace_level = 'error'
highlight link lscCurrentParameter PmenuSel
highlight link lscReference Lf_hl_Buffer_stlFullPathMode
