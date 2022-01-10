local dap = require('dap')

dap.adapters.codelldb = {
    type = 'server',
    host = '127.0.0.1',
    port = 13000
}

-- dap.adapters.codelldb = function(on_adapter)
--     local stdout = vim.loop.new_pipe(false)
--     local stderr = vim.loop.new_pipe(false)

--     -- CHANGE THIS!
--     local cmd = '/home/aravind/sources/codelldb-x86_64-linux/extension/lldb/bin/lldb'

--     local handle, pid_or_err
--     local opts = {
--         stdio = {nil, stdout, stderr},
--         detached = true,
--     }
--     handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
--         stdout:close()
--         stderr:close()
--         handle:close()
--         if code ~= 0 then
--             print("codelldb exited with code", code)
--         end
--     end)
--     assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
--     stdout:read_start(function(err, chunk)
--         assert(not err, err)
--         if chunk then
--             local port = chunk:match('Listening on port (%d+)')
--             if port then
--                 vim.schedule(function()
--                     on_adapter({
--                         type = 'server',
--                         host = '127.0.0.1',
--                         port = port
--                     })
--                 end)
--             else
--                 vim.schedule(function()
--                     require("dap.repl").append(chunk)
--                 end)
--             end
--         end
--     end)
--     stderr:read_start(function(err, chunk)
--         assert(not err, err)
--         if chunk then
--             vim.schedule(function()
--                 require("dap.repl").append(chunk)
--             end)
--         end
--     end)
-- end

dap.configurations.cpp = {
    {
        name = "attach",
        type = "codelldb",
        request = "attach",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/hw/bin/linux64/hw', 'file')
        end,
        pid = function()
            local handle = io.popen('pgrep hw$')
            local result = handle:read()
            handle:close()
            return result
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        terminal = 'integrated',
    },
}
