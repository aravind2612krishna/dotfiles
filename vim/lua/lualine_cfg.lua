local gps = require("nvim-gps")

local function padding()
    return [[─┈─┈─┈─┈─┈─]]
end

require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'solarized',
        -- theme = 'enfocado',
        -- theme = 'codedark',
        -- theme = 'gruvbox',
        -- theme = 'gruvbox_light',
        -- component_separators = {'', ''},
        -- section_separators = {'', ''},
        component_separators = {'', ''},
        section_separators = {'', ''},
        -- component_separators = {'', ''},
        -- section_separators = {'', ''},

        disabled_filetypes = {}
    },
    sections = {
        -- lualine_a = {'mode', 'g:coc_status'},
        lualine_a = {'mode'},
        lualine_b = {'filename'},
        lualine_c = {
            { gps.get_location, condition = gps.is_available },
            {'sy#repo#get_stats_decorated'},
            {
                'diagnostics', 
                -- sources = {'nvim_lsp'},
                sources = {'coc'},
                symbols = {error = 'x', warn = '‼', info = 'I', hint = 'H'},
            },
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {
            -- {
            --     'diagnostics', 
            --     sources = {'nvim_lsp'},
            --     sources = {'coc'},
            --     symbols = {error = 'x', warn = '‼', info = 'I', hint = 'H'}
            -- }
        },
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {padding, 'filename'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

-- local sidebar = require("sidebar-nvim")
-- local opts = {
    --     disable_default_keybindings = 0,
    --     bindings = nil,
    --     open = false,
    --     side = "left",
    --     initial_width = 35,
    --     hide_statusline = false,
    --     update_interval = 1000,
    --     sections = { "buffers", "diagnostics", "symbols", "files"},
    --     section_separator = "-----",
    --     containers = {
        --         attach_shell = "/bin/sh", show_all = true, interval = 5000,
        --     },
        --     datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
        --     todos = { ignored_paths = { "~" } },
        --     buffers = {
            --         icon = "",
            --     },
            --     files = {
                --         icon = "",
                --         show_hidden = true,
                --     },
                --     symbols = {
                    --         icon = "ƒ",
                    --     },
                    --     disable_closing_prompt = false
                    -- }
                    -- sidebar.setup(opts)

                    -- -- configure the litee.nvim library 
                    -- require('litee.lib').setup({})
                    -- -- configure litee-calltree.nvim
                    -- require('litee.calltree').setup({})
                    -- require('litee.symboltree').setup({})
                    -- require('litee.filetree').setup({})
