" LSP settings
if has_key(g:plugs, 'vista')
    let g:vista_executive_for = {
                \ 'c': 'nvim_lsp',
                \ 'cpp': 'nvim_lsp',
                \ 'python': 'nvim_lsp',
                \ }
endif
if has_key(g:plugs, 'diagnostic-nvim')
    let g:diagnostic_enable_virtual_text = 1
    let g:diagnostic_insert_delay = 1
endif
if has_key(g:plugs, 'completion-nvim')
    autocmd BufEnter * lua require'completion'.on_attach()
    set completeopt=menuone,noinsert,noselect
    if has_key(g:plugs, 'vim-vsnip')
        let g:completion_enable_snippet = 'vim-vsnip'
    endif
endif

" c++
if v:false " executable('clangd')
    lua require'lsp_setup'.setup_clangd()
elseif executable('ccls')
    lua require'lsp_setup'.setup_ccls()
endif

lua require'nvim_lsp'.pyls.setup{ on_attach = require'OnAttach'.on_attach }

" Debug logging
" lua vim.lsp.set_log_level("error")
" lua vim.lsp.set_log_level("debug")
