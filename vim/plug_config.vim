let g:plug_log_on = 1
let g:plug_opt_path = g:storage_home . '/.vim/plugged/pack/packager/opt'
call plug#begin(g:plug_opt_path)

" Check if a plugin is plugged in plug section or not
function! s:IsPlugged(plugin) abort
    return has_key(g:plugs, a:plugin)
endfunction


" LSP
if has('nvim')

    " Plug 'neovim/nvim-lsp' " {{{ nvim_lsp
    " Plug 'neovim/nvim-lspconfig'
    " Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    " Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    " " Plug 'hrsh7th/nvim-compe'
    " " Plug 'ojroques/nvim-lspfuzzy'
    " " Plug 'glepnir/lspsaga.nvim'
    " Plug 'kyazdani42/nvim-web-devicons'
    " Plug 'simrat39/symbols-outline.nvim'
    " " Plug 'stevearc/aerial.nvim'
    " " Plug 'ray-x/lsp_signature.nvim'
    " Plug 'folke/lsp-trouble.nvim'
    " Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
    " " Plug 'ray-x/navigator.lua'

    " Plug 'natebosch/vim-lsc', { 'for' : ['cpp', 'python'] } " {{{ lsc
    " Plug 'Chiel92/vim-autoformat' " }}}

    " Plug 'neoclide/coc.nvim', {'branch': 'release'} " {{{ coc
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    Plug 'honza/vim-snippets'
    Plug 'neoclide/coc-snippets'
    Plug 'clangd/coc-clangd'

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


    Plug 'nvim-treesitter/nvim-treesitter' " Tree sitter
    Plug 'romgrk/nvim-treesitter-context'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'lukas-reineke/indent-blankline.nvim'
    " Plug 'nvim-treesitter/nvim-tree-docs'
    " Plug 'haringsrob/nvim_context_vt'
    " Plug 'SmiteshP/nvim-gps'
    " " Plug 'nvim-treesitter/nvim-treesitter-refactor'

    " Plug 'nvim-treesitter/playground'
    " Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}

    " Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
    Plug 'JessicaKMcIntosh/Nagelfar-Vim', { 'for' : ['tcl'] }
    
    " Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    
    " Plug 'cpiger/NeoDebug'

    Plug 'simonefranza/nvim-conv'

    packadd termdebug
    let g:termdebug_wide = 163

    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'

    " Plug 'puremourning/vimspector'

    Plug 'beauwilliams/focus.nvim'

else

    Plug 'natebosch/vim-lsc', { 'for' : ['cpp', 'python'] } " {{{ lsc
    Plug 'Chiel92/vim-autoformat'
    Plug 'kkoenig/wimproved.vim' " }}}

endif

Plug 'will133/vim-dirdiff'

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
Plug 'wellle/context.vim'
Plug 'psf/black', { 'branch': 'stable','for': 'python' }
Plug 'skywind3000/asyncrun.vim'
" Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}

" Looks
if exists('g:neovide')
    let g:neovide_cursor_vfx_mode = "wireframe"
else
    if has('nvim')
        " Plug 'DanilaMihailov/beacon.nvim'
        " Plug 'TaDaa/vimade'
        " Plug 'dstein64/nvim-scrollview'
    endif
endif

" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'yuntan/neovim-indent-guides'
" Plug 'Yggdroot/indentLine'
" let g:indentLine_char = '│'

Plug 'ryanoasis/vim-devicons'
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'jackguo380/vim-lsp-cxx-highlight'

" Treesitter colorscheme
" Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
" Plug 'ishan9299/nvim-solarized-lua'
" Plug 'shaunsingh/solarized.nvim'
" Plug 'projekt0n/github-nvim-theme'
" Plug 'yashguptaz/calvera-dark.nvim'
" Plug 'marko-cerovac/material.nvim'
" Plug 'glepnir/zephyr-nvim'
" Plug 'wadackel/vim-dogrun'
" Plug 'rakr/vim-one'
" Plug 'flazz/vim-colorschemes'
" Plug 'morhetz/gruvbox'
" Plug 'olimorris/onedarkpro.nvim'
Plug 'wuelnerdotexe/vim-enfocado'
" Plug 'tomasiser/vim-code-dark'

" Plug 'beauwilliams/statusline.lua'


if v:true " !exists('g:goneovim')
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
endif

" Plug 'itchyny/lightline.vim'
" Plug 'josa42/vim-lightline-coc'
" Plug 'datwaft/bubbly.nvim'
" Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
" Plug 'hoob3rt/lualine.nvim'
Plug 'nvim-lualine/lualine.nvim'
" Plug 'adelarsq/neoline.vim'

" Plug 'kkoomen/vim-doge', {'for': 'cpp', 'do': { -> doge#install() } }
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" File search, fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
" Plug 'kassio/neoterm'

" VCS
" Plug 'mhinz/vim-signify', { 'for' : ['cpp', 'python', 'tcl'] }
Plug 'mhinz/vim-signify'
Plug 'ngemily/vim-vp4'
let g:vp4_prompt_on_write = v:false

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
if s:IsPlugged('coc.nvim')
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

if s:IsPlugged('nvim-treesitter') "{{{
    lua require'treesitter_config'.config_treesitter()
endif "}}}

" if s:IsPlugged('lspsaga.nvim')
"     lua require'lspsaga_cfg'
" endif

if s:IsPlugged('Nagelfar-Vim') " {{{
    let g:nagelfar_tclsh='/home/aravind/repos/HmMshgFbNxtThpty_AK_1204/tcl/tcl8.5.9/linux64/bin/tclsh8.5'
    let g:nagelfar_file='~/Downloads/nagelfar131/nagelfar.tcl'
    let g:nagelfar_disable_mappings=1
endif " }}}

if s:IsPlugged('nvim-gdb') " {{{
    let g:nvimgdb_config_override = {
                \ 'key_frameup': '<PageUp>',
                \ 'key_framedown': '<PageDown>',
                \ }

    function! GdbJumpBack()
        let l:gdb_cmd = "tbreak " . line(".")
        echo GdbCustomCommand(l:gdb_cmd)
        let l:gdb_cmd = "jump " . line(".")
        echo GdbCustomCommand(l:gdb_cmd)
    endfunction
    " cabbrev GdbJumpBack :call GdbJumpBack()
    nnoremap <S-F10> :call GdbJumpBack()<CR>
    nnoremap <M-C-P> :call GdbCustomCommand("pattach hw")<CR>

endif " }}}

" {{{ snippets
if v:false " s:IsPlugged('vim-vsnip')
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
    " let g:context_border_char = ' '
    let g:context_border_char = '┈'
    let g:context_border_char = '━'
    let g:context_highlight_normal = 'Directory'
    let g:context_highlight_border = 'ErrorMsg'
    " let g:context_max_height = 5
    let g:context_max_per_indent = 3
    let g:context_nvim_no_redraw = 1
    nnoremap <C-[> <cmd>ContextPeek<CR>
    let g:context_highlight_normal = 'Directory'
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
    nnoremap <leader>m <cmd>FZFMru<CR>
    nnoremap <leader>f <cmd>FZF<CR>
    nnoremap <leader>b :Buffers<CR>
    " nnoremap <leader>b <cmd>Uivonim buffers<CR>
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
    elseif executable('ug')
        map <leader>r :AsyncRun ug -Rn <C-R><C-W> <C-R>=expand("%:.:h") <CR>
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
if s:IsPlugged('bubbly.nvim')
    lua require'bubbly'.config_bubbly()
endif
if s:IsPlugged('lualine.nvim')
    lua require'lualine_cfg'
endif
if s:IsPlugged('galaxyline.nvim')
    lua require'evilline'
    " lua require'spaceline'
endif
if s:IsPlugged('vim-airline')
    let g:airline_detect_whitespace=0
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#wordcount#enabled = 0

    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:webdevicons_enable_airline_statusline = 1

    " let g:airline_section_c='%t'

endif

if s:IsPlugged('nvim-dap')
    runtime dapcfg.lua
    lua require'dapcfg'
    if s:IsPlugged('nvim-dap-ui')
        lua require'dapuicfg'
    endif
endif

function! MyFiletype() abort
    " if exists('g:fvim_loaded')
    if has('neovim')
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
    else
        return winwidth(0) > 70 ? (&filetype) : ''
    endif
endfunction

function! MyFileformat() abort
    " if exists('g:fvim_loaded')
    if has('neovim')
        return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
    else
        return winwidth(0) > 70 ? (&fileformat) : ''
    endif
endfunction

if s:IsPlugged('lightline.vim')

    function! MyFiletype() abort
        " if exists('g:fvim_loaded')
        if has('neovim')
            return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
        else
            return winwidth(0) > 70 ? (&filetype) : ''
        endif
    endfunction

    function! MyFileformat() abort
        " if exists('g:fvim_loaded')
        if has('neovim')
            return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
        else
            return winwidth(0) > 70 ? (&fileformat) : ''
        endif
    endfunction

    let g:lightline = {}
    let g:lightline.active = {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'readonly', 'filename', 'modified',
                \               'linter_warnings', 'linter_errors', 'linter_ok',
                \               'status', 'vcs'] ],
                \ 'right': [ [ 'lineinfo' ],
                \            [ 'percent' ],
                \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
                \ }
    let g:lightline.component_expand = {
                \   'linter_warnings': 'lightline#coc#warnings',
                \   'linter_errors': 'lightline#coc#errors',
                \   'linter_ok': 'lightline#coc#ok',
                \   'status': 'lightline#coc#status',
                \ }
    " Set color to the components:
    let g:lightline.component_type = {
                \   'linter_warnings': 'warning',
                \   'linter_errors': 'error',
                \   'linter_ok': 'left',
                \ }
    let g:lightline.component_function = {
                \   'filetype': 'MyFiletype',
                \   'fileformat': 'MyFileformat',
                \   'vcs': 'LightlineSignify'
                \ }
    let g:lightline.colorscheme = 'selenized_black'
    call lightline#coc#register()
endif

if exists('g:fvim_loaded')
    " set listchars=tab:┄\ ,extends:┄,precedes:┄,nbsp:┄,eol:┘
    FVimUIPopupMenu v:false
    set listchars=tab:▸\ ,extends:▸,precedes:◂,nbsp:●,eol:↦
else
    set listchars=tab:▸\ ,extends:▸,precedes:◂,nbsp:●,eol:↦
endif
set list
set fillchars+=vert:│
if s:IsPlugged('github-nvim-theme')
    lua require('github-theme').setup({ theme_style = "light" })
elseif s:IsPlugged('nvim-solarized-lua')
    colorscheme solarized
elseif s:IsPlugged('solarized.nvim')
    set background=light
    let g:solarized_italic_comments = v:true
    let g:solarized_italic_keywords = v:false
    let g:solarized_italic_functions = v:true
    let g:solarized_italic_variables = v:true
    let g:solarized_contrast = v:true
    let g:solarized_borders = v:true
    colorscheme solarized
elseif s:IsPlugged('spacebuddy')
    lua require('colorbuddy').colorscheme('spacebuddy')
elseif s:IsPlugged('nvcode-color-schemes.vim')
    let g:nvcode_termcolors=256
    colorscheme nvcode
    " colorscheme onedark
    " colorscheme gruvbox
elseif s:IsPlugged('vim-colorschemes')
    set background=light
    colorscheme flattened_light
elseif s:IsPlugged('vim-dogrun')
    colorscheme dogrun
elseif s:IsPlugged('vim-one')
    colorscheme one
elseif s:IsPlugged('material.nvim')
    colorscheme material
    let g:material_italic_comments = v:true
    let g:material_style = 'darker'
elseif s:IsPlugged('zephyr-nvim')
    colorscheme zephyr
elseif s:IsPlugged('calvera-dark.nvim')
    colorscheme calvera
elseif s:IsPlugged('gruvbox')
    " set background=light
    colorscheme gruvbox
elseif s:IsPlugged('onedarkpro.nvim')
    " lua require('onedarkpro').setup({theme = "onelight"})
    lua require('onedarkpro').load()
    colorscheme onedark
elseif s:IsPlugged('darkplus.nvim')
    colorscheme darkplus
elseif s:IsPlugged('vim-enfocado')
    " let g:enfocado_style = "neon"
    " IMPORTANT: this vim auto command ensures the
    " activation of Enfocado in compatible plugins.
    autocmd VimEnter * ++nested colorscheme enfocado
    " colorscheme enfocado
elseif s:IsPlugged('vim-code-dark')
    colorscheme codedark
endif

if !has('nvim')
    set guifont=Iosevka:h14:cANSI:qDRAFT
else
    " set guifont=Victor\ Mono:h12
    " set guifont=Input\ Mono:h12
    " set guifont=VictorMono\ Nerd\ Font\ Mono:h12
    " set guifont=Iosevka:h16
    set guifont=IBM\ Plex\ Mono\ Text:h14
    " set guifont=Iosevka\ Slab:h18
    " set guifont=Iosevka\ SS08:h18
endif

" }}}

if s:IsPlugged('vim-signify')
    let g:signify_sign_add    = '▊'  " U+258A LEFT THREE QUARTERS BLOCK (1 cell)
    let g:signify_sign_delete    = '▊'  " U+258A LEFT THREE QUARTERS BLOCK (1 cell)
    let g:signify_sign_change    = '▊'  " U+258A LEFT THREE QUARTERS BLOCK (1 cell)
    " highlight! link SignifySignChange Comment
    " highlight! link SignifySignDelete ErrorMsg
    " highlight! link SignifySignAdd Type
endif

if s:IsPlugged('lsp-trouble.nvim')
    nnoremap <leader>xx <cmd>LspTroubleToggle<cr>
endif

if s:IsPlugged('indent-blankline.nvim')
    lua require'indentline'
    let g:indent_blankline_char = "│"
    " let g:indent_blankline_use_treesitter = v:true
    let g:indent_blankline_show_current_context = v:true
    let g:indent_blankline_context_patterns = ['class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments']
endif

if s:IsPlugged('NeoDebug')
    runtime NeoDebugConfig.vim
endif

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
highlight Comment cterm=italic gui=italic

" }}}
" 
if exists('g:neoray')
    " set guifont=Victor_Mono_Regular:h14
    set guifont=VictorMono_Nerd_Font_Mono_Medium:h14
    set listchars=tab:┄\ ,extends:┄,precedes:┄,nbsp:┄,eol:┘
    let neoray_cursor_animation_time=0
    " let neoray_framebuffer_transparency=0.95
    let neoray_target_ticks_per_second=60
    let neoray_popup_menu_enabled=1
    let neoray_window_startup_state='maximized'
    let neoray_key_toggle_fullscreen='<M-C-CR>' " AltGr+Enter
    let neoray_key_increase_fontsize='<C-PageUp>'
    let neoray_key_decrease_fontsize='<C-PageDown>'
endif

if s:IsPlugged('nvim-gps')
lua << EOF
    require("nvim-gps").setup({
        icons = {
            ["class-name"] = ' ',      -- Classes and class-like objects
            ["function-name"] = ' ',   -- Functions
            ["method-name"] = ' '      -- Methods (functions inside class-like objects)
        },
        languages = {                    -- You can disable any language individually here
            ["c"] = true,
            ["cpp"] = true,
            ["go"] = false,
            ["java"] = false,
            ["javascript"] = false,
            ["lua"] = false,
            ["python"] = true,
            ["rust"] = false,
        },
        separator = ' > ',
    })
EOF
endif

if s:IsPlugged('focus.nvim')
    "You must run setup() to begin using focus
    lua require("focus").setup()
endif

if s:IsPlugged('coq_nvim')
    let g:coq_settings = { 'keymap.bigger_preview': "<C-z>", 'keymap.jump_to_mark': "<C-h>" }
endif

if s:IsPlugged('nvim-treesitter-context')
lua << EOF
    require'treesitter-context'.setup{
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
            -- For all filetypes
            -- Note that setting an entry here replaces all other patterns for this entry.
            -- By setting the 'default' entry below, you can control which nodes you want to
            -- appear in the context window.
            default = {
                'class',
                'function',
                'method',
                'for',
                'while',
                'if',
                'switch',
                'case',
            },
            -- Example for a specific filetype.
            -- If a pattern is missing, *open a PR* so everyone can benefit.
            --   rust = {
            --       'impl_item',
            --   },
        },
    }
EOF
endif
