local M = {}

function M.config_bubbly()
    vim.g.bubbly_statusline = {
        'mode',

        'truncate',

        'path',
        'signify',
        'coc',

        'divisor',

        'filetype',
        'progress',
    }

    vim.g.bubbly_characters = {
        -- Bubble delimiters
        -- left = '',
        -- right = '',
        -- left = '',
        -- right = '',
        -- Close character for the tabline
        close = '',
        -- Bubble separators
        bubble_separator = ' ',
    }

    vim.g.bubbly_palette = {
        background = "#1E1E1E",
        foreground = "#D4D4D4",
        black = "#000000",
        -- red = "#ec7279",
        red = "#F44747",
        green = "#6A9955",
        darkblue = "#223E55",
        yellow = "#DCDCAA",
        bright = "#EFEFBF",
        blue = "#6cb6eb",
        ltblue = "#9CDCFE",
        purple = "#d38aea",
        cyan = "#5dbbc1",
        white = "#c5cdd9",
        lightgrey = "#808080",
        grey = "#606060",
        darkgrey = "#394043",
    }

    vim.g.bubbly_colors = {
       default = 'red',

       mode = {
          normal = { background = 'black', foreground = 'yellow' }, -- uses by default a foreground of the background color
          insert = { background = 'black', foreground = 'blue' },
          visual = 'blue',
          visualblock = 'blue',
          command = 'red',
          terminal = 'blue',
          replace = 'yellow',
          default = 'white'
       },
       path = {
          readonly = { background = 'black', foreground = 'red' },
          unmodifiable = { background = 'black', foreground = 'yellow' },
          path = { background = 'black', foreground = 'bright' },
          modified = { background = 'lightgrey', foreground = 'foreground' },
       },
       branch = 'purple',
       signify = {
          added = 'green',
          modified = 'blue',
          removed = 'red',
       },
       paste = 'red',
       coc = {
          error = 'red',
          warning = 'yellow',
          status = { background = 'lightgrey', foreground = 'foreground' },
       },
       builtinlsp = {
          diagnostic_count = {
             error = 'red',
             warning = 'yellow',
          },
          current_function = 'purple',
       },
       filetype = { background = 'darkgrey', foreground = 'blue' },
       progress = {
          rowandcol = { background = 'black', foreground = 'yellow' },
          percentage = { background = 'black', foreground = 'blue' },
       },
       tabline = {
          active = {background = 'black', foreground = 'bright'},
          inactive = 'grey',
       },
    }

    -- vim.g.inactive_color = 'red'
    vim.g.bubbly_inactive_color = { background = 'grey', foreground = 'black' }

end

return M
