local lspconfig = require('lspconfig')
local aerial = require'aerial'

local on_attach = function(client, bufnr)

    Formatexpr_wrapper = function()
        -- only reformat on explicit gq command
        if not fn.mode() == 'n' then
            -- fall back to Vims internal reformatting
            return 1
        end

        local opts = {}
        local start_line = vim.v.lnum
        local end_line = start_line + vim.v.count - 1
        if start_line >= 0 and end_line >= 0 then
            lsp.buf.range_formatting(opts, {start_line, 0}, {end_line, 0})
        end

        return 0
    end

    aerial.on_attach(client)
    require'lsp_signature'.on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "single"
        }
    })

    -- Aerial does not set any mappings by default, so you'll want to set some up
    -- Toggle the aerial window with <leader>a
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
    -- Jump forwards/backwards with '{' and '}'
    vim.api.nvim_buf_set_keymap(0, 'n', '{', '<cmd>AerialPrev<CR>', {})
    vim.api.nvim_buf_set_keymap(0, 'n', '}', '<cmd>AerialNext<CR>', {})
    -- Jump up the tree with '[[' or ']]'
    vim.api.nvim_buf_set_keymap(0, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
    vim.api.nvim_buf_set_keymap(0, 'n', ']]', '<cmd>AerialNextUp<CR>', {})

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>zzzv', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gm', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>gs', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
    buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    -- if client.resolved_capabilities.document_formatting then
    --     buf_set_keymap("n", "<space>gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    if client.resolved_capabilities.document_range_formatting then
        -- buf_set_keymap("v", "gq", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
        buf_set_keymap("v", "<space>gq", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
        buf_set_option('formatexpr', 'Formatexpr_wrapper()')
    end

    -- Set autocommands conditional on server_capabilities
    -- hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    -- hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    -- hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi! link LspReferenceRead PmenuSel
        hi! link LspReferenceWrite PmenuSel
        hi! link LspReferenceText PmenuSel
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup { 
        capabilities = capabilities;
        on_attach = on_attach;
   }
end

lspconfig.clangd.setup {
    cmd = {
        "clangd", "--background-index", "-j=6", "--clang-tidy",
        "-clang-tidy-checks=-*,clang-analyzer*,bugprone*,performance*",
        "-pch-storage=memory", "--completion-style=detailed",
        "--completion-parse=auto", "--function-arg-placeholders"
    },
    capabilities = capabilities,
    on_attach = on_attach,
}

-- require('lspfuzzy').setup {
--     methods = {
--         'callHierarchy/incomingCalls',
--         'callHierarchy/outgoingCalls',
--         'textDocument/codeAction',
--         'textDocument/documentSymbol',
--         'workspace/symbol',
--     },
--     fzf_preview = {          -- arguments to the FZF '--preview-window' option
--         'right:+{2}-/2'          -- preview on the right and centered on entry
--     },
--     fzf_action = {           -- FZF actions
--         ['ctrl-t'] = 'tabedit',  -- go to location in a new tab
--         ['ctrl-v'] = 'vsplit',   -- go to location in a vertical split
--         ['ctrl-x'] = 'split',    -- go to location in a horizontal split
--     },
--     fzf_modifier = ':~:.',   -- format FZF entries, see |filename-modifiers|
--     fzf_trim = true,         -- trim FZF entries
-- }

require("trouble").setup{
    signs = {
        -- icons / text used for a diagnostic
        error = "❌",
        warning = "🚩",
        hint = "",
        information = "ℹ"
    },
    use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

local opts = {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

    -- whether to show outline guides 
    -- default: true
    show_guides = true,
}
-- require('symbols-outline').setup(opts)

-- require'navigator'.setup()

-- function M.setup_clangd()
--     lspconfig.clangd.setup{
--         cmd = {
--             "clangd", "--background-index", "-j=6", "--clang-tidy",
--             "-clang-tidy-checks=-*,clang-analyzer*,bugprone*,performance*",
--             "-pch-storage=memory", "--completion-style=detailed",
--             "--completion-parse=auto", "--function-arg-placeholders"
--         },
--         init_options = { clangdFileStatus = true },
--         on_attach = require'OnAttach'.on_attach,
--     }
-- end

-- function M.setup_ccls()
--     -- local ccls_cache_path = path.combine(vim.g.storage_home, 'ccls-cache')
--     lspconfig.ccls.setup{
--         cmd = {"ccls", "--log-file=ccls.log"},
--         init_options = {
--             cache = { directory="/home/aravind/ccls-cache" },
--             completion = {
--                 placeholder = true,
--                 detailedLabel = false,
--                 caseSensitivity = 0,
--                 duplicateOptional = true 
--             },
--             index = { threads = 6 },
--             highlight = { lsRanges = true }
--         },
--         on_attach = require'OnAttach'.on_attach,
--     }
-- end

-- return M
