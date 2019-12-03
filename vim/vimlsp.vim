" lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'm-pilia/vim-ccls'
if executable('pyls')
    Plug 'ryanolsonx/vim-lsp-python'
endif

" " Plug 'jackguo380/vim-lsp-cxx-highlight', {'for' : 'cpp'}
" Plug 'jackguo380/vim-lsp-cxx-highlight'
" let g:lsp_cxx_hl_use_text_props = 1 " Without this scrolling slow
" set cmdheight=2

" " {{{ lsp ccls
" if executable('ccls')
"     " let g:lsp_text_edit_enabled = 0
"     " let g:lsp_insert_text_enabled = 0
"     au User lsp_setup call lsp#register_server({
"                 \ 'name': 'ccls',
"                 \ 'cmd': {server_info->['ccls']},
"                 \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"                 \ 'initialization_options': {
"                 \   "index": { "threads": 4 },
"                 \   "cache": {"directory": "C:/Users/aravk/ccls-cache"},
"                 \ },
"                 \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
"                 \ })
" endif
" " }}}
                " \   'highlight': { 'lsRanges' : v:true },

" {{{ lsp clangd
if executable('clangd')
    let g:lsp_text_edit_enabled = 0
    let g:lsp_insert_text_enabled = 0
    au User lsp_setup call lsp#register_server({
                \ 'name': 'clangd',
                \ 'cmd': {server_info->['clangd', '--index', '--clang-tidy']},
                \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                \ })
endif
" }}}

" {{{ lsp general
" let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('vim-lsp.log')
" let g:asyncomplete_log_file = expand('asyncomplete.log')
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
nnoremap K :LspHover<CR>
nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>
nnoremap ca :LspCodeAction<CR>
xmap <leader>f :LspDocumentRangeFormat<CR>
nnoremap ]d :LspNextError<CR>
nnoremap [d :LspPreviousError<CR>
nnoremap ]r :LspNextReference<CR>
nnoremap [r :LspPreviousReference<CR>
nnoremap <leader>lr :LspRename<CR>
" let g:lsp_signs_error = {'text': '✗'}
" let g:lsp_signs_warning = {'text': '!'} " icons require GUI
" let g:lsp_signs_hint = {'text': '>'} " icons require GUI
let g:lsp_highlight_references_enabled = 1 " Makes scrolling slow
" highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green
highlight! link lspReference PMenu
let g:lsp_signs_error = {'text': ''}
let g:lsp_signs_warning = {'text': ''} " icons require GUI
let g:lsp_signs_hint = {'text': ''} " icons require GUI
" }}}
