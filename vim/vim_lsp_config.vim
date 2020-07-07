au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

" {{{ lsp ccls
let s:ccls_cache_dir = expand(g:storage_home . '/ccls-cache')
if executable('ccls')
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
" }}}

" {{{ lsp pyls
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
" }}}

" {{{ lsp general
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
" }}}
