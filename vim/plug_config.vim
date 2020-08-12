let g:plug_log_on = 1
call plug#begin(g:storage_home . '/.vim/plugged/pack/packager/opt')

" Check if a plugin is plugged in plug section or not
function! s:IsPlugged(plugin) abort
    return has_key(g:plugs, a:plugin)
endfunction


" LSP
if has('nvim')

    " Plug 'neovim/nvim-lsp' " {{{ nvim_lsp
    " Plug 'nvim-lua/diagnostic-nvim'
    " Plug 'nvim-lua/lsp-status.nvim'
    " Plug 'nvim-lua/completion-nvim' " }}}

    Plug 'natebosch/vim-lsc', { 'for' : ['cpp', 'python'] } " {{{ lsc
    Plug 'Chiel92/vim-autoformat' " }}}

    " Plug 'neoclide/coc.nvim', {'branch': 'release'} " {{{ coc
    " " Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    " Plug 'honza/vim-snippets'
    " Plug 'neoclide/coc-highlight'
    " Plug 'm-pilia/vim-ccls' " }}}

    " Plug 'prabirshrestha/vim-lsp' " {{{ vim-lsp
    " Plug 'prabirshrestha/asyncomplete.vim'
    " Plug 'prabirshrestha/asyncomplete-lsp.vim'
    " Plug 'prabirshrestha/asyncomplete-buffer.vim' " }}}

    " " {{{ lcn
    " Plug 'autozimu/LanguageClient-neovim', {
    "             \ 'branch': 'next',
    "             \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
    "             \ }
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Plug 'Shougo/echodoc.vim' " }}}

    " Plug 'nvim-treesitter/nvim-treesitter' " Tree sitter
    " Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}

else

    Plug 'natebosch/vim-lsc', { 'for' : ['cpp', 'python'] } " {{{ lsc
    Plug 'Chiel92/vim-autoformat'
    Plug 'kkoenig/wimproved.vim' " }}}

endif

if has('nvim')
    if !s:IsPlugged('coc.nvim')
        Plug 'hrsh7th/vim-vsnip'
        Plug 'hrsh7th/vim-vsnip-integ'
    endif
else
    Plug 'puremourning/vimspector'
    Plug 'kkoenig/wimproved.vim' 
endif

Plug 'liuchengxu/vista.vim', { 'for' : ['cpp', 'python'] }

" Misc
Plug 'tpope/vim-commentary'
Plug 'jceb/vim-orgmode'
Plug 'vimwiki/vimwiki'
Plug 'wellle/context.vim', {'for': 'cpp'}
Plug 'psf/black', { 'branch': 'stable','for': 'python' }
Plug 'skywind3000/asyncrun.vim'

" Looks
if exists('g:neovide')
    let g:neovide_cursor_vfx_mode = "wireframe"
else
    if has('nvim')
        Plug 'DanilaMihailov/beacon.nvim'
    endif
endif
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ryanoasis/vim-devicons'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tomasiser/vim-code-dark'
Plug 'itchyny/lightline.vim'

" File search, fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
" Plug 'kassio/neoterm'

" VCS
Plug 'mhinz/vim-signify', { 'for' : ['cpp', 'python'] }

call plug#end()

" runtime statusline_mak.vim

" {{{ nvim_lsp
if s:IsPlugged('nvim-lsp')
    runtime nvim_lsp.vim
endif
" }}}

" {{{ vim_lsc
if s:IsPlugged('vim-lsc')
    runtime lsc_config.vim
endif
" }}}

" {{{ coc
if s:IsPlugged('coc')
    runtime coc-config.vim
endif
" }}}

" {{{ vim_lsp
if s:IsPlugged('vim-lsp')
    runtime vim_lsp_config.vim
endif
" }}}

" {{{ lcn
if s:IsPlugged('LanguageClient-neovim')
    runtime lcn_config.vim
endif
" }}}

if s:IsPlugged('nvim-treesitter')
    " lua require'treesitter_config'.config_treesitter()
endif

" {{{ snippets
if s:IsPlugged('vim-vsnip')
    imap <expr> <silent> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-l>'
    imap <expr> <silent> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    smap <expr> <silent> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    imap <expr> <silent> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    smap <expr> <silent> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    imap <expr> <silent> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
    smap <expr> <silent> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
endif
" }}}

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
    " FVimUIPopupMenu v:false      " external popup menu
    " FVimUITabLine v:false       " external tabline -- not implemented
    " FVimUICmdLine v:false       " external cmdline -- not implemented
    " FVimUIWildMenu v:false      " external wildmenu -- not implemented
    " FVimUIMessages v:false      " external messages -- not implemented
    " FVimUITermColors v:false    " not implemented
    " FVimUIHlState v:false       " not implemented
endif
" }}}

" {{{ Context.vim
if s:IsPlugged('context.vim')
    let g:context_enabled = 0
    let g:context_add_mappings = 0
    let g:context_add_autocmds = 1
    let g:context_border_char = ' '
    " let g:context_border_char = '┈'
    let g:context_highlight_normal = 'Directory'
    let g:context_highlight_border = 'ErrorMsg'
    " let g:context_max_height = 5
    let g:context_max_per_indent = 1
    let g:context_nvim_no_redraw = 0
    nnoremap <C-[> <cmd>ContextPeek<CR>
    " let g:context_presenter = "preview"
    " augroup context_plugin
    "     autocmd!
    "     " this one is which you're most likely to use?
    "     autocmd CursorHold *.cxx,*.cpp,*.h ContextPeek
    " augroup end
endif
" }}}

" {{{ FZF/FileSearch
if s:IsPlugged('ctrlp.vim')
    let g:ctrlp_map = '<leader>f'
    let g:ctrlp_working_path_mode = '0'
    set wildignore+=.clangd\\*,*.o,*.lib,*.dll,*.exe
    let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
    let g:ctrlp_use_caching = 1

    if s:IsPlugged('fruzzy')
        " optional - but recommended - see below
        let g:fruzzy#usenative = 1
        " tell CtrlP to use this matcher
        let g:ctrlp_match_func = {'match': 'fruzzy#ctrlp#matcher'}
        let g:ctrlp_match_current_file = 1 " to include current file in matches
    endif

elseif s:IsPlugged('vim-clap')
    nnoremap <leader>m :Clap history<CR>
    nnoremap <leader>f :Clap files<CR>
    nnoremap <leader>b :Clap buffers<CR>
elseif s:IsPlugged('LeaderF')
    let g:Lf_WindowPosition = 'popup'
    nnoremap <leader>m :LeaderfMru<CR>
    nnoremap <leader>f :LeaderfFile<CR>
    nnoremap <leader>b :LeaderfBuffer<CR>
elseif s:IsPlugged('vim-ctrlspace')
    if has('win32')
        let s:vimfiles = g:storage_home . '/.vim/plugged/pack/packager/opt/vim-ctrlspace'
        let s:os   = 'windows'
    else
        let s:vimfiles = '~/.vim'
        if has('mac') || has('gui_macvim')
            let s:os = 'darwin'
        else
            " elseif has('gui_gtk2') || has('gui_gtk3')
            let s:os = 'linux'
        endif
    endif

    let g:CtrlSpaceDefaultMappingKey = "<C-space> "
    let g:CtrlSpaceFileEngine = s:vimfiles . '/bin/file_engine_' . s:os . '_amd64.exe'
    let g:CtrlSpaceSearchTiming = 500

    if executable("fd")
        let g:CtrlSpaceGlobCommand = 'fd --type file'
    endif
elseif s:IsPlugged('fzf.vim')
    nnoremap <leader>m :FZFMru<CR>
    nnoremap <leader>f :FZF<CR>
    nnoremap <leader>b :Buffers<CR>
endif

if s:IsPlugged('fzf.vim')
    " Border style (rounded / sharp / horizontal)
    " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Todo', 'border': 'sharp' } }

    " An action can be a reference to a function that processes selected lines
    function! s:build_quickfix_list(lines)
        call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
        copen
        cc
    endfunction

    let g:fzf_action = {
                \ 'ctrl-q': function('s:build_quickfix_list'),
                \ 'ctrl-t': 'tab split',
                \ 'ctrl-x': 'split',
                \ 'ctrl-v': 'vsplit' }

    " Default fzf layout
    " - down / up / left / right
    " let g:fzf_layout = { 'down': '40%' }
endif
" }}}

" {{{ asyncrun rg/grep
if s:IsPlugged('asyncrun.vim')
    if executable('rg')
        map <leader>r :AsyncRun rg -in <C-R><C-W> <C-R>=expand("%:.:h") <CR>
    else
        if executable('grep')
            map <leader>r :AsyncRun grep -Rn <C-R><C-W> <C-R>=expand("%:p:h") . "/*" <CR>
        endif
    endif
endif
" }}}

" {{{ looks 
if s:IsPlugged('vim-indent-guides')
    let g:indent_guides_start_level=2
    let g:indent_guides_guide_size=1
    let g:indent_guides_enable_on_vim_startup = 1
endif
if s:IsPlugged('lightline.vim')
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
endif
set listchars=tab:▸\ ,extends:▸,precedes:◂,nbsp:●,eol:↦
set list
set fillchars+=vert:│
if s:IsPlugged('vim-code-dark')
    colorscheme codedark
endif
if !has('nvim')
    set guifont=Iosevka:h14:cANSI:qDRAFT
else
    set guifont=Iosevka:h17
    " set guifont=Iosevka\ Slab:h18
    " set guifont=Iosevka\ SS08:h18
endif

" }}}

" {{{ misc
if !empty($P4CLIENT)
    set title
    let &titlestring="vim-" . $P4CLIENT
endif

let g:black_linelength=79
let g:vista_sidebar_width=96
" let g:signify_disable_by_default=1

if has('nvim')
    set inccommand=split
endif

let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" }}}
