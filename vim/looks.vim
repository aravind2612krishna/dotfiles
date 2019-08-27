" Status lines {{{
if exists('g:fvim_loaded') 
    Plug 'ryanoasis/vim-devicons'
    Plug 'scrooloose/nerdtree'
endif

let g:use_lightline = v:true
let g:use_airline = v:false
let g:use_eleline = v:false

" For Tagbar related features - not essential
Plug 'liuchengxu/vista.vim'
let g:vista_sidebar_width=96
if g:use_lightline
    Plug 'itchyny/lightline.vim'
elseif g:use_eleline

    Plug 'liuchengxu/eleline.vim'
    let g:eleline_slim = 1

elseif g:use_airline

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'enricobacis/vim-airline-clock'
    "{{{ air-line
    let g:airline_powerline_fonts = 1
    if exists('g:fvim_loaded') 
        " adding to vim-airline's tabline
         let g:webdevicons_enable_airline_tabline = 1
         " adding to vim-airline's statusline
         let g:webdevicons_enable_airline_statusline = 1
    endif
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_detect_whitespace=0
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#wordcount#enabled = 0

    " airline symbols

    " let g:airline_left_sep = '|'
    " let g:airline_left_alt_sep = '|'
    " let g:airline_right_sep = '|'
    " let g:airline_right_alt_sep = '|'

    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''

    " let g:airline_left_sep = ''
    " let g:airline_left_alt_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_right_alt_sep = ''

    " let g:airline_left_sep = ''
    " let g:airline_left_alt_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_right_alt_sep = ''

    " let g:airline_left_sep = ''
    " let g:airline_left_alt_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_right_alt_sep = ''

    " let g:airline_symbols.branch = ''
    " let g:airline_symbols.readonly = ''
    " let g:airline_symbols.linenr = ''
    " let g:airline_section_b=""
    " let g:airline_section_y=""
    
    " let g:airline_section_error=""
    " let g:airline_section_warning=""
    

    "}}}

endif "}}}

" indent guides
Plug 'Yggdroot/indentLine'

" colorschemes
Plug 'flazz/vim-colorschemes'

" fullscreen
if has('nvim')
    " Plug 'lambdalisue/vim-fullscreen'
else
    " Plug 'kkoenig/wimproved.vim'
endif

"{{{ list chars
if has('nvim')
    set listchars=tab:▸\ ,extends:▸,precedes:◂,nbsp:●,eol:→
else
    set listchars=tab:►\ ,extends:╍,precedes:◤,nbsp:●,eol:◣
endif
" set listchars=tab:‣\ ,extends:┈,precedes:┈,nbsp:●,eol:→
" set listchars=tab:▶\ ,extends:┈,precedes:┈,nbsp:●,eol:↩
set list
"}}}

" Vertical split chars {{{
if !exists('g:gonvim_running')
    set fillchars+=vert:│
    " set fillchars+=vert:▓
    " set fillchars+=vert:║
endif
" }}}

" Font {{{
if !has('nvim')
    set guifont=Iosevka:h11:cANSI:qDRAFT
    " set guifont=Consolas:h10:cANSI:qDRAFT
    " set guifont=Powerline_Consolas:h11:cANSI:qDRAFT
    " set guifont=Fantasque_Sans_Mono:h08:cANSI:qDRAFT
    " set guifont=Hack:h10:cANSI
    " set guifont=Luculent:h9:cANSI
    " set guifont=Iosevka:h09:cANSI:qDRAFT
endif

" }}}
