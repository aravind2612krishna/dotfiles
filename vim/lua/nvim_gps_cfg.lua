require("nvim-gps").setup()
_G.gps_location = function()
    local gps = require "nvim-gps"
    if (gps.is_available() and gps.get_location() ~= "")
    then
        icon = vim.fn.WebDevIconsGetFileTypeSymbol()
        return " " .. icon .. " " .. gps.get_location() 
        -- return " " .. icon .. " → " .. gps.get_location() 
        -- return gps.get_location() .. " " .. icon .. " "
    else
        return ""
    end
end

vim.opt.winbar = "%{%v:lua.gps_location()%}"

vim.api.nvim_create_autocmd ("CursorMoved", {
    pattern = '*',
    command = "set winbar=%r%m%t%{%v:lua.gps_location()%}",
})
