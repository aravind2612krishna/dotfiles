let g:plug_log_on = 1
call plug#begin(g:norm_home_dir . '/.vim/plugged')
" explorer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
execute 'source '. curscrpath . '/looks.vim'
" Plug 'akiyosi/gonvim-fuzzy'
execute 'source '. curscrpath . '/file_search.vim'
if has('nvim')
    " execute 'source '. curscrpath . '/vcs.vim'
    " execute 'source '. curscrpath . '/nvim_lsp_plug.vim'
    " execute 'source '. curscrpath . '/coc.vim'
    " execute 'source '. curscrpath . '/vimlsp.vim'
    execute 'source '. curscrpath . '/lsc.vim'
    " execute 'source '. curscrpath . '/lcn.vim'
    " execute 'source '. curscrpath . '/lamp.vim'
else
    execute 'source '. curscrpath . '/vimlsp.vim'
    " execute 'source '. curscrpath . '/lsc.vim'
    " execute 'source '. curscrpath . '/termdebug.vim'
    Plug 'vim/killersheep'
    Plug 'puremourning/vimspector'
    Plug 'honza/vim-snippets'
    let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
endif
" Plug 'python/black', {'for': 'python', 'tag': '*' }
Plug 'python/black', {'for': 'python'}
" misc
Plug 'wellle/context.vim', {'for': 'cpp'}
" Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
" Plug 'maxbrunsfeld/vim-yankstack'
Plug 'tpope/vim-commentary'
Plug 'jceb/vim-orgmode'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'will133/vim-dirdiff'
Plug 'yssl/QFEnter'
Plug 'vimwiki/vimwiki'

" tcl
" Plug 'JessicaKMcIntosh/Nagelfar-Vim'
" autocmd FileType tcl compiler nagelfar
" Plug 'dense-analysis/ale', {'for': 'tcl'}

call plug#end()

" colorscheme ayu
let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme codedark
" colorscheme gruvbox
" let g:one_allow_italics = 1
" AirlineTheme transparent
" set background=light
" colorscheme solarized8_high
" colorscheme gruvbox
colorscheme space-vim-dark

let g:black_linelength=79

function! SetLcnSettings()
    call deoplete#custom#source('_',  'max_menu_width', 0)
    call deoplete#custom#source('_',  'max_abbr_width', 0)
    call deoplete#custom#source('_',  'max_kind_width', 0)
    " sign define LanguageClientError text= texthl=SignError
    " sign define LanguageClientWarning text= texthl=SignWarning
    " sign define LanguageClientInformation text= texthl=SignInformation
    " sign define LanguageClientHint text= texthl=SignHint
endfunction

if exists('g:fvim_loaded')
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-=> :set guifont=+<CR>
    nnoremap <silent> <C--> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>

    " Cursor tweaks
    " FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                \,sm:block-blinkwait175-blinkoff150-blinkon175


    " UI options (all default to v:false)
    " FVimUIMultiGrid v:false     " per-window grid system -- work in progress
    " FVimUIPopupMenu v:false      " external popup menu
    " FVimUITabLine v:false       " external tabline -- not implemented
    " FVimUICmdLine v:false       " external cmdline -- not implemented
    " FVimUIWildMenu v:false      " external wildmenu -- not implemented
    " FVimUIMessages v:false      " external messages -- not implemented
    " FVimUITermColors v:false    " not implemented
    " FVimUIHlState v:false       " not implemented
endif

if has('nvim')
    " execute 'source '. curscrpath . '/nvim_lsp.vim'
endif
let g:context_enabled = 0
let g:context_add_mappings = 0
let g:context_add_autocmds = 1

silent let g:echodoc#enable_at_startup = 1

if !empty($P4CLIENT)
    set title
    let &titlestring="nvim-" . $P4CLIENT
endif
