if executable('ccls')
    let s:ccls_cache_dir = substitute(expand('~'), '\', '/', 'g') . '/ccls-cache'
    let s:findjson = {... -> fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h')}

    " ccls_settings = {
    "     ccls.cache.directory = "~/ccls-cache",
    "     ccls.completion.enableSnippetInsertion = true,
    "     ccls.index.threads = 4
    " };
    
    " lua nvim_lsp.ccls.setup({settings = {"ccls.cache.directory" = "~/ccls-cache", "ccls.completion.enableSnippetInsertion" = true, "ccls.index.threads" = 4}});
    let ccls_settings = {
                \     "init_options": {
                \       "cache": {"directory": s:ccls_cache_dir},
                \       "completion": {"detailedLabel": v:false},
                \       "index": {"threads": 4}
                \   }}
    call nvim_lsp#setup("ccls", ccls_settings)

    autocmd Filetype cpp setl omnifunc=v:lua.vim.lsp.omnifunc

    " Example config
    nnoremap <silent> gh <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gi  <cmd>lua vim.lsp.buf.implementation()<CR>


    lua vim.lsp.set_log_level("debug")
endif
