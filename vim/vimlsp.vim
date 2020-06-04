" lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
if executable('pyls')
    Plug 'ryanolsonx/vim-lsp-python'
    " Plug 'vim-vdebug/vdebug'
endif
let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'python': 'vim_lsp',
  \ }

" snippets {{{ disabling due to performance
" Plug 'Shougo/neosnippet.vim'
" Plug 'thomasfaingnaert/vim-lsp-snippets'
" Plug 'thomasfaingnaert/vim-lsp-neosnippet'
" imap <expr> <Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
" smap <expr> <Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
" }}}

" " {{{ deoplete
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/echodoc.vim'
" set cmdheight=2
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1
" let g:echodoc#enable_at_startup = 1
" let g:echodoc#highlight_arguments="Visual"
" Plug 'lighttiger2505/deoplete-vim-lsp'
" " }}}

" {{{ asyncomplete.vim
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'prabirshrestha/asyncomplete-file.vim'
" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
"     \ 'name': 'file',
"     \ 'whitelist': ['*'],
"     \ 'priority': 10,
"     \ 'completor': function('asyncomplete#sources#file#completor')
"     \ }))
Plug 'prabirshrestha/asyncomplete-buffer.vim'
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

" }}}

" " ultisnips {{{
" Plug 'SirVer/ultisnips'
" Plug 'thomasfaingnaert/vim-lsp-snippets'
" Plug 'thomasfaingnaert/vim-lsp-ultisnips'

" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" }}}

"{{{ vim-vsnip

 Plug 'hrsh7th/vim-vsnip'
 Plug 'hrsh7th/vim-vsnip-integ'
 imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'
 imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
 smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
 imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
 smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
 imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
 smap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" }}}

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
                \   'highlight': { 'lsRanges' : v:true },
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
