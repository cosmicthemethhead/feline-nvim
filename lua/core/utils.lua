local M = { }

function M.update_title()
  vim.opt.titlestring = "neovim - "..vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

return M
