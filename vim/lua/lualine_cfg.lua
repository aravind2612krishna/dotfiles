-- local gps = require("nvim-gps")

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
    lualine_a = {'mode', 'g:coc_status'},
    lualine_b = {'filename'},
    lualine_c = {
        -- { gps.get_location, condition = gps.is_available },
        {'sy#repo#get_stats_decorated'},
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {
        {
            'diagnostics', 
            sources = {'coc'},
            symbols = {error = 'x', warn = '‼', info = 'I', hint = 'H'}
        }
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
