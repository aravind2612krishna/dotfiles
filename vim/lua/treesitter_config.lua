local M = {}
local l_treesitter = require('nvim-treesitter.configs')

function M.config_treesitter()
    l_treesitter.setup {
        highlight = {
            enable = true,                    -- false will disable the whole extension
            -- disable = { "c", "rust" },        -- list of language that will be disabled
            -- custom_captures = {               -- mapping of user defined captures to highlight groups
            --   -- ["foo.bar"] = "Identifier"   -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
            -- },
        },
        incremental_selection = {
            enable = true,
            -- disable = { "cpp", "lua" },
            keymaps = {                       -- mappings for incremental selection (visual mappings)
                init_selection = "gni",         -- maps in normal mode to init the node/scope selection
                node_incremental = "gnn",       -- increment to the upper named parent
                scope_incremental = "gns",      -- increment to the upper scope (as defined in locals.scm)
                node_decremental = "gnp",       -- decrement to the previous node
            },
        },
        refactor = {
            highlight_definitions = {
                enable = true
            },
            highlight_current_scope = {
                enable = false
            },
            navigation = {
                enable = true,
                keymaps = {
                    goto_next_usage = "<c-a-j>",
                    goto_previous_usage = "<c-a-k>",
                },
            },
        },
        textobjects = { -- syntax-aware textobjects
        select = {
            enable = true,
            keymaps = {
                -- ["iL"] = { -- you can define your own textobjects directly here
                --   python = "(function_definition) @function",
                --   cpp = "(function_definition) @function",
                --   c = "(function_definition) @function",
                --   java = "(method_declaration) @function"
                -- },
                -- or you use the queries from supported languages with textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["aC"] = "@class.outer",
                ["iC"] = "@class.inner",
                -- ["ac"] = "@conditional.outer",
                -- ["ic"] = "@conditional.inner",
                -- ["ae"] = "@block.outer",
                -- ["ie"] = "@block.inner",
                -- ["al"] = "@loop.outer",
                -- ["il"] = "@loop.inner",
                -- ["is"] = "@statement.inner",
                -- ["as"] = "@statement.outer",
                -- ["ad"] = "@comment.outer",
                -- ["am"] = "@call.outer",
                -- ["im"] = "@call.inner"
            },
        }, 
        move = {
            enable = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
            },
        },
        },
    }
end

return M
