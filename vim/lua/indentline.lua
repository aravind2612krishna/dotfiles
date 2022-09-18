-- vim.g.indent_blankline_use_treesitter = true
-- vim.g.indent_blankline_show_first_indent_level = false
-- vim.g.indent_blankline_show_trailing_blankline_indent = false
-- vim.g.indent_blankline_show_current_context = true
-- vim.g.indent_blankline_context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'}

require("indent_blankline").setup {
    char = "│",
    show_current_context = true,
    show_current_context_start = true,
    use_treesitter = true,
    show_first_indent_level = false,
    context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'},
    -- context_patterns = {'class', 'function', 'method', 'arguments'},
}
