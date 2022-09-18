local dap = require('dap')
local M = {}

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

local dapopts = {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}

function M.config_dapui()
    require("dapui").setup({
      icons = { expanded = "▾", collapsed = "▸" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
      },
      sidebar = {
        -- You can change the order of elements in the sidebar
        elements = {
          -- Provide as ID strings or tables with "id" and "size" keys
          {
            id = "scopes",
            size = 0.25, -- Can be float or integer > 1
          },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 00.25 },
        },
        size = 40,
        position = "left", -- Can be "left", "right", "top", "bottom"
      },
      tray = {
        elements = { "repl" },
        size = 10,
        position = "bottom", -- Can be "left", "right", "top", "bottom"
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
    })
end

return M
