" LSP settings
" log file location: /Users/michael/.local/share/nvim/vim-lsp.log
let g:vista_executive_for = {
  \ 'cpp': 'nvim_lsp',
  \ 'python': 'nvim_lsp',
  \ }
if v:false " executable('clangd')
    lua require'nvim_lsp'.clangd.setup{ cmd = {"clangd", "--background-index", "-j=6", "--clang-tidy", "-clang-tidy-checks=-*,clang-analyzer*,bugprone*,performance*", "-pch-storage=memory", "--completion-style=detailed", "--completion-parse=auto", "--function-arg-placeholders"}, on_attach=require'completion'.on_attach }

elseif executable('ccls')
    let s:ccls_cache_dir = g:storage_home . '/ccls-cache'
    if has('win32')
        let s:ccls_cache_dir = substitute(s:ccls_cache_dir, "/", "\\\\\\\\", "g")
        " echom s:ccls_cache_dir
    endif
    let s:findjson = {... -> fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h')}

lua << EOF
        local nvim_lsp = require('nvim_lsp')

        nvim_lsp.ccls.setup{
            cmd = {"ccls", "--log-file=ccls.log"},
            init_options = {
                cache = { directory="C:\\Users\\aravk\\ccls-cache" },
                completion = { placeholder = true, detailedLabel = false, caseSensitivity = 0, duplicateOptional = true },
                index = { threads = 6 } 
            },
            on_attach = require'OnAttach'.on_attach,
        }
EOF

    " " NCM2
    " on_init = ncm2.register_lsp_source 
    " enable ncm2 for all buffers
    " autocmd BufEnter * call ncm2#enable_for_buffer()

endif

lua require'nvim_lsp'.pyls.setup{ on_attach = require'OnAttach'.on_attach }

" Debug logging
" lua vim.lsp.set_log_level("error")
lua vim.lsp.set_log_level("debug")

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" UltiSnips {{{
let g:completion_enable_snippet = 'vim-vsnip'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}
