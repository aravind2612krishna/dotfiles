local lspconfig = require('lspconfig')
-- local coq = require('coq')


-- -- Call the setup function to change the default behavior
-- local aerial = require'aerial'
-- aerial.setup({
--   -- Priority list of preferred backends for aerial.
--   -- This can be a filetype map (see :help aerial-filetype-map)
--   backends = { "lsp", "treesitter", "markdown" },

--   -- Enum: persist, close, auto, global
--   --   persist - aerial window will stay open until closed
--   --   close   - aerial window will close when original file is no longer visible
--   --   auto    - aerial window will stay open as long as there is a visible
--   --             buffer to attach to
--   --   global  - same as 'persist', and will always show symbols for the current buffer
--   close_behavior = "auto",

--   -- Set to false to remove the default keybindings for the aerial buffer
--   default_bindings = true,

--   -- Enum: prefer_right, prefer_left, right, left, float
--   -- Determines the default direction to open the aerial window. The 'prefer'
--   -- options will open the window in the other direction *if* there is a
--   -- different buffer in the way of the preferred direction
--   default_direction = "prefer_right",

--   -- Disable aerial on files with this many lines
--   disable_max_lines = 10000,

--   -- A list of all symbols to display. Set to false to display all symbols.
--   -- This can be a filetype map (see :help aerial-filetype-map)
--   -- To see all available values, see :help SymbolKind
--   filter_kind = {
--     "Class",
--     "Constructor",
--     "Enum",
--     "Function",
--     "Interface",
--     "Module",
--     "Method",
--     "Struct",
--   },

--   -- Enum: split_width, full_width, last, none
--   -- Determines line highlighting mode when multiple splits are visible
--   -- split_width   Each open window will have its cursor location marked in the
--   --               aerial buffer. Each line will only be partially highlighted
--   --               to indicate which window is at that location.
--   -- full_width    Each open window will have its cursor location marked as a
--   --               full-width highlight in the aerial buffer.
--   -- last          Only the most-recently focused window will have its location
--   --               marked in the aerial buffer.
--   -- none          Do not show the cursor locations in the aerial window.
--   highlight_mode = "split_width",

--   -- When jumping to a symbol, highlight the line for this many ms.
--   -- Set to false to disable
--   highlight_on_jump = 300,

--   -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
--   -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
--   -- default collapsed icon. The default icon set is determined by the
--   -- "nerd_font" option below.
--   -- If you have lspkind-nvim installed, aerial will use it for icons.
--   icons = {},

--   -- When you fold code with za, zo, or zc, update the aerial tree as well.
--   -- Only works when manage_folds = true
--   link_folds_to_tree = false,

--   -- Fold code when you open/collapse symbols in the tree.
--   -- Only works when manage_folds = true
--   link_tree_to_folds = true,

--   -- Use symbol tree for folding. Set to true or false to enable/disable
--   -- 'auto' will manage folds if your previous foldmethod was 'manual'
--   manage_folds = false,

--   -- The maximum width of the aerial window
--   max_width = 40,

--   -- The minimum width of the aerial window.
--   -- To disable dynamic resizing, set this to be equal to max_width
--   min_width = 10,

--   -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
--   -- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
--   nerd_font = "auto",

--   -- Call this function when aerial attaches to a buffer.
--   -- Useful for setting keymaps. Takes a single `bufnr` argument.
--   on_attach = nil,

--   -- Automatically open aerial when entering supported buffers.
--   -- This can be a function (see :help aerial-open-automatic)
--   open_automatic = true,

--   -- Set to true to only open aerial at the far right/left of the editor
--   -- Default behavior opens aerial relative to current window
--   placement_editor_edge = true,

--   -- Run this command after jumping to a symbol (false will disable)
--   post_jump_cmd = "normal! zz",

--   -- When true, aerial will automatically close after jumping to a symbol
--   close_on_select = false,

--   -- Show box drawing characters for the tree hierarchy
--   show_guides = true,

--   -- Options for opening aerial in a floating win
--   float = {
--     -- Controls border appearance. Passed to nvim_open_win
--     border = "rounded",

--     -- Controls row offset from cursor. Passed to nvim_open_win
--     row = 1,

--     -- Controls col offset from cursor. Passed to nvim_open_win
--     col = 0,

--     -- The maximum height of the floating aerial window
--     max_height = 100,

--     -- The minimum height of the floating aerial window
--     -- To disable dynamic resizing, set this to be equal to max_height
--     min_height = 4,
--   },

--   lsp = {
--     -- Fetch document symbols when LSP diagnostics change.
--     -- If you set this to false, you will need to manually fetch symbols
--     diagnostics_trigger_update = true,

--     -- Set to false to not update the symbols when there are LSP errors
--     update_when_errors = true,
--   },

--   treesitter = {
--     -- How long to wait (in ms) after a buffer change before updating
--     update_delay = 300,
--   },

--   markdown = {
--     -- How long to wait (in ms) after a buffer change before updating
--     update_delay = 300,
--   },
-- })

