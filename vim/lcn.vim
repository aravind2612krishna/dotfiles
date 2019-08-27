 " lcn
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'

" Deoplete
set cmdheight=2
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'
" langserv

" {{{ dochighlight
let g:LanguageClient_documentHighlightDisplay = {
            \ 1: {
            \     "name": "Text",
            \     "texthl": "airline_tabtype",
            \ },
            \ 2: {
            \     "name": "Read",
            \     "texthl": "airline_tabtype",
            \ },
            \ 3: {
            \     "name": "Write",
            \     "texthl": "airline_tabtype",
            \ }, }

"}}}

" {{{ clangd
let g:LanguageClient_serverCommands = {
\ 'cpp': ['clangd', '-clang-tidy', '-j=16', '-pch-storage=memory'],
\ 'python': ['pyls']
\ }
" }}}

let g:LanguageClient_diagnosticsEnable = 1 " enable gutter, highlight and quickfix list
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()
function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_textDocument_codeAction()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
  nnoremap <leader>ll :call LanguageClient#debugInfo()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c call SetLSPShortcuts()
  autocmd FileType python call SetLSPShortcuts()
augroup END
