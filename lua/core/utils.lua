local M = { }

function M.update_title()
  vim.cmd [[let &titlestring = "neovim - " . expand("%:t")]]
end

return M
