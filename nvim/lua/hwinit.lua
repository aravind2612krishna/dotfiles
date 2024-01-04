vim.keymap.set('n', "<C-s>", function ()
    local p4client=os.getenv("P4CLIENT")
    if p4client ~= nil then
        local sesspath = "~/" .. p4client .. ".vim"
        print("Saving session to " .. sesspath)
        vim.cmd.mksession("sesspath")
    else
        print("No P4CLIENT set")
    end
end)
