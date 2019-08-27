call plug#begin(g:norm_home_dir . '/.vim/plugged')
" explorer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
execute 'source '. curscrpath . '/looks.vim'
execute 'source '. curscrpath . '/vcs.vim'
execute 'source '. curscrpath . '/file_search.vim'
if has('nvim')
    execute 'source '. curscrpath . '/coc.vim'
else
    " execute 'source '. curscrpath . '/vimlsp.vim'
    execute 'source '. curscrpath . '/lsc.vim'
    " execute 'source '. curscrpath . '/termdebug.vim'
endif
Plug 'python/black', {'for': 'python'}
" misc
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'tpope/vim-commentary'
Plug 'jceb/vim-orgmode'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'will133/vim-dirdiff'
Plug 'tomasiser/vim-code-dark'
" Plug 'majutsushi/tagbar'
" Plug 'junegunn/goyo.vim'
call plug#end()

colorscheme codedark

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
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <A-CR> :call rpcnotify(1, 'ToggleFullScreen', 1)<CR>
    " FVimFontAntialias v:true
    " FVimFontSubpixel v:true
endif
