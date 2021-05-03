if &compatible
  set nocompatible
endif

" Load packager only when you need it
" Also, add miscellaneous plugins
function! PackagerInit() abort
    packadd vim-packager
    call packager#init()
    call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

    call packager#add('psf/black', { 'branch': 'stable', 'type': 'opt'})
    call packager#add('wellle/context.vim', {'type': 'opt'})
    call packager#add('will133/vim-dirdiff', {'type': 'opt'})
    call packager#add('vimwiki/vimwiki', {'type': 'opt'})
    call packager#add('jceb/vim-orgmode', {'type': 'opt'})
    call packager#add('rhysd/vim-grammarous', {'type': 'opt'})

    " Plugins that need to be loaded all the time
    call packager#add('tpope/vim-commentary')
    call packager#add('romainl/vim-qf')

    call PackagerLooks()
endfunction

function! PackagerLooks() abort
    call packager#add('scrooloose/nerdtree')
    call packager#add('bfrg/vim-cpp-modern')

    call packager#add('nathanaelkane/vim-indent-guides')
    let g:indent_guides_start_level=2
    let g:indent_guides_guide_size=1
    let g:indent_guides_enable_on_vim_startup = 1

    if !has('nvim')
        Plug 'kkoenig/wimproved.vim'
    endif

    call PackagerLightline()

    call packager#add('jackguo380/vim-lsp-cxx-highlight', {'type': 'opt'})
    call packager#add('liuchengxu/vista.vim', {'type': 'opt'})

    call packager#add('tomasiser/vim-code-dark')
endfunction

function! PackagerDevicons() abort
    call packager#add('ryanoasis/vim-devicons')
endfunction

function! PackagerLightline() abort
    call packager#add('itchyny/lightline.vim')
    let g:lightline = {
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'readonly', 'filename', 'modified', 'method' ] ],
                \ 'right': [ [ 'lineinfo' ],
                \            [ 'percent' ],
                \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
                \ },
                \ 'component_function': {
                \   'filetype': 'MyFiletype',
                \   'fileformat': 'MyFileformat',
                \   'method': 'NearestMethodOrFunction'
                \ },
                \ 'colorscheme': 'selenized_black'
                \ }
    command! LightlineReload call LightlineReload()
endfunction

function! LightlineReload() abort
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

function! PackagerEleline() abort
    call packager#add('liuchengxu/eleline.vim')
    let g:eleline_slim = 0
endfunction

function! PackagerAirline() abort
    call packager#add('vim-airline/vim-airline')
    call packager#add('vim-airline/vim-airline-themes')
    call packager#add('enricobacis/vim-airline-clock')
    "{{{ air-line
    let g:airline_powerline_fonts = 1
    " if exists('g:fvim_loaded') 
    if has('neovim')
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

    " let g:airline_left_sep = ''
    " let g:airline_left_alt_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_right_alt_sep = ''

    " let g:airline_left_sep = ''
    " let g:airline_left_alt_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_right_alt_sep = ''

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
endfunction

command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()

" looks {{{
if exists("g:loaded_vim_code_dark")
    colorscheme codedark
endif

if exists
let g:vista_sidebar_width=96

set listchars=tab:▸\ ,extends:▸,precedes:◂,nbsp:●,eol:→
set list
set fillchars+=vert:│
" }}}
