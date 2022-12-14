local M = { }
local load_override = require("core.utils").load_override

M.autopairs = function()
  local present_a, autopairs = pcall(require, "nvim-autopairs")
  local present_c, cmp = pcall(require, "cmp")

  if not (present_a and present_c) then
    return
  end

  local opts = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  }

  opts = load_override(opts, "windwp/nvim-autopairs")
  autopairs.setup(opts)

  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
