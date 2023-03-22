-- local gps = require("nvim-gps")
-- local vim = require("vim")

local function padding()
    return [[──]]
end

require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        -- component_separators = {'', ''},
        -- section_separators = {'', ''},
        component_separators = {'', ''},
        section_separators = {'', ''},
        -- component_separators = {'', ''},
        -- section_separators = {'', ''},

        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
    },
    sections = {
        lualine_a = {
            { 'mode', icons_enabled = true, separator = { left = '', right = '' } },
        },
        lualine_b = {
            {
                'filename',
                file_status = true,      -- Displays file status (readonly status, modified status)
                newfile_status = false,  -- Display new file status (new file means no write after created)
                path = 1,                -- 0: Just the filename
                -- 1: Relative path
                -- 2: Absolute path
                -- 3: Absolute path, with tilde as the home directory

                shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                -- for other components. (terrible name, any suggestions?)
                symbols = {
                    modified = '[+]',      -- Text to show when the file is modified.
                    readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                    newfile = '[New]',     -- Text to show for newly created file before first write
                }
            }
        },
        lualine_c = {
            -- { gps.get_location, condition = gps.is_available },
            {'sy#repo#get_stats_decorated'},
            {'g:coc_status'},
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
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    -- tabline = {},
    -- extensions = {}
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
