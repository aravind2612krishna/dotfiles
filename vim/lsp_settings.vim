let s:ccls_cache_dir = g:storage_home . '/ccls-cache'
let s:vista_provider = 'tags'
let s:use_clangd = v:false
echom "Loading common lsp settings..."

if exists('g:loaded_lsc') " {{{ lsc
    let s:vista_provider = 'vim_lsc'
    echom "Loading LSC settings..."
    set completeopt-=preview
    set complete=.,w
    let g:lsc_auto_map = v:true
    let g:lsc_reference_highlights = v:true
    if exists('g:loaded_vim_autoformat')
        xnoremap ,gq :Autoformat<CR>
    endif
    " \                                                     'filterAndSort': v:false,
    " \                                                     'detailedLabel': v:true}
    let g:lsc_server_commands = {
                \ 'cpp': {
                \    'command': 'ccls --log-file=ccls.log',
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
    let g:lsc_auto_map = {
                \ 'defaults': v:true,
                \ 'NextReference': ']r', 
                \ 'PreviousReference': '[r',
                \ 'Completion': 'completefunc'
                \ }
    let g:lsc_trace_level = 'off'
    highlight link lscCurrentParameter Todo
    highlight link lscReference PmenuSel
    highlight link lscDiagnosticError SpellBad
    highlight link lscDiagnosticWarning Underlined
    highlight link lscDiagnosticInfo WildMenu
    highlight link lscDiagnosticHint WildMenu
endif "}}}

if exists('g:loaded_nvim_lsp') " {{{ nvim_lsp
    let s:vista_provider = 'nvim_lsp'
    if exists('g:loaded_diagnostic_nvim')
        let g:diagnostic_enable_virtual_text = 1
        let g:diagnostic_insert_delay = 1
    endif
    if exists('g:loaded_completion_nvim')
        autocmd BufEnter * lua require'completion'.on_attach()
        set completeopt=menuone,noinsert,noselect
        if exists('g:loaded_vim_vsnip')
            let g:completion_enable_snippet = 'vim-vsnip'
        endif
    endif
    " c++
    if s:use_clangd && executable('clangd')
        lua require'lsp_setup'.setup_clangd()
    elseif executable('ccls')
        lua require'lsp_setup'.setup_ccls()
    endif
    lua require'nvim_lsp'.pyls.setup{ on_attach = require'OnAttach'.on_attach }
endif " }}}

if exists('g:loaded_coc') " {{{ coc
    let s:vista_provider = 'coc'
    if exists('g:loaded_coc_highlight')
        " Highlight symbol under cursor on CursorHold
        highlight! link CocHighlightText PmenuSel
        autocmd! CursorHold * silent call CocActionAsync('highlight')
    endif

    " if hidden not set, TextEdit might fail.
    set hidden

    " Better display for messages
    set cmdheight=2

    " Use <cr> for confirm completion.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[c` and `]c` for navigate diagnostics
    nmap <silent> [d <Plug>(coc-diagnostic-prev)
    nmap <silent> ]d <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K for show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if &filetype == 'vim'
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    " Show signature help while editing
    " autocmd! CursorHoldI * silent! call CocAction('showSignatureHelp')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    vmap <leader>gq <Plug>(coc-format-selected)
    nmap <leader>gq <Plug>(coc-format-selected)

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    vmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)

    " Root detection
    let g:rooter_patterns = ['compile_commands.json', '.git']

    " resume coclist
    nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>

    nn <silent><buffer> <leader>u :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<CR>

    nnoremap <M-n> :CocCommand document.jumpToNextSymbol<CR>

    " bases
    nn <silent> xb :call CocLocations('ccls','$ccls/inheritance')<cr>
    " bases of up to 3 levels
    nn <silent> xB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
    " derived
    nn <silent> xd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
    " derived of up to 3 levels
    nn <silent> xD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

    " caller
    nn <silent> xc :call CocLocations('ccls','$ccls/call')<cr>
    " callee
    nn <silent> xC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>

    " $ccls/member
    " member variables / variables in a namespace
    nn <silent> gxm :call CocLocations('ccls','$ccls/member')<cr>
    " member functions / functions in a namespace
    nn <silent> gxf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
    " nested classes / types in a namespace
    nn <silent> gxs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>

    nmap <silent> gxt <Plug>(coc-type-definition)<cr>
    nn <silent> gxv :call CocLocations('ccls','$ccls/vars')<cr>
    nn <silent> gxV :call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>

    nn <silent> gj :call CocLocations('ccls','$ccls/navigate',{'direction':'D'})<cr>
    nn <silent> gh :call CocLocations('ccls','$ccls/navigate',{'direction':'L'})<cr>
    nn <silent> gl :call CocLocations('ccls','$ccls/navigate',{'direction':'R'})<cr>
    nn <silent> gk :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<cr>

    nn xx x
endif " }}}

if exists('g:loaded_vim_lsp') " {{{ vim_lsp
    let s:vista_provider = 'vim_lsp'

    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
                \ 'name': 'buffer',
                \ 'whitelist': ['*'],
                \ 'blacklist': ['go'],
                \ 'completor': function('asyncomplete#sources#buffer#completor'),
                \ 'config': {
                \    'max_buffer_size': 5000000,
                \  },
                \ }))

    if !s:use_clangd && executable('ccls')
        " let g:lsp_text_edit_enabled = 0
        " let g:lsp_insert_text_enabled = 0
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'ccls',
                    \ 'cmd': {server_info->['ccls', '-log-file=ccls.log', '-v=1']},
                    \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
                    \ 'initialization_options': {
                    \   "index": { "threads": 8 },
                    \   "cache": {"directory": s:ccls_cache_dir},
                    \   "highlight": { "lsRanges" : v:true },
                    \ },
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        " \   "completion": {"detailedLabel": v:false}
    elseif executable('clangd')
        " let g:lsp_text_edit_enabled = 0
        " let g:lsp_insert_text_enabled = 0
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd', '--clang-tidy']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
    endif

    if executable('pyls')
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'pyls',
                    \ 'cmd': {server_info->['pyls']},
                    \ 'whitelist': ['python'],
                    \ })
    endif

    " let g:lsp_log_verbose = 0
    " let g:lsp_log_file = expand('vim-lsp.log')
    " let g:asyncomplete_log_file = expand('asyncomplete.log')
    let g:lsp_signs_enabled = 1         " enable signs
    let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
    let g:lsp_highlight_references_enabled = 1 " Makes scrolling slow
    let g:lsp_fold_enabled = 0 " High performance penalty

    nnoremap K :LspHover<CR>
    nnoremap gd :LspDefinition<CR>
    nnoremap gi :LspImplementation<CR>
    nnoremap gr :LspReferences<CR>
    nnoremap ca :LspCodeAction<CR>
    xmap <leader>f :LspDocumentRangeFormat<CR>
    nnoremap ]d :LspNextDiagnostic<CR>
    nnoremap [d :LspPreviousDiagnostic<CR>
    nnoremap ]r :LspNextReference<CR>
    nnoremap [r :LspPreviousReference<CR>
    nnoremap <leader>lr :LspRename<CR>

    " let g:lsp_signs_error = {'text': '✗'}
    " let g:lsp_signs_warning = {'text': '!'} " icons require GUI
    " let g:lsp_signs_hint = {'text': '>'} " icons require GUI

    " highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green
    highlight! link lspReference PMenuSel

    hi! link LspInformationVirtual LineNr
    hi! link LspWarningVirtual Folded
    hi! link LspErrorVirtual ErrorMsg
    hi! link LspErrorHighlight SpellBad

    " if exists('g:fvim_loaded')
    if has('neovim')
        let g:lsp_signs_error = {'text': ''}
        let g:lsp_signs_warning = {'text': ''} " icons require GUI
        let g:lsp_signs_hint = {'text': ''} " icons require GUI
    else
        let g:lsp_signs_error = {'text': '✘'}
        let g:lsp_signs_warning = {'text': 'w'} " icons require GUI
        let g:lsp_signs_hint = {'text': '⚐'} " icons require GUI
    endif

    " Folding - disabling due to performance
    " set foldmethod=expr
    "   \ foldexpr=lsp#ui#vim#folding#foldexpr()
    "   \ foldtext=lsp#ui#vim#folding#foldtext()
endif " }}}

if exists('g:loaded_lcn') " {{{ lcn
    let s:vista_provider = 'lcn'
    " Deoplete
    set cmdheight=2
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#highlight_arguments="Visual"
    " langserv
    " {{{ dochighlight
    let g:LanguageClient_documentHighlightDisplay = {
                \ 1: {
                \     "name": "Text",
                \     "texthl": "PMenuSel",
                \ },
                \ 2: {
                \     "name": "Read",
                \     "texthl": "PMenu",
                \ },
                \ 3: {
                \     "name": "Write",
                \     "texthl": "airline_tabtype",
                \ }, }

    "}}}
    " " {{{ clangd
    " let g:LanguageClient_serverCommands = {
    " \ 'cpp': ['clangd', '-clang-tidy', '-clang-tidy-checks=-*,clang-analyzer*,bugprone*,performance*',
    " \         '-j=8', '-pch-storage=memory', '--completion-style=detailed', '--completion-parse=auto',
    " \         '--function-arg-placeholders'],
    " \ 'python': ['pyls']
    " \ }

    " let g:LanguageClient_semanticHighlightMaps = {}
    " let g:LanguageClient_semanticHighlightMaps['cpp'] = [
    "             \ {'Function': ['entity.name.function.cpp']},
    "             \ {'Function': ['entity.name.function.method.cpp']},
    "             \ {'CppNamespace': ['entity.name.namespace.cpp']},
    "             \ {'CppEnumConstant': ['variable.other.enummember.cpp']},
    "             \ {'CppMemberVariable': ['variable.other.field.cpp']},
    "             \ {'Type': ['entity.name.type.class.cpp']},
    "             \ {'Type': ['entity.name.type.enum.cpp']},
    "             \ {'Type': ['entity.name.type.template.cpp']},
    "             \ ]

    " hi! CppEnumConstant ctermfg=Magenta guifg=#AD7FA8 cterm=none gui=none
    " hi! CppNamespace ctermfg=Yellow guifg=#BBBB00 cterm=none gui=none
    " hi! CppMemberVariable ctermfg=White guifg=White
    " }}}
    " {{{  ccls
    if executable('ccls')
        let g:LanguageClient_serverCommands = {
                    \ 'c': ['ccls', '--log-file=ccls.log'],
                    \ 'cpp': ['ccls', '--log-file=ccls.log'],
                    \ 'cuda': ['ccls', '--log-file=ccls.log'],
                    \ 'objc': ['ccls', '--log-file=ccls.log'],
                    \ }
        if has('win32')
            let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
            let g:LanguageClient_settingsPath = "C:/Users/aravk/AppData/Local/nvim/ccls_setings.json"
        endif
    endif
    " }}}
    let g:LanguageClient_serverCommands['python'] = ['pyls']
    " {{{ Maps
    nnoremap <silent>gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
    nnoremap <leader>gt :call LanguageClient#textDocument_typeDefinition()<CR>
    nnoremap <silent>gr :call LanguageClient#textDocument_references()<CR>
    nnoremap <silent>gi :call LanguageClient#textDocument_implementation()<CR>
    nnoremap <leader>ca :call LanguageClient_textDocument_codeAction()<CR>
    nnoremap <S-k>      :call LanguageClient#textDocument_hover()<CR>
    nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
    nnoremap <leader>ll :call LanguageClient#debugInfo()<CR>
    let g:LanguageClient_diagnosticsList="Location"
    let g:LanguageClient_useFloatingHover=1
    let g:LanguageClient_selectionUI="quickfix"
    " let g:LanguageClient_selectionUI="fzf"
    if has('nvim')
        " let g:echodoc#type = 'floating'
        let g:LanguageClient_virtualTextPrefix = '■'
        let g:LanguageClient_useVirtualText = 'Diagnostics'
        let g:LanguageClient_diagnosticsDisplay = {
                    \ 1: {
                    \     "name": "Error",
                    \     "texthl": "ALEError",
                    \     "signText": "✘",
                    \     "signTexthl": "ALEErrorSign",
                    \     "virtualTexthl": "Error",
                    \ },
                    \ 2: {
                    \     "name": "Warning",
                    \     "texthl": "WarningMsg",
                    \     "signText": "⚑",
                    \     "signTexthl": "WarningMsg",
                    \     "virtualTexthl": "Todo",
                    \ },
                    \ 3: {
                    \     "name": "Information",
                    \     "texthl": "ALEInfo",
                    \     "signText": "⚐",
                    \     "signTexthl": "ALEInfoSign",
                    \     "virtualTexthl": "Todo",
                    \ },
                    \ 4: {
                    \     "name": "Hint",
                    \     "texthl": "ALEInfo",
                    \     "signText": "➡",
                    \     "signTexthl": "ALEInfoSign",
                    \     "virtualTexthl": "Todo",
                    \ },
                    \ }
    endif
    " bases
    nn <silent> xb :call LanguageClient#findLocations({'method':'$ccls/inheritance'})<cr>
    " bases of up to 3 levels
    nn <silent> xB :call LanguageClient#findLocations({'method':'$ccls/inheritance','levels':3})<cr>
    " derived
    nn <silent> xd :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true})<cr>
    " derived of up to 3 levels
    nn <silent> xD :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true,'levels':3})<cr>

    " caller
    nn <silent> xc :call LanguageClient#findLocations({'method':'$ccls/call'})<cr>
    " callee
    nn <silent> xC :call LanguageClient#findLocations({'method':'$ccls/call','callee':v:true})<cr>

    nn <silent> gh :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'L'})<cr>
    nn <silent> gj :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'D'})<cr>
    nn <silent> gk :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'U'})<cr>
    nn <silent> gl :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'R'})<cr>

    nn xx x
    " }}}

    function! SetDeopleteSettings()
        call deoplete#custom#source('_',  'max_menu_width', 0)
        call deoplete#custom#source('_',  'max_abbr_width', 0)
        call deoplete#custom#source('_',  'max_kind_width', 0)
    endfunction

    function SetLSPShortcuts()
        let g:LanguageClient_diagnosticsEnable = 1 " enable gutter, highlight and quickfix list
        setl completefunc=LanguageClient#complete
        setl formatexpr=LanguageClient_textDocument_rangeFormatting()
    endfunction

    "{{{ highlight
    augroup LanguageClient_config
        au!
        au FileType cpp,c,python call SetLSPShortcuts()
        " au BufEnter let b:Plugin_LanguageClient_started = 0
        " au FileType cpp let b:Plugin_LanguageClient_started = 1
        " au FileType,CursorMoved * if &ft == 'cpp' | sil call LanguageClient#textDocument_documentHighlight() | endif
    augroup END
"}}}
endif " }}}

if exists('g:loaded_vista')
    let g:vista_executive_for = {
                \ 'cpp': s:vista_provider,
                \ 'python': s:vista_provider,
                \ }
endif
