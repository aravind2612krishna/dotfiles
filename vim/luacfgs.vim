" Check if a plugin is plugged in plug section or not
function! s:IsPlugged(plugin) abort
    return has_key(g:plugs, a:plugin)
endfunction

if s:IsPlugged('nvim-treesitter')
    lua require'treesitter_config'.config_treesitter()
endif
if s:IsPlugged('indent-blankline.nvim')
    lua require'indentline'
    let g:indent_blankline_char = "│"
    " let g:indent_blankline_use_treesitter = v:true
    let g:indent_blankline_show_current_context = v:true
    let g:indent_blankline_context_patterns = ['class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments']
endif
if s:IsPlugged('nvim-treesitter-context.nvim')
    lua require'nvim_treesitter_context_cfg'
endif
if s:IsPlugged('nvim-dap')
    lua require'dapcfg'
endif
if s:IsPlugged('nvim-dap-ui')
    lua require'dapuicfg'
endif
if s:IsPlugged('lualine.nvim')
    lua require'lualine_cfg'
endif
if s:IsPlugged('nvim-lsp')
    runtime nvim_lsp.vim
endif
