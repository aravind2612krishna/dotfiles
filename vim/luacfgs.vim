" Check if a plugin is plugged in plug section or not
function! s:IsPlugged(plugin) abort
    return has_key(g:plugs, a:plugin)
endfunction

if s:IsPlugged('nvim-treesitter')
    lua require'treesitter_config'.config_treesitter()
    lua require'treesitter_config'.config_cpp()
endif
if s:IsPlugged('indent-blankline.nvim')
    lua require'indentline'
    " hi! link IndentBlanklineContextStart TSEmphasis                                                                                                                                          
    " hi! link IndentBlanklineChar Ignore

    " let g:indent_blankline_char = "│"
    " " let g:indent_blankline_use_treesitter = v:true
    " let g:indent_blankline_show_current_context = v:true
    " let g:indent_blankline_context_patterns = ['class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments']
    " let g:show_end_of_line = true,
    " let g:space_char_blankline = " ",
	" let g:show_current_context = true,
	" let g:show_current_context_start = true,
endif

if s:IsPlugged('nvim-treesitter-context')
    lua require'nvim_treesitter_context_cfg'
endif

if s:IsPlugged('twilight.nvim')
    lua require'twilight_cfg'
endif

if s:IsPlugged('nvim-dap')
    lua require'dapcfg'
    lua require('nvim-dap-virtual-text').setup()
    lua require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    nnoremap <silent> <leader>gc <Cmd>lua require'dap'.continue()<CR>
    nnoremap <silent> <leader>gr <Cmd>lua require'dap'.run()<CR>
    nnoremap <silent> <leader>ga <Cmd>lua require'dap'.run_last()<CR>
    nnoremap <silent> <Leader>gb <Cmd>lua require'dap'.toggle_breakpoint()<CR>
    nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
    nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
    nnoremap <silent> <PageUp> <Cmd>lua require'dap'.up()<CR>
    nnoremap <silent> <PageDown> <Cmd>lua require'dap'.down()<CR>
    nnoremap <silent> <CR> <Cmd>lua require'dap'.step_over()<CR>
    nnoremap <silent> <leader>gu <Cmd>lua require'dap'.run_to_cursor()<CR>
    nnoremap <silent> <leader>jb <Cmd>lua require'dap'.goto_()<CR>
    nnoremap <silent> <leader>] :lua require'dap'.step_into()<CR>
    nnoremap <silent> <leader>[ :lua require'dap'.step_out()<CR>
    nnoremap <silent> <leader>k :lua require('dap.ui.widgets').hover()<CR>
    abbrev Break :lua require'dap'.toggle_breakpoint()<CR>
    abbrev CondBreak :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    abbrev LogBreak :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    abbrev DapRepl :lua require'dap'.repl.open()<CR>
    abbrev DapRunLast :lua require'dap'.run_last()<CR>
endif
if s:IsPlugged('nvim-dap-ui')
    lua require'dapuicfg'
    cabbrev DapUIToggle :lua require("dapui").toggle()<CR>
endif
if s:IsPlugged('toggleterm.nvim')
    lua require'toggleterm_cfg'
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
    " hi! link WinBar TSNote
    " hi! link WinBarNC CocListBlackBlue
    set laststatus=3
endif

if s:IsPlugged('dropbar.nvim')
    set laststatus=3
    lua require'dropbar_cfg'
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

require('ufo').setup()

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
EOF

" require('ufo').setup({
" fold_virt_text_handler = handler
" })

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

if s:IsPlugged("perfanno.nvim")
    lua require("perfanno_cfg")
endif

if s:IsPlugged("mind.nvim")
    lua require'mind'.setup()
endif

if s:IsPlugged("mini.tabline")
    lua require('mini.tabline').setup()
endif

if s:IsPlugged("mini.indentscope")
    lua require('mini.indentscope').setup()
endif

if s:IsPlugged('github-nvim-theme')
lua << EOF
    require("github-theme").setup({
    theme_style = "dark",
    function_style = "italic",
    sidebars = {"qf", "vista_kind", "terminal", "packer"},
    hide_inactive_statusline = false,

    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    -- colors = {hint = "orange", error = "#ff0000"},

    -- Overwrite the highlight groups
    -- overrides = function(c)
    -- return {
    --     htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
    --     DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
    --     -- this will remove the highlight groups
    --     TSField = {},
    -- }
    -- end
    })

EOF
endif

if s:IsPlugged('lualine.nvim')
    lua require'lualine_cfg'
endif

if s:IsPlugged('true-zen.nvim')
lua << EOF
	require("true-zen").setup {
		-- your config goes here
		-- or just leave it empty :)
	}
EOF
endif

