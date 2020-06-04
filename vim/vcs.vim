" Plug 'nfvs/vim-perforce'

Plug 'mhinz/vim-signify'
let g:signify_disable_by_default=1
" Plug 'ngemily/vim-vp4'

" let g:perforce_debug=1

" Plug 'sgur/vim-lazygutter'

" Plug 'tomtom/quickfixsigns_vim'
" Quickfixsigns {{{
" " define own signs
" function! s:define_highlights()
"     highlight qfs_vcs_add ctermfg=2 ctermbg=NONE cterm=bold
"     highlight qfs_vcs_change ctermfg=3 ctermbg=NONE cterm=bold
"     highlight qfs_vcs_del ctermfg=1 ctermbg=NONE cterm=bold
"     highlight qfs_qfl ctermfg=LightGray ctermbg=NONE
" endfunction

" function! s:define_signs()
"     sign define QFS_VCS_ADD text=+ texthl=qfs_vcs_add
"     sign define QFS_VCS_CHANGE text=~ texthl=qfs_vcs_change
"     sign define QFS_VCS_DEL text=_ texthl=qfs_vcs_del
"     " sign define QFS_QFL text=✗ texthl=qfs_qfl
"     sign define QFS_QFL text=⚑ texthl=qfs_qfl
" endfunction

" " call s:define_highlights()
" call s:define_signs()

" let g:quickfixsigns_blacklist_buffer = '^\(__.*__\|ControlP\|.*YankRing.*\|\|index\|NERD_tree_.*\|-MiniBufExplorer-\)$'
" " }}}
