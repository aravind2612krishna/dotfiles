vim.opt.fillchars:append("vert:|")

vim.opt.foldmethod = "marker"

-- Copy with syntax highlighting
vim.api.nvim_create_user_command('HtmlClip', function(args)
    local saved_html_use_css = vim.g.html_use_css
    local saved_html_no_progress = vim.g.html_no_progress
    vim.g.html_use_css = false
    vim.g.html_no_progress = true
    vim.cmd {
        cmd = 'TOhtml',
        range = { args.line1, args.line2 },
    }
    vim.g.html_use_css = saved_html_use_css
    vim.g.html_no_progress = saved_html_no_progress

    vim.cmd.g("<body")
    vim.cmd "normal oFile : "
    vim.cmd "normal \"#p"
    vim.cmd "normal a<br>"
    vim.cmd 'w !xclip -selection clipboard -t text/html -i'
    vim.cmd.bwipeout { bang = true }
end, {
    range = '%',
})

if vim.g.neovide ~= nil then
    vim.g.neovide_cursor_antialiasing = false
    vim.g.neovide_fullscreen = true
    vim.g.neovide_remember_window_size = true
    vim.keymap('n', '<M-Enter>', function ()
        if vim.g.neovide_fullscreen ~= nil and vim.g.neovide_fullscreen then
            vim.g.neovide_fullscreen = true
        else
            vim.g.neovide_fullscreen = false
        end
    end, { desc = "Toggle fullscreen in neovide" })
end
