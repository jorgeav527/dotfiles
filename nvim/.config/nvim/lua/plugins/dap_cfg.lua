local dap = require('dap')
dap.adapters.debugpy = function(cb, config)
  if config.request == 'attach' then
    cb({
      type = 'server',
      port = config.connect.port,
      host = config.connect.host or '127.0.0.1',
    })
  else
    cb({
      type = 'executable',
      command = 'debugpy-adapter',
    })
  end
end
dap.configurations.python = {
  {
    type = 'debugpy',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    python = function()
      local root = vim.fs.root(0, '.venv')
      return { root and root .. '/.venv/bin/python' or 'python3' }
    end,
    cwd = function()
      return vim.fs.root(0, '.venv') or vim.fn.getcwd()
    end,
  },
}
