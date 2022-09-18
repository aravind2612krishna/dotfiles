" Check if a plugin is plugged in plug section or not
function! s:IsPlugged(plugin) abort
    return has_key(g:plugs, a:plugin)
endfunction

if s:IsPlugged('nvim-treesitter')
    lua require'treesitter_config'.config_treesitter()
endif
if s:IsPlugged('indent-blankline.nvim')
    lua require'indentline'
    hi! link IndentBlanklineContextStart TSEmphasis                                                                                                                                          
    hi! link IndentBlanklineChar Ignore

    " let g:indent_blankline_char = "│"
    " " let g:indent_blankline_use_treesitter = v:true
    " let g:indent_blankline_show_current_context = v:true
    " let g:indent_blankline_context_patterns = ['class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments']
    " let g:show_end_of_line = true,
    " let g:space_char_blankline = " ",
	" let g:show_current_context = true,
	" let g:show_current_context_start = true,
endif
if s:IsPlugged('nvim-treesitter-context.nvim')
    lua require'nvim_treesitter_context_cfg'
endif
if s:IsPlugged('nvim-dap')
    lua require'dapcfg'
    nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
    nnoremap <silent> <CR> :lua require'dap'.step_over()<CR>
    nnoremap <silent> <leader>] :lua require'dap'.step_into()<CR>
    nnoremap <silent> <leader>[ :lua require'dap'.step_out()<CR>
    nnoremap <silent> <leader>k :lua require('dap.ui.widgets').hover()<CR>
    cabbrev Break :lua require'dap'.toggle_breakpoint()<CR>
    cabbrev CondBreak :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    cabbrev LogBreak :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    cabbrev DapRepl :lua require'dap'.repl.open()<CR>
    cabbrev DapRunLast :lua require'dap'.run_last()<CR>
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
if s:IsPlugged('neogen')
    lua require'neogen_cfg'
    inoremap <C-e> <cmd>lua require('neogen').jump_next()<CR>
    inoremap <C-S-e> <cmd>lua require('neogen').jump_next()<CR>
endif

if s:IsPlugged('focus.nvim')
    " lua require'focus'.setup({cursorline=false})
    lua require'focus'.setup({excluded_filetypes={"neo-tree", "termdebug", "NvimTree"}})
endif

if s:IsPlugged('windline.nvim') " {{{
    lua require('wlsample.evil_line')
endif " }}}

if s:IsPlugged('twilight.nvim')
lua << EOF
  require("twilight").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF
endif

if s:IsPlugged('nvim-tree.lua')
    lua require'nvim-tree'.setup { }
endif

if s:IsPlugged('alexzanderr/nvim-treesitter-statusline')
    lua require("nvim-treesitter-statusline")
endif

if s:IsPlugged('neo-tree.nvim')
    " lua require('neo-tree').setup()
    lua require('neotreecfg')
endif

if s:IsPlugged('capture-nvim')
lua << EOF
    require("capture").setup({
        location = "~/vimwiki/CaptureTODOs.wiki",
        project_root_todo = false
    })
EOF
nnoremap <leader>X :lua capture_module.create_todo()<CR>
nnoremap <leader>J :lua capture_module.jump_to_file_with_column()<CR>
endif

if v:true && s:IsPlugged('nvim-gps')
    lua require'nvim_gps_cfg'
    hi! link WinBar TSNote
    hi! link WinBarNC CocListBlackBlue                                                                                                                                                            
    set laststatus=3
endif

if s:IsPlugged('nvim-ufo')
lua << EOF

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

require('ufo').setup({
fold_virt_text_handler = handler
})
EOF

endif

if s:IsPlugged('venn.nvim')

lua << EOF

function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end

-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})

EOF

endif

if s:IsPlugged('refactoring.nvim')
lua << EOF
    require('refactoring').setup({
    prompt_func_return_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
        },
    prompt_func_param_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
        },
    printf_statements = {},
    print_var_statements = {},
    })
    vim.api.nvim_set_keymap(
        "v",
        "<leader>rr",
        ":lua require('refactoring').select_refactor()<CR>",
        { noremap = true, silent = true, expr = false }
    )
EOF
endif
