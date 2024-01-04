" {{{ Static definitions

if has('win32')
    let s:os   = 'windows'
else
    if has('mac') || has('gui_macvim')
        let s:os = 'darwin'
    else
        let s:os = 'linux'
    endif
endif

let s:plug_opt_path = g:storage_home . '/.vim/plugged/pack/packager/opt'

" Check if a plugin is plugged in plug section or not
function! s:IsPlugged(plugin) abort
    return has_key(g:plugs, a:plugin)
endfunction

let s:lsp_client = 'coc' " native, coc
let s:use_coc_nvim = (s:lsp_client == 'coc')
let s:use_native_lsp = has('nvim') && (s:lsp_client == 'native')
let s:use_lsc = (s:lsp_client == 'lsc')
let s:use_treesitter = has('nvim')
let s:debugger = (s:os == 'linux' ? 'termdebug' : 'dap') " termdebug, dap
let s:use_dap = (s:debugger == 'dap')
let s:use_vimspector = (s:debugger == 'vimspector')
let g:aravk_completion = (s:lsp_client == 'native' ? 'ddc' : '') " coq, ddc

" }}}

call plug#begin(s:plug_opt_path)

" Native lsp {{{
if s:use_native_lsp
    Plug 'neovim/nvim-lsp'
    Plug 'neovim/nvim-lspconfig'
    Plug 'p00f/clangd_extensions.nvim'

    if g:aravk_completion == 'coq'
        Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
        Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    endif
    if g:aravk_completion == 'ddc'
        Plug 'Shougo/ddc.vim'
        Plug 'vim-denops/denops.vim'

        " Install your UIs
        Plug 'Shougo/ddc-ui-native'

        " Install your sources
        Plug 'Shougo/ddc-source-around'
        Plug 'Shougo/ddc-buffer'
        Plug 'Shougo/ddc-buffer'
        Plug 'Shougo/ddc-file'

        " Install your filters
        Plug 'Shougo/ddc-matcher_head'
        Plug 'Shougo/ddc-sorter_rank'
    endif

    " Plug 'ldelossa/litee.nvim'
    " Plug 'ldelossa/litee-calltree.nvim'
    " Plug 'ldelossa/litee-symboltree.nvim'
    " Plug 'ldelossa/litee-filetree.nvim'

    " Plug 'sidebar-nvim/sidebar.nvim'

    Plug 'simrat39/symbols-outline.nvim'
    " Plug 'stevearc/aerial.nvim'
    Plug 'folke/lsp-trouble.nvim'
    " Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
    " Plug 'hrsh7th/vim-vsnip'
    " Plug 'hrsh7th/vim-vsnip-integ'
    " Plug 'ray-x/navigator.lua'
endif
"" }}}

" coc.nvim {{{
if s:use_coc_nvim
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets'
    Plug 'neoclide/coc-snippets'
    Plug 'clangd/coc-clangd'
    " Plug 'kevinhwang91/promise-async'
    " Plug 'kevinhwang91/nvim-ufo'
endif
" }}}

" vim-lsc {{{ 
if s:use_lsc
    Plug 'natebosch/vim-lsc', { 'for' : ['cpp', 'python'] }
    Plug 'Chiel92/vim-autoformat'
    Plug 'kkoenig/wimproved.vim'
endif
" }}}

" Tree sitter {{{
if s:use_treesitter
    Plug 'nvim-treesitter/nvim-treesitter'
    " Plug 'nvim-treesitter/nvim-treesitter-context'
    " Plug 'folke/twilight.nvim'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    " Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'danymat/neogen'
    Plug 'Badhi/nvim-treesitter-cpp-tools'
    " Plug 'SmiteshP/nvim-gps'
    Plug 'Bekaboo/dropbar.nvim'
    Plug 'ThePrimeagen/refactoring.nvim'
    " Plug 'alexzanderr/nvim-treesitter-statusline'
    Plug 'folke/twilight.nvim'
    " Plug 'nvim-treesitter/nvim-tree-docs'
    " Plug 'haringsrob/nvim_context_vt'

    Plug 't-troebst/perfanno.nvim'

else
    Plug 'octol/vim-cpp-enhanced-highlight', { 'for' : ['cpp', 'c'] }
endif
" }}}

" fugitive
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'sindrets/diffview.nvim',
Plug 'harrisoncramer/gitlab.nvim' " , { 'do': ':lua require(\"gitlab.server\").build()' }
Plug 'mistweaverco/Screenshot.nvim'
" Plug 'tpope/vim-rhubarb'

