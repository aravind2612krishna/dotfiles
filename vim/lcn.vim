 " lcn
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'm-pilia/vim-ccls'
let g:ccls_log_file = expand('~/my_log_file.txt')

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

let g:completion_enable_snippet = 'UltiSnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

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
    let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
    let g:LanguageClient_settingsPath = "C:/Users/aravk/AppData/Local/nvim/ccls_setings.json"
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
" let g:LanguageClient_selectionUI="quickfix"
let g:LanguageClient_selectionUI="fzf"
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
    au FileType cpp,c call SetLSPShortcuts()
    " au BufEnter let b:Plugin_LanguageClient_started = 0
    " au FileType cpp let b:Plugin_LanguageClient_started = 1
    " au FileType,CursorMoved * if &ft == 'cpp' | sil call LanguageClient#textDocument_documentHighlight() | endif
augroup END
"}}}
