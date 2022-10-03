local M = { }
local load_override = require("core.utils").load_override

M.fidget = function()
  local present, fidget = pcall(require, "fidget")

  if not present then
    return
  end

  local opts = {
    text = {
      done = '',
      spinner = "dots",
    },
  }

  opts = load_override(opts, "j-hui/fidget.nvim")
  fidget.setup(opts)
end

M.illuminate = function()
  local present, illuminate = pcall(require, "illuminate")

  if not present then
    return
  end

  local opts = {
    filetypes_denylist = {
      "NvimTree",
      "TelescopePrompt",
    },
  }

  opts = load_override(opts, "RRethy/vim-illuminate")
  illuminate.configure(opts)
end

M.notify = function()
  local present, notify = pcall(require, "notify")

  if not present then
    return
  end

  local opts = {
    fps = 60,
    icons = {
      DEBUG = '',
      ERROR = '',
      INFO  = '',
      TRACE = '✎',
      WARN  = ''
    },
    render = "simple",
    stages = "slide",
    minimum_width = 50,
    maximum_width = 70,
  }

  opts = load_override(opts, "rcarriga/nvim-notify")
  notify.setup(opts)
  vim.notify = require("notify")
end

return M
