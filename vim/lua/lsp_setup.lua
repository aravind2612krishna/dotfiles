local nvim_lsp = require('nvim_lsp')
local path = require('path')
local api = vim.api
local lsp_status = require('lsp-status')
lsp_status.register_progress()

local M = {}

function M.setup_clangd()
    nvim_lsp.clangd.setup{
        cmd = {
            "clangd", "--background-index", "-j=6", "--clang-tidy",
            "-clang-tidy-checks=-*,clang-analyzer*,bugprone*,performance*",
            "-pch-storage=memory", "--completion-style=detailed",
            "--completion-parse=auto", "--function-arg-placeholders"
        },
        init_options = { clangdFileStatus = true },
        on_attach = require'OnAttach'.on_attach,
    }
end

function M.setup_ccls()
    -- local ccls_cache_path = path.combine(vim.g.storage_home, 'ccls-cache')
    nvim_lsp.ccls.setup{
        cmd = {"ccls", "--log-file=ccls.log"},
        init_options = {
            cache = { directory="C:\\Users\\aravk\\ccls-cache" },
            completion = {
                placeholder = true,
                detailedLabel = false,
                caseSensitivity = 0,
                duplicateOptional = true 
            },
            index = { threads = 6 } 
        },
        on_attach = require'OnAttach'.on_attach,
    }
end

return M
