local M = {}
local l_treesitter = require('nvim-treesitter.configs')

function M.config_treesitter()
    l_treesitter.setup {
        highlight = {
            enable = true,                    -- false will disable the whole extension
            disable = function(lang, bufnr) -- Disable in large C++ buffers
                return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 2500
            end,
            -- disable = { "c", "rust" },        -- list of language that will be disabled
            -- custom_captures = {               -- mapping of user defined captures to highlight groups
            --   -- ["foo.bar"] = "Identifier"   -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
            -- },
            additional_vim_regex_highlighting = function(lang, bufnr) -- Disable in large C++ buffers
                return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 2500
            end,

        },
        -- tree_docs = {
        --     enable = true,
        --     keymaps = {
        --         doc_node_at_cursor = "<leader>d",
        --         doc_all_in_range = "<leader>d",
        --     },
        -- },
        incremental_selection = {
            enable = true,
            -- disable = { "cpp", "lua" },
            keymaps = {                       -- mappings for incremental selection (visual mappings)
                init_selection = "gni",         -- maps in normal mode to init the node/scope selection
                node_incremental = "	",       -- increment to the upper named parent
                scope_incremental = "gns",      -- increment to the upper scope (as defined in locals.scm)
                node_decremental = "<S-Tab>",       -- decrement to the previous node
            },
        },
        refactor = {
            highlight_definitions = {
                enable = false
            },
            highlight_current_scope = {
                enable = false
            },
            navigation = {
                enable = true,
                keymaps = {
                    goto_next_usage = "<C-S-j>",
                    goto_previous_usage = "<C-S-k>",
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
                    ["is"] = "@statement.inner",
                    ["as"] = "@statement.outer",
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
            lsp_interop = {
                enable = false,
                border = 'single',
                peek_definition_code = {
                    ["<leader>df"] = "@function.outer",
                    ["<leader>dF"] = "@class.outer",
                },
            },
        },
        nt_cpp_tools = {
            enable = true,
            preview = {
                quit = 'q', -- optional keymapping for quit preview
                accept = '<tab>' -- optional keymapping for accept preview
            },
        },
    }
end

function M.config_cpp()
    require 'nt-cpp-tools'.setup({
        preview = {
            quit = 'q',                       -- optional keymapping for quit preview
            accept = '<tab>'                  -- optional keymapping for accept preview
        },
        header_extension = 'h',               -- optional
        source_extension = {'cxx', 'cpp'},             -- optional
        custom_define_class_function_commands = { -- optional
            TSCppImplWrite = {
                output_handle = require 'nt-cpp-tools.output_handlers'.get_preview_and_apply()
            }
            --[[
        <your impl function custom command name> = {
            output_handle = function (str, context)
                -- string contains the class implementation
                -- do whatever you want to do with it
            end
        }
        ]]
        }
    })
end

return M
