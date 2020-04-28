Plug 'neovim/nvim-lsp'
Plug 'haorenW1025/completion-nvim'
Plug 'vigoux/completion-treesitter'
" Plug 'haorenW1025/diagnostic-nvim'

" {{{ snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" }}}

" Auto close popup menu when finish completion
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Plug 'Shougo/deoplete-lsp'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/echodoc.vim'

" Deoplete
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1
" set cmdheight=2
" let g:echodoc#enable_at_startup = 1
" let g:echodoc#highlight_arguments="Visual"
" langserv
