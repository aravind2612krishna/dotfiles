if v:false " executable('clangd')
    lua require'nvim_lsp'.clangd.setup{ cmd = {"clangd", "--background-index", "-j=6", "--clang-tidy", "-clang-tidy-checks=-*,clang-analyzer*,bugprone*,performance*", "-pch-storage=memory", "--completion-style=detailed", "--completion-parse=auto", "--function-arg-placeholders"}, on_attach=require'completion'.on_attach }

elseif executable('ccls')
    let s:ccls_cache_dir = g:storage_home . '/ccls-cache'
    if v:false " has('win32)
        s:ccls_cache_dir = substitute(s:ccls_cache_dir, '/', '\\\\')
    endif
    let s:findjson = {... -> fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h')}

    lua require'nvim_lsp'.ccls.setup{ init_options = { cache = { directory=s:ccls_cache_dir}, completion = { placeholder = true, detailedLabel = false, caseSensitivity = 0, duplicateOptional = true }, index = { threads = 6 } }, on_attach=require'completion'.on_attach  }

    autocmd Filetype cpp setl omnifunc=v:lua.vim.lsp.omnifunc

endif

lua require'nvim_lsp'.pyls.setup{on_attach=require'completion'.on_attach }

" Debug logging
lua vim.lsp.set_log_level("error")
" lua vim.lsp.set_log_level("debug")

" autocmd Filetype cpp setl omnifunc=v:lua.vim.lsp.omnifunc
set completeopt=menuone,noinsert,noselect

" Example config
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]>     <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gm        <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD       <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR><cmd>top copen<CR>
nnoremap <silent> g0        <cmd>lua vim.lsp.buf.document_symbol()<CR>
xmap     <silent> <leader>x <cmd>lua vim.lsp.buf.range_formatting()<CR>
nnoremap <silent> sd        <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <silent> lr        <cmd>lua vim.lsp.buf.rename()<CR>

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" UltiSnips {{{
let g:completion_enable_snippet = 'UltiSnips'
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:completion_enable_auto_hover = 0
" }}}
