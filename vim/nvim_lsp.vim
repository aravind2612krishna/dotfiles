" LSP settings
let curscrpath = expand('<sfile>:p:h')
if has_key(g:plugs, 'vista')
    let g:vista_executive_for = {
                \ 'c': 'nvim_lsp',
                \ 'cpp': 'nvim_lsp',
                \ 'python': 'nvim_lsp',
                \ }
endif

exec 'luafile' expand(curscrpath . '/lua/lsp_setup.lua')

if has_key(g:plugs, 'lspsaga.nvim')
    " exec 'luafile' expand(curscrpath . '/lua/lspsaga_cfg.lua')
endif

sign define LspDiagnosticsSignError text=❌ texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=🚩 texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=ℹ texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=

if has_key(g:plugs, 'nvim-compe')
    exec 'luafile' expand(curscrpath . '/lua/nvim_compe.lua')
    inoremap <silent><expr> <CR>      compe#confirm('<CR>')
    inoremap <silent><expr> <C-y>       compe#confirm('<C-y>', 'i')
    inoremap <silent><expr> <C-e>       compe#close('<C-e>')
    " luafile lua/nvim_compe.lua
endif

" Debug logging
" lua vim.lsp.set_log_level("error")
" lua vim.lsp.set_log_level("debug")
