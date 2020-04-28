Plug 'hrsh7th/vim-lamp'
Plug 'hrsh7th/vim-compete'
Plug 'hrsh7th/vim-compete-lamp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

set hidden
set completeopt=menu,menuone,noselect

augroup vimrc
  autocmd!
augroup END

"
" initialize servers
"
autocmd! vimrc User lamp#initialized call s:on_initialized()
function! s:on_initialized()
    " built-in setting
    " call lamp#builtin#intelephense()
    " call lamp#builtin#html_languageserver()
    " call lamp#builtin#css_languagserver()
    " call lamp#builtin#typescript_language_server()
    " call lamp#builtin#vim_language_server()
    " call lamp#builtin#gopls()
    " call lamp#builtin#rls()
    call lamp#builtin#pyls()

    " ccls setting
    let s:ccls_cache_dir = g:storage_home . '/ccls-cache'
    call lamp#register('ccls', {
                \   'command': ['ccls', '--log-file=ccls.log'],
                \   'filetypes': ['c', 'cpp'],
                \   'root_uri': { -> lamp#findup('compile_commands.json') },
                \   'initialization_options': { -> {'index': {'threads': 4},
                \                                      'highlight': { 'lsRanges' : v:true },
                \                                      'cache': {'directory': s:ccls_cache_dir}
                \                                     
                \   } }
                \ })
endfunction

"
" initialize buffers
"
autocmd! vimrc User lamp#text_document_did_open call s:on_text_document_did_open()
function! s:on_text_document_did_open() abort
    " completion
    setlocal omnifunc=lamp#complete

    " commands
    nnoremap <buffer> gd           :<C-u>LampDefinition edit<CR>
    nnoremap <buffer> gh           :<C-u>LampTypeDefinition edit<CR>
    nnoremap <buffer> dh           :<C-u>LampDeclaration edit<CR>
    nnoremap <buffer> K            :<C-u>LampHover<CR>
    nnoremap <buffer> <leader>lr   :<C-u>LampRename<CR>
    nnoremap <buffer> gr           :<C-u>LampReferences<CR>
    nnoremap <buffer> S            :<C-u>LampDocumentHighlight<CR>
    nnoremap <buffer> s            :<C-u>LampDocumentHighlightClear<CR>
    nnoremap <buffer> <leader>x    :<C-u>LampFormatting<CR>
    vnoremap <buffer> <leader>x    :LampRangeFormatting<CR>
    nnoremap <buffer> <leader>ca   :<C-u>LampCodeAction<CR>
    vnoremap <buffer> <leader>ca   :LampCodeAction<CR>
    nnoremap <buffer> <leader>[    :<C-u>LampSelectionRangeExpand<CR>
    nnoremap <buffer> <leader>]    :<C-u>LampSelectionRangeCollapse<CR>
    vnoremap <buffer> <leader>[    :<C-u>LampSelectionRangeExpand<CR>
    vnoremap <buffer> <leader>]    :<C-u>LampSelectionRangeCollapse<CR>

endfunction