" Debuggers {{{
if s:use_dap
    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'mfussenegger/nvim-dap-python'
endif
if s:use_vimspector
    Plug 'puremourning/vimspector'
endif
" }}}

" File search, fzf {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"}}}

" colorschemes {{{
" Plug 'rktjmp/lush.nvim'
" Plug 'ishan9299/nvim-solarized-lua'
" Plug 'savq/melange'
" Plug 'shaunsingh/solarized.nvim'
" Plug 'nyoom-engineering/oxocarbon.nvim'
" Plug 'kartikp10/noctis.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'wuelnerdotexe/vim-enfocado'
" Plug 'projekt0n/caret.nvim'
" Plug 'projekt0n/github-nvim-theme', { 'tag': 'v0.0.7' }
Plug 'tomasiser/vim-code-dark'
" }}}

" Status line {{{
if has('nvim')
    Plug 'nvim-lualine/lualine.nvim'
    " Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
    " Plug 'voldikss/vim-floaterm'
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    " Plug 'shortcuts/no-neck-pain.nvim', { 'tag': '*' }
    " Plug 'adelarsq/neoline.vim'
    " Plug 'windwp/windline.nvim'
    " Plug 'Pocco81/true-zen.nvim'
    Plug 'Eandrju/cellular-automaton.nvim'
    " Plug 'beauwilliams/focus.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    " Plug 'echasnovski/mini.tabline', { 'branch': 'stable' }
    " Plug 'echasnovski/mini.indentscope', { 'branch': 'stable' }

    " TODOs plugin
    " Plug 'phaazon/mind.nvim'
    " Plug 'nagy135/capture-nvim'
    
    " Plug 'kyazdani42/nvim-tree.lua'
    " Plug 'nvim-neo-tree/neo-tree.nvim'
    " Plug 'iamcco/markdown-preview.nvim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

    Plug 'LudoPinelli/comment-box.nvim'
    Plug 'jbyuki/venn.nvim'
else
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
endif
" }}}

" Misc {{{
Plug 'JessicaKMcIntosh/Nagelfar-Vim', { 'for' : ['tcl'] }
Plug 'will133/vim-dirdiff'
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'
Plug 'wellle/context.vim'
" Plug 'psf/black', { 'branch': 'stable','for': 'python' }
Plug 'psf/black', { 'for': 'python' }
" Plug 'averms/black-nvim'
Plug 'skywind3000/asyncrun.vim'
Plug 'ryanoasis/vim-devicons'
" Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'mhinz/vim-signify'
Plug 'ngemily/vim-vp4'
let g:vp4_prompt_on_write = v:true
"}}}

call plug#end()

if s:IsPlugged('Nagelfar-Vim') " {{{
    let g:nagelfar_tclsh='/home/aravind/repos/HmMshgFbNxtThpty_AK_1204/tcl/tcl8.5.9/linux64/bin/tclsh8.5'
    let g:nagelfar_file='~/Downloads/nagelfar131/nagelfar.tcl'
    let g:nagelfar_disable_mappings=1
endif " }}}

" Context.vim {{{ 
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

" FZF/FileSearch {{{
if s:IsPlugged('fzf.vim')
    nnoremap <leader>m <cmd>History<CR>
    nnoremap <leader>f <cmd>FZF<CR>
    nnoremap <leader>b <cmd>Buffers<CR>
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

" asyncrun rg/grep {{{
if s:IsPlugged('asyncrun.vim')
    if executable('ug')
        map <leader>r :AsyncRun ug -RnIi <C-R><C-W> <C-R>=expand("%:.:h") <CR>
    elseif executable('rg')
        map <leader>r :AsyncRun rg -in <C-R><C-W> <C-R>=expand("%:.:h") <CR>
    else
        if executable('grep')
            map <leader>r :AsyncRun grep -Rn <C-R><C-W> <C-R>=expand("%:p:h") . "/*" <CR>
        endif
    endif
endif
" }}}

if s:IsPlugged('vim-airline') " {{{
    let g:airline_detect_whitespace=0
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#wordcount#enabled = 0

    let g:airline_left_sep = '<'
    let g:airline_left_alt_sep = '|'
    let g:airline_right_sep = '>'
    let g:airline_right_alt_sep = '|'
    let g:webdevicons_enable_airline_statusline = 1

    " let g:airline_section_c='%t'
endif " }}}

" colorschemes {{{
if s:IsPlugged('melange')
    colorscheme melange
