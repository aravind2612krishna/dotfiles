let g:plug_log_on = 1
call plug#begin(g:storage_home . '/.vim/plugged')
" explorer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
runtime looks.vim
runtime file_search.vim
runtime vcs.vim

if has('nvim')
    " runtime nvim_lsp_plug.vim
    " runtime coc.vim
    " runtime vimlsp.vim
    runtime lsc.vim
    " runtime lcn.vim
    " runtime lamp.vim
else
    runtime vimlsp.vim
    " runtime lsc.vim
    " runtime termdebug.vim
    Plug 'vim/killersheep'
    Plug 'puremourning/vimspector'
    Plug 'honza/vim-snippets'
    let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
endif

Plug 'psf/black', { 'branch': 'stable','for': 'python' }
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

Plug 'rhysd/vim-grammarous'

" tcl
" Plug 'JessicaKMcIntosh/Nagelfar-Vim'
" autocmd FileType tcl compiler nagelfar
" Plug 'dense-analysis/ale', {'for': 'tcl'}

call plug#end()

" Check if a plugin is plugged in plug section or not
function! s:IsPlugged(plugin) abort
    return has_key(g:plugs, a:plugin)
endfunction

set background=dark

" colorscheme ayu
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme

colorscheme codedark

" colorscheme gruvbox

" colorscheme solarized8_flat
" colorscheme flattened_light

" let g:monochrome_italic_comments = 1
" colorscheme monochrome

" colorscheme space-vim-dark

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
    " FVimUIPopupMenu v:false      " external popup menu
    " FVimUITabLine v:false       " external tabline -- not implemented
    " FVimUICmdLine v:false       " external cmdline -- not implemented
    " FVimUIWildMenu v:false      " external wildmenu -- not implemented
    " FVimUIMessages v:false      " external messages -- not implemented
    " FVimUITermColors v:false    " not implemented
    " FVimUIHlState v:false       " not implemented
endif

if s:IsPlugged('nvim-lsp')
    runtime nvim_lsp.vim
endif

if s:IsPlugged('context.vim')
    let g:context_enabled = 0
    let g:context_add_mappings = 0
    let g:context_add_autocmds = 1
    let g:context_border_char = ' '
    " let g:context_border_char = '┈'
    let g:context_highlight_normal = 'Directory'
    let g:context_highlight_border = 'ErrorMsg'
    let g:context_max_height = 5
    let g:context_max_per_indent = 1
    let g:context_nvim_no_redraw = 0
    nnoremap <C-G> <cmd>ContextPeek<CR>
    " let g:context_presenter = "preview"
    " augroup context_plugin
    "     autocmd!
    "     " this one is which you're most likely to use?
    "     autocmd CursorHold *.cxx,*.cpp,*.h ContextPeek
    " augroup end
endif

silent let g:echodoc#enable_at_startup = 1

if !empty($P4CLIENT)
    set title
    let &titlestring="nvim-" . $P4CLIENT
endif

" {{{ grammarous
nnoremap <leader>gi <Plug>(grammarous-move-to-info-window) "Move the cursor to the info window
nnoremap <leader>gf <Plug>(grammarous-fixit) 	Fix the error under the cursor automatically
nnoremap <leader>gn <Plug>(grammarous-move-to-next-error) 	Move cursor to the next error
nnoremap <leader>gp <Plug>(grammarous-move-to-previous-error) 	Move cursor to the previous error
" }}}
