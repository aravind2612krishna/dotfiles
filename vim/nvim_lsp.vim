if v:false " executable('clangd')
    lua require'nvim_lsp'.clangd.setup{ cmd = {"clangd", "--background-index", "-j=6", "--clang-tidy", "-clang-tidy-checks=-*,clang-analyzer*,bugprone*,performance*", "-pch-storage=memory", "--completion-style=detailed", "--completion-parse=auto", "--function-arg-placeholders"}, on_attach=require'completion'.on_attach }

elseif executable('ccls')
    let s:ccls_cache_dir = substitute(expand('~'), '\', '/', 'g') . '/ccls-cache'
    let s:findjson = {... -> fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h')}

    " ccls_settings = {
    "     ccls.cache.directory = "~/ccls-cache",
    "     ccls.completion.enableSnippetInsertion = true,
    "     ccls.index.threads = 4
    " };
    
    " " lua nvim_lsp.ccls.setup({settings = {"ccls.cache.directory" = "~/ccls-cache", "ccls.completion.placeholder" = true, "ccls.index.threads" = 4, "ccls.completion.detailedLabel" = false}});
    " let ccls_settings = {
    "             \     "init_options": {
    "             \       "cache": {"directory": s:ccls_cache_dir},
    "             \       "completion": {"detailedLabel": v:false},
    "             \       "index": {"threads": 4}
    "             \   }}
    " call nvim_lsp#setup("ccls", ccls_settings)

    lua require'nvim_lsp'.ccls.setup{ init_options = { cache = { directory="C:\\Users\\aravk\\ccls-cache" }, completion = { placeholder = true, detailedLabel = false, caseSensitivity = 0, duplicateOptional = true }, index = { threads = 6 } }, on_attach=require'completion'.on_attach  }

    " lua require'nvim_lsp'.ccls.setup{settings = { ccls.cache.directory = "C:\\Users\\aravk\\ccls-cache", ccls.completion.caseSensitivity = 0, ccls.completion.detailedLabel = false, ccls.completion.duplicateOptional = true, ccls.completion.enableSnippetInsertion = true, ccls.index.threads = 6 } }
    
    " lua require'nvim_lsp'.ccls.setup{ settings = { ccls.cache.directory = "C:\\Users\\aravk\\ccls-cache" } }

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