elseif s:IsPlugged('solarized.nvim')
    set background=light
    let g:solarized_italic_comments = v:true
    let g:solarized_italic_keywords = v:false
    let g:solarized_italic_functions = v:false
    let g:solarized_italic_variables = v:true
    let g:solarized_contrast = v:true
    let g:solarized_borders = v:true
    colorscheme solarized
elseif s:IsPlugged('nvim-solarized-lua')
    colorscheme solarized
    " hi! link IndentBlanklineContextStart CursorLine
elseif s:IsPlugged('noctis.nvim')
    colorscheme noctis
elseif s:IsPlugged('oxocarbon.nvim')
    colorscheme oxocarbon
elseif s:IsPlugged('github-nvim-theme')
    colorscheme github_dark
elseif s:IsPlugged('caret.nvim')
    " set background=light
    colorscheme caret
elseif s:IsPlugged('kanagawa.nvim')
    set background=dark
    lua require"kanagawacfg"
elseif s:IsPlugged('vim-enfocado')
    let g:enfocado_style = "neon"
    " let g:enfocado_style = "nature"
    " IMPORTANT: this vim auto command ensures the
    " activation of Enfocado in compatible plugins.
    autocmd VimEnter * ++nested colorscheme enfocado |
                \ hi! link TabLine CursorLineNr      |                                                                                                              
                \ hi! link TabLineSel Title          |
                " \ hi! link lualine_b_inactive DiagnosticUnderlineOk |
                " \ hi! link WinBar Underlined         |
                \ hi! link Ignore Folded
    " autocmd VimEnter * ++nested colorscheme enfocado
    " colorscheme enfocado
elseif s:IsPlugged('vim-code-dark')
    colorscheme codedark
endif
" }}}

if s:IsPlugged('vim-signify') "{{{
    let g:signify_sign_add    = '▊'  " U+258A LEFT THREE QUARTERS BLOCK (1 cell)
    let g:signify_sign_delete    = '▊'  " U+258A LEFT THREE QUARTERS BLOCK (1 cell)
    let g:signify_sign_change    = '▊'  " U+258A LEFT THREE QUARTERS BLOCK (1 cell)
    " highlight! link SignifySignChange Comment
    " highlight! link SignifySignDelete ErrorMsg
    " highlight! link SignifySignAdd Type
endif "}}}

if s:IsPlugged('gitlab.nvim')
    lua require("diffviewcfg")
    lua require("gitlabcfg")
endif

" misc {{{
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
" highlight Comment cterm=italic gui=italic
" }}}
" 
if exists('g:neoray') " {{{
    " set guifont=Victor_Mono_Regular:h14
    " set guifont=VictorMono_Nerd_Font_Mono_Medium:h14
    set guifont=JetBrainsMono:h12
    " set guifont=Go_Mono:h11
    set listchars=tab:┄\ ,extends:┄,precedes:┄,nbsp:┄,eol:┘
    NeoraySet CursorAnimTime 0.04
    NeoraySet Transparency   1.0
    NeoraySet TargetTPS      120
    NeoraySet ContextMenu    TRUE
    NeoraySet BoxDrawing     TRUE
    NeoraySet ImageViewer    TRUE
    " NeoraySet WindowSize     100x40
    NeoraySet WindowState    maximized
    NeoraySet KeyZoomIn     <C-kPlus>
    NeoraySet KeyZoomOut    <C-kMinus>
endif " }}}

if g:aravk_completion == 'coq'
    let g:coq_settings = { 
                \ 'keymap.recommended': v:true,
                \ 'keymap.pre_select' : v:true,
                \ 'keymap.jump_to_mark': "\\",
                \ 'auto_start': v:true,
                \ }
endif

if g:aravk_completion == 'ddc'
    runtime ddc_config.vim
endif

if s:use_coc_nvim
    runtime coc-config.vim
else
    ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
    ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
    ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"
endif

if s:use_lsc
    runtime lsc_config.vim
endif

if has('nvim')
    runtime luacfgs.vim
endif

" Debugger {{{
function! StartDebug() abort
    if s:debugger == 'termdebug'
        packadd termdebug
        runtime termdebug.vim
        let g:termdebug_wide = 163
        if s:IsPlugged('focus.nvim')
            lua require('focus').focus_disable()
        endif
        execute "Termdebug"
    endif
endfunction
" }}}

" Markdownpreview {{{
function OpenMarkdownPreview (url)
    execute "silent ! firefox --new-window " . a:url
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'
" }}}
