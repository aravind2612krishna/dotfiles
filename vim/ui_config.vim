" {{{ fvim
if exists('g:fvim_loaded')
    nnoremap <silent> <C-+> :set guifont=+<CR>
    nnoremap <silent> <C--> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>

    " Cursor tweaks
    " FVimCursorSmoothMove v:true
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                \,sm:block-blinkwait175-blinkoff150-blinkon175


    " UI options (all default to v:false)
    " FVimUIMultiGrid v:false     " per-window grid system -- work in progress
    FVimUIPopupMenu v:false      " external popup menu
    " FVimUITabLine v:false       " external tabline -- not implemented
    " FVimUICmdLine v:false       " external cmdline -- not implemented
    " FVimUIWildMenu v:false      " external wildmenu -- not implemented
    " FVimUIMessages v:false      " external messages -- not implemented
    " FVimUITermColors v:false    " not implemented
    " FVimUIHlState v:false       " not implemented

    set listchars=tab:▸\ ,extends:▸,precedes:◂,nbsp:●,eol:↦
else
    set listchars=tab:▸\ ,extends:▸,precedes:◂,nbsp:●,eol:↦
endif