local on_attach = function(client, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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
    buf_set_keymap('n', '<space>d', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>gci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
    buf_set_keymap('n', '<space>gco', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    -- if client.resolved_capabilities.document_formatting then
    --     buf_set_keymap("n", "<space>gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- if client.resolved_capabilities.document_range_formatting then
        -- buf_set_keymap("v", "gq", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
        -- buf_set_keymap("v", "<space>gq", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
        -- buf_set_option('formatexpr', 'Formatexpr_wrapper()')
        -- buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')
    -- end

    -- Set autocommands conditional on server_capabilities
    -- hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    -- hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    -- hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    if client.server_capabilities.document_highlight then
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

-- lspconfig.clangd.setup(coq.lsp_ensure_capabilities {
--     cmd = {
--         "clangd", "--background-index", "-j=6", "--clang-tidy",
--         "-clang-tidy-checks=-*,clang-analyzer*,bugprone*,performance*",
--         "-pch-storage=memory", "--completion-style=detailed",
--         "--completion-parse=auto", "--function-arg-placeholders"
--     },
--     flags = {
--         debounce_text_changes = 500,
--     },
--     capabilities = capabilities,
--     on_attach = on_attach,
-- }
-- )

-- require("clangd_extensions").setup {
--     server = {
--         cmd = {
--             "clangd", "--background-index", "-j=6", "--clang-tidy",
--             "-clang-tidy-checks=-*,clang-analyzer*,bugprone*,performance*",
--             "-pch-storage=memory", "--completion-style=detailed",
--             "--completion-parse=auto", "--function-arg-placeholders",
--             "--inlay-hints"
--         },
--         flags = {
--             debounce_text_changes = 500,
--         },
--         capabilities = capabilities,
--         on_attach = on_attach,
--     },
--     extensions = {
--         -- defaults:
--         -- Automatically set inlay hints (type hints)
--         autoSetHints = true,
--         -- Whether to show hover actions inside the hover window
--         -- This overrides the default hover handler
--         hover_with_actions = true,
--         -- These apply to the default ClangdSetInlayHints command
--         inlay_hints = {
--             -- Only show inlay hints for the current line
--             only_current_line = false,
--             -- Event which triggers a refersh of the inlay hints.
--             -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
--             -- not that this may cause  higher CPU usage.
--             -- This option is only respected when only_current_line and
--             -- autoSetHints both are true.
--             only_current_line_autocmd = "CursorHold",
--             -- whether to show parameter hints with the inlay hints or not
--             show_parameter_hints = true,
--             -- whether to show variable name before type hints with the inlay hints or not
--             show_variable_name = true,
--             -- prefix for parameter hints
--             parameter_hints_prefix = "<- ",
--             -- prefix for all the other hints (type, chaining)
--             other_hints_prefix = "=> ",
--             -- whether to align to the length of the longest line in the file
--             max_len_align = false,
--             -- padding from the left if max_len_align is true
--             max_len_align_padding = 1,
--             -- whether to align to the extreme right or not
--             right_align = false,
--             -- padding from the right if right_align is true
--             right_align_padding = 7,
--             -- The color of the hints
--             highlight = "Comment",
--         },
--         ast = {
--             role_icons = {
--                 type = "",
--                 declaration = "",
--                 expression = "",
--                 specifier = "",
--                 statement = "",
--                 ["template argument"] = "",
--             },

--             kind_icons = {
--                 Compound = "",
--                 Recovery = "",
--                 TranslationUnit = "",
--                 PackExpansion = "",
--                 TemplateTypeParm = "",
--                 TemplateTemplateParm = "",
--                 TemplateParamObject = "",
--             },

--             highlights = {
--                 detail = "Comment",
--             },
--         }
--     }
-- }

lspconfig.clangd.setup {
    cmd = {
        "clangd", "--background-index", "-j=6", "--clang-tidy",
        "-clang-tidy-checks=-*,clang-analyzer*,bugprone*,performance*",
        "-pch-storage=memory", "--completion-style=detailed",
        "--completion-parse=auto", "--function-arg-placeholders"
    },
    flags = {
        debounce_text_changes = 500,
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
require('symbols-outline').setup(opts)

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
