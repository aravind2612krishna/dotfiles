return {
    -- the colorscheme should be available when starting Neovim
    {
        "wuelnerdotexe/vim-enfocado",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.enfocado_style = "neon"
            vim.cmd([[colorscheme enfocado]])
        end
    },
    {
        "tomasiser/vim-code-dark",
        lazy = true
    },
    {
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
        },
        config = function()
            -- ...
        end,
    },

    -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
    -- So for api plugins like devicons, we can always set lazy=true
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- you can use the VeryLazy event for things that can
    -- load later and are not important for the initial UI
    { "stevearc/dressing.nvim",      event = "VeryLazy" },
}
