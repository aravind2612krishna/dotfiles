" Status lines {{{
if exists('g:fvim_loaded') 
    Plug 'ryanoasis/vim-devicons'
    Plug 'scrooloose/nerdtree'
endif

let g:use_lightline = v:false
let g:use_airline = v:true
let g:use_eleline = v:false

" For Tagbar related features - not essential
Plug 'liuchengxu/vista.vim'
let g:vista_sidebar_width=96
if g:use_lightline
    Plug 'itchyny/lightline.vim'
    let g:lightline = {
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'readonly', 'filename', 'modified', 'method' ] ],
                \ 'right': [ [ 'lineinfo' ],
                \            [ 'percent' ],
                \            [ 'cocstatus', 'fileformat', 'fileencoding', 'filetype' ] ]
                \ },
                \ 'component_function': {
                \   'filetype': 'MyFiletype',
                \   'fileformat': 'MyFileformat',
                \   'cocstatus': 'coc#status',
                \   'method': 'NearestMethodOrFunction'
                \ },
                \ 'colorscheme': 'onedark'
                \ }

elseif g:use_eleline

    Plug 'liuchengxu/eleline.vim'
    let g:eleline_slim = 0

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

    let g:airline_symbols = {}
    let g:airline_symbols.linenr = '●'

    let g:airline_section_y = ''
    " let g:airline_section_z = airline#section#create(['linenr', ':%3v'])
    " let g:airline_section_z = (line number, column number)
    " let g:airline_section_z       (percentage, line number, column number)

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


    "}}}

endif "}}}

function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
endfunction   

function! MyFiletype() abort
    if exists('g:fvim_loaded')
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
    else
        return winwidth(0) > 70 ? (&filetype) : ''
    endif
endfunction

function! MyFileformat() abort
    if exists('g:fvim_loaded')
        return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
    else
        return winwidth(0) > 70 ? (&fileformat) : ''
    endif
endfunction

function! CocStatus() abort
    if exists('g:coc_status') && get(g:, 'coc_enabled', 0) | return g:coc_status.' ' | endif
    return ''
endfunction

function! CocCurrentFunction() abort
    " return get(b:, 'coc_current_function', '')
    return ''
endfunction

" indent guides
Plug 'Yggdroot/indentLine'

" fullscreen
if has('nvim')
    " Plug 'lambdalisue/vim-fullscreen'
else
    Plug 'kkoenig/wimproved.vim'
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
    " set guifont=Iosevka:h11:cANSI:qDRAFT
    set guifont=Consolas:h10:cANSI:qDRAFT
    " set guifont=Powerline_Consolas:h11:cANSI:qDRAFT
    " set guifont=Fantasque_Sans_Mono:h08:cANSI:qDRAFT
    " set guifont=Hack:h10:cANSI
    " set guifont=Luculent:h9:cANSI
    " set guifont=Iosevka:h09:cANSI:qDRAFT
endif

" }}}
