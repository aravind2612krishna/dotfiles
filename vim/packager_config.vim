let &packpath = g:storage_home . '/.vim/plugged/,' . &packpath

if &compatible
  set nocompatible
endif

function! PackagerInit() abort
    packadd vim-packager
    call packager#init()
    " nvim_lsp
    call packager#add('neovim/nvim-lsp', { 'type': 'opt' })
    call packager#add('nvim-lua/diagnostic-nvim', { 'type': 'opt' })
    call packager#add('nvim-lua/completion-nvim', { 'type': 'opt' })
    " vim-lsc
    call packager#add('natebosch/vim-lsc', { 'type': 'opt' })
    call packager#add('Chiel92/vim-autoformat', { 'type': 'opt' })
    " coc
    call packager#add('neoclide/coc.nvim', { 'type': 'opt', 'branch': 'release'})
    " call packager#add('neoclide/coc.nvim', { 'type': 'opt' }, {'branch': 'master', 'do': 'yarn install --frozen-lockfile'})
    call packager#add('honza/vim-snippets', { 'type': 'opt' })
    call packager#add('neoclide/coc-highlight', { 'type': 'opt' })
    call packager#add('m-pilia/vim-ccls', { 'type': 'opt' })
    " vimlsp
    call packager#add('prabirshrestha/vim-lsp', { 'type': 'opt' })
    call packager#add('prabirshrestha/asyncomplete.vim', { 'type': 'opt' })
    call packager#add('prabirshrestha/asyncomplete-lsp.vim', { 'type': 'opt' })
    call packager#add('prabirshrestha/asyncomplete-buffer.vim', { 'type': 'opt' })
    " lcn
    call packager#add('autozimu/LanguageClient-neovim', { 'type': 'opt', 'branch': 'next', 'do': 'powershell -executionpolicy bypass -File install.ps1' })
    call packager#add('Shougo/deoplete.nvim', { 'type': 'opt', 'do': ':UpdateRemotePlugins' })
    call packager#add('Shougo/echodoc.vim', { 'type': 'opt' })
    " snippets
    call packager#add('hrsh7th/vim-vsnip', { 'type': 'opt' })
    call packager#add('hrsh7th/vim-vsnip-integ', { 'type': 'opt' })
    " debugger
    call packager#add('puremourning/vimspector', { 'type': 'opt' })
    " vista/tagbar
    call packager#add('liuchengxu/vista.vim', { 'type': 'opt' })
    " gvim fullscreen
    call packager#add('kkoenig/wimproved.vim', { 'type': 'opt' })
    " easy commenting
    call packager#add('tpope/vim-commentary', { 'type': 'opt' })
    " org mode
    call packager#add('jceb/vim-orgmode', { 'type': 'opt' })
    " context (current function on top of file, useful!)
    call packager#add('wellle/context.vim', {'type': 'opt'})
    " Black for python formatting
    call packager#add('psf/black', { 'type': 'opt' , 'branch': 'stable'})
    " AsyncRun for quickfix population in async
    call packager#add('skywind3000/asyncrun.vim', { 'type': 'opt' })
    " Looks
    " cursor effects
    call packager#add('DanilaMihailov/beacon.nvim', { 'type': 'opt' })
    call packager#add('nathanaelkane/vim-indent-guides', { 'type': 'opt' })
    call packager#add('ryanoasis/vim-devicons', { 'type': 'opt' })
    call packager#add('octol/vim-cpp-enhanced-highlight', { 'type': 'opt' })
    " colorscheme
    call packager#add('tomasiser/vim-code-dark')
    " statusline
    call packager#add('itchyny/lightline.vim')
    " File search, fzf
    call packager#add('junegunn/fzf', { 'type': 'opt' })
    call packager#add('junegunn/fzf.vim', { 'type': 'opt' })
    call packager#add('pbogut/fzf-mru.vim', { 'type': 'opt' })
    " VCS
    call packager#add('mhinz/vim-signify', { 'type': 'opt' })
endfunction

command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()

" autocmd FileType cpp,python once packadd 
augroup packager_cpp_python
    autocmd!
    if v:false " has('nvim')
        autocmd FileType cpp,python packadd nvim-lsp
        autocmd FileType cpp,python packadd diagnostic-nvim
        autocmd FileType cpp,python packadd completion-nvim
    else
        " lsc
        autocmd FileType cpp,python packadd vim-lsc | packadd vim-autoformat | runtime lsp_settings.vim
        " " coc
        " autocmd FileType cpp,python packadd coc.nvim
        " " call packager#add('neoclide/coc.nvim', { 'type': 'opt' }, {'branch': 'master', 'do': 'yarn install --frozen-lockfile'})
        " autocmd FileType cpp,python packadd vim-snippets
        " autocmd FileType cpp,python packadd coc-highlight
        " autocmd FileType cpp,python packadd vim-ccls
        " " vimlsp
        " autocmd FileType cpp,python packadd vim-lsp
        " autocmd FileType cpp,python packadd asyncomplete.vim
        " autocmd FileType cpp,python packadd asyncomplete-lsp.vim
        " autocmd FileType cpp,python packadd asyncomplete-buffer.vim
        " " lcn
        " autocmd FileType cpp,python packadd LanguageClient-neovim
        " autocmd FileType cpp,python packadd deoplete.nvim
        " autocmd FileType cpp,python packadd echodoc.vim
    endif
    " autocmd FileType cpp,python ++once runtime lsp_settings.vim
    autocmd FileType cpp packadd vim-cpp-enhanced-highlight
    autocmd FileType cpp,python packadd vim-signify
    autocmd FileType python packadd black
augroup END

augroup vim_enter_rc
    autocmd!
    if has('nvim')
        autocmd VimEnter * packadd beacon.vim
    else
        " gvim fullscreen
        autocmd VimEnter * packadd wimproved.vim
    endif
    autocmd VimEnter * packadd vim-commentary
    autocmd VimEnter * packadd vim-orgmode
    " autocmd VimEnter * packadd context.vim
    autocmd VimEnter * packadd fzf
    autocmd VimEnter * packadd fzf.vim
    autocmd VimEnter * packadd fzf-mru.vim
    autocmd VimEnter * packadd asyncrun.vim
    autocmd VimEnter * echom "Let's go!"
augroup END

runtime plugin_config.vim
