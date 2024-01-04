-- local bar = require('dropbar.bar')
-- bar.bar.sources.treesitter.valid_types = {
--     'class',
--     'constructor',
--     'enum',
--     'function',
--     'method',
--     'module',
--     'namespace',
-- }

-- bar.setup()
require('dropbar').setup({
    sources = {
        treesitter = {
            valid_types = {
                'class',
                'constructor',
                'function',
                'method',
                'module',
            },
        },
    },
})
