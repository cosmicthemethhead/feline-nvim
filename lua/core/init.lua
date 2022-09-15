local utils = require("core.utils")
local autocmd = vim.api.nvim_create_autocmd

utils.update_title()
autocmd("DirChanged", {
  callback = function()
    utils.update_title()
  end
})
