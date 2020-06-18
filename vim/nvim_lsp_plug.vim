Plug 'neovim/nvim-lsp'

" {{{ ncm2
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2'

" " IMPORTANT: :help Ncm2PopupOpen for more information
" set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" }}}

" {{{ completion-nvim
Plug 'haorenW1025/completion-nvim'
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" set completeopt+=preview

" {{{ UltiSnips
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" }}}

""{{{ vim-vsnip
"Plug 'hrsh7th/vim-vsnip'
"Plug 'hrsh7th/vim-vsnip-integ'
"imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'
"imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
"smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
"imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
"smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
"imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
"smap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
"" }}}

" }}}


" {{{ diagnostics
Plug 'haorenW1025/diagnostic-nvim'
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1
" }}}

" {{{ deoplete
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/deoplete-lsp'
" Plug 'Shougo/echodoc.vim'

" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1
" set cmdheight=2
" let g:echodoc#enable_at_startup = 1
" let g:echodoc#highlight_arguments="Visual"
" }}}
