let g:plug_log_on = 1
call plug#begin(g:norm_home_dir . '/.vim/plugged')
" explorer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
execute 'source '. curscrpath . '/looks.vim'
execute 'source '. curscrpath . '/vcs.vim'
execute 'source '. curscrpath . '/file_search.vim'
if has('nvim')
    " Plug 'neovim/nvim-lsp'
    execute 'source '. curscrpath . '/coc.vim'
    " execute 'source '. curscrpath . '/vimlsp.vim'
    " execute 'source '. curscrpath . '/lsc.vim'
else
    " execute 'source '. curscrpath . '/vimlsp.vim'
    execute 'source '. curscrpath . '/lsc.vim'
    " execute 'source '. curscrpath . '/termdebug.vim'
endif
Plug 'python/black', {'for': 'python'}
" misc
" Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'tpope/vim-commentary'
Plug 'jceb/vim-orgmode'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'will133/vim-dirdiff'

" Colorschemes
Plug 'tomasiser/vim-code-dark'
Plug 'iCyMind/NeoSolarized'
Plug 'haishanh/night-owl.vim'
" Plug 'ayu-theme/ayu-vim' " or other package manager
" Plug 'JBakamovic/yaflandia'
" Plug 'majutsushi/tagbar'
" Plug 'junegunn/goyo.vim'
Plug 'rakr/vim-one'
call plug#end()

" colorscheme ayu
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme onedark
" colorscheme NeoSolarized
" colorscheme solarized8_light_flat
" colorscheme PaperColor
" colorscheme yaflandia
colorscheme codedark
" colorscheme one
" colorscheme night-owl
" colorscheme one
" let g:airline_theme='one'
" let g:one_allow_italics = 1

let g:black_linelength=79

function! SetLcnSettings()
    call deoplete#custom#source('_',  'max_menu_width', 0)
    call deoplete#custom#source('_',  'max_abbr_width', 0)
    call deoplete#custom#source('_',  'max_kind_width', 0)
    sign define LanguageClientError text= texthl=SignError
    sign define LanguageClientWarning text= texthl=SignWarning
    sign define LanguageClientInformation text= texthl=SignInformation
    sign define LanguageClientHint text= texthl=SignHint
endfunction

if exists('g:fvim_loaded')
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-=> :set guifont=+<CR>
    nnoremap <silent> <C--> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>

    " Cursor tweaks
    " FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true
    :set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                \,sm:block-blinkwait175-blinkoff150-blinkon175


    " Font tweaks
    FVimFontAntialias v:true
    FVimFontAutohint v:true
    FVimFontSubpixel v:true
    FVimFontLcdRender v:true
    FVimFontHintLevel 'full'
    " FVimFontLineHeight '+1.0' " can be 'default', '14.0', '-1.0' etc.

    " Try to snap the fonts to the pixels, reduces blur
    " in some situations (e.g. 100% DPI).
    FVimFontAutoSnap v:true

    " FVimBackgroundComposition 'none'   " 'none', 'blur' or 'acrylic'

    " " Font weight tuning, possible valuaes are 100..900
    " FVimFontNormalWeight 400
    " FVimFontBoldWeight 700

    " Font debugging -- draw bounds around each glyph
    " FVimFontDrawBounds v:true

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
