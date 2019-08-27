Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'rhysd/vim-clang-format'

" A dependency of 'ncm2'.
Plug 'roxma/nvim-yarp'

" v2 of the nvim-completion-manager.
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-tmux'
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
set shortmess+=c

let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
    \ }

nn <silent> gd :call LanguageClient#textDocument_definition()<cr>
nn <silent> gr :call LanguageClient#textDocument_references({'includeDeclaration': v:false})<cr>
nn <silent> K :call LanguageClient#textDocument_hover()<cr>
nn <F5> :call LanguageClient_contextMenu()<CR>
