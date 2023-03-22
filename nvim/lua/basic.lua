-- font
vim.opt.guifont("IBM Plex Mono Text:h11")

-- Aravind preferred settings
vim.g.mapleader = " " -- Space is my leader key
vim.keymap.set('i', 'jj', '<Esc>', { description = "jj is easier to reach than Escape" })
vim.keymap.set('n', '<C-h>', '<C-W>h', { remap = true, description = "Pane left" })
vim.keymap.set('n', '<C-j>', '<C-W>j', { remap = true, description = "Pane down" })
vim.keymap.set('n', '<C-k>', '<C-W>k', { remap = true, description = "Pane up" })
vim.keymap.set('n', '<C-l>', '<C-W>l', { remap = true, description = "Pane right" })
-- vim.keymap.set('n', '<S-H>', vim.cmd.bprevious, { remap = true, description = "Previous buffer" })
-- vim.keymap.set('n', '<S-L>', vim.cmd.bnext, { remap = true, description = "Next buffer" })
vim.keymap.set('n', '<S-H>', vim.cmd.tabprevious, { remap = true, description = "Previous tab" })
vim.keymap.set('n', '<S-L>', vim.cmd.tabnext, { remap = true, description = "Next tab" })
vim.keymap.set('n', "<leader>e", ":e <C-R>=expand(\"%:p:h\") . \"/\"")
vim.keymap.set('n', "<leader>t", ":tabe <C-R>=expand(\"%:p:h\") . \"/\"")
vim.keymap.set('n', "<leader>s", ":split <C-R>=expand(\"%:p:h\") . \"/\"")
vim.keymap.set('n', "<leader>c", ":cd <C-R>=expand(\"%:p:h\") . \"/\"")
vim.keymap.set('n', "<leader>c", ":w <C-R>=expand(\"%:p:h\") . \"/\"")
-- location list
vim.keymap.set('n', '<M-n>', vim.cmd.lnext)
vim.keymap.set('n', '<M-p>', vim.cmd.lprev)
vim.keymap.set('n', '<M-q>', vim.cmd.lclose)
vim.keymap.set('n', '<M-e>', function ()
    local currwinid = vim.fn.win_getid()
    vim.cmd.topleft("lopen")
    vim.fn.win_gotoid(currwinid) -- go back to previous window
end)
vim.keymap.set('n', '<C-n>', vim.cmd.cnext)
vim.keymap.set('n', '<C-p>', vim.cmd.cprev)
vim.keymap.set('n', '<C-q>', vim.cmd.cclose)
vim.keymap.set('n', '<C-e>', function ()
    local currwinid = vim.fn.win_getid()
    vim.cmd.topleft("copen") -- open quickfix top left
    vim.fn.win_gotoid(currwinid) -- go back to previous window
end)

-- Other preferences that are not default
vim.opt.showmode = false                           -- do not show mode changes at the bottom
vim.opt.showcmd = false                            -- do not show partial command at the bottom
vim.opt.autoread = false                           -- do not auto refresh external changes to file
vim.opt.whichwrap:append({ 'h', 'l' })             -- wrap on h and l. (Not recommended, why?)
vim.opt.ignorecase = true                          -- case-insensitive search
vim.opt.smartcase = true                           -- case sensitive search if search string has caps
vim.opt.lazyredraw = false                         -- for draw performance
vim.opt.termguicolors = true                       -- 24bit colors in TUI
vim.opt.virtualedit:append({ 'block', 'onemore' }) -- allow moving cursor past end of the line
vim.opt.sidescroll = 2                             -- side scrolling
vim.opt.pumheight = 4                              -- max number of completion items
vim.opt.smartindent = true                         -- auto indent after {, etc
vim.opt.wrap = false                               -- no word wrap
-- vim.opt.mouse = "a"
vim.opt.signcolumn = "yes:2"

-- Folds
vim.opt.fdo:append('jump') -- open folds on jump
vim.opt.guioptions = 'g'   -- only minimal gui options
vim.opt.expandtab = true   -- expand tabs to spaces
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.foldmethod = "marker"   -- fold by markers by default
vim.opt.complete = { ".", "w" } -- auto complete from current buffer and open windows by default
vim.opt.cindent = true
vim.opt.cino = { 't0', ':0', '(0', 'N-s' }
vim.opt.linebreak = true
vim.opt.number = true -- line numbers
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages" } -- store these in mksession
vim.opt.clipboard = "unnamedplus" -- clipboard to vim yank
vim.opt.shortmess:append("c")
vim.opt.diffopt:append({"algorithm:patience", "indent-heuristic"})
-- vim.opt.updatetime = 500

-- autocmds
local cppautosgrp = vim.api.nvim_create_augroup('cppautos', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    pattern = { "*.c", "*.cpp" },
    group = cppautosgrp,
    description = "Comment individual lines in C/C++",
    callback = function()
        vim.opt_local.commentstring = "//%s"
    end
})

local generalautosgrp = vim.api.nvim_create_augroup('generalautos', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*',
    group = generalautosgrp,
    description = "For all buffers, return to last edit position",
    callback = function()
        if (vim.fn.line("'\"") > 1) and (vim.fn.line("'\"") <= vim.fn.line("$")) then
            vim.fn.execute("'\"")
        end
    end
})

local checktimeaugroup = vim.api.nvim_create_augroup('checktime', {clear=true})
if not vim.fn.has("gui_running") then
    vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "BufEnter", "FocusLost", "WinLeave" },
    { pattern = "*", callback = vim.cmd.checktime })
end

-- augroup checktime
--     autocmd!
--     if !has("gui_running")
--         "silent! necessary otherwise throws errors when using command
--         "line window.
--         autocmd BufEnter,FocusGained,BufEnter,FocusLost,WinLeave * checktime
--     endif
-- augroup END
