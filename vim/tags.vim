Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"
if executable('ctags')
    Plug 'ludovicchabant/vim-gutentags'
    " Plug 'skywind3000/vim-preview'
    "{{{ OmniCppComplete
    Plug 'vim-scripts/OmniCppComplete'
    let OmniCpp_NamespaceSearch = 2
    let OmniCpp_GlobalScopeSearch = 1
    let OmniCpp_ShowAccess = 1
    let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
    let OmniCpp_MayCompleteDot = 1 " autocomplete after .
    let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
    let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
    let OmniCpp_DefaultNamespaces = ["std"]
    au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
    " }}}
endif

if executable('gtags')
    Plug 'skywind3000/gutentags_plus'
    " enable gtags module
    let g:gutentags_modules = ['ctags', 'gtags_cscope']
    " let g:gutentags_modules = ['ctags']
    " config project root markers.
    let g:gutentags_project_root = ['.root']
    " generate datebases in my cache directory, prevent gtags files polluting my project
    let g:gutentags_cache_dir = expand(g:storage_home . '/.cache/tags')
    " forbid gutentags adding gtags databases
    let g:gutentags_auto_add_gtags_cscope = 0
    let g:gutentags_plus_nomap = 1
    noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
    noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
    noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
    noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
    noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
    noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
    noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
    noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
    noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
    " set cscopetag
    " set cscopeprg='gtags-cscope'
endif

Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
