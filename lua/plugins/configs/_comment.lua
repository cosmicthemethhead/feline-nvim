local M = { }
local load_override = require("core.utils").load_override

M.comment = function()
  local present, nvim_comment = pcall(require, "Comment")

  if not present then
    return
  end

  local opts = {}
  opts = load_override(opts, "numToStr/Comment.nvim")
  nvim_comment.setup(opts)
end

-- BUG: fix some colour stuff
M.todo = function()
  local present, todo = pcall(require, "todo-comments")

  if not present then
    return
  end

  vim.cmd [[ hi clear TODO ]]

  local opts = {
    signs = false, -- show icons in the signs column

    -- keywords recognized as todo comments
    keywords = {
      FIX =  { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = "祥", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    highlight = {
      keyword = "fg",
    },
  }

  opts = load_override(opts, "folke/todo-comments.nvim")
  todo.setup(opts)
end

return M
