local M = { }

local load_override = require("core.utils").load_override

M.autopairs = function()
  local present_a, autopairs = pcall(require, "nvim-autopairs")
  local present_c, cmp = pcall(require, "cmp")

  if not (present_a and present_c) then
    return
  end

  local options = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  }

  options = load_override(options, "windwp/nvim-autopairs")
  autopairs.setup(options)

  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.blankline = function()
  local present, blankline = pcall(require, "indent_blankline")

  if not present then
    return
  end

  local options = {
    indentLine_enabled = 1,
    filetype_exclude = {
      "help",
      "terminal",
      "aerial",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "NvimTree",
      "mason",
      "",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
  }

  options = load_override(options, "lukas-reineke/indent-blankline.nvim")
  blankline.setup(options)
end

M.colorizer = function()
  local present, colorizer = pcall(require, "colorizer")

  if not present then
    return
  end

  local web_opts = {
    RGB      = true;
    RRGGBB   = true;
    names    = true;
    RRGGBBAA = true;
    rgb_fn   = true;
    hsl_fn   = true;
    css      = true;
    css_fn   = true;
  }

  local opts = {
    css = web_opts
  }

  opts = load_override(opts, "norcalli/nvim-colorizer.lua")
  colorizer.setup(opts)
end

M.comment = function()
  local present, nvim_comment = pcall(require, "Comment")

  if not present then
    return
  end

  local opts = {}
  opts = load_override(opts, "numToStr/Comment.nvim")
  nvim_comment.setup(opts)
end

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

M.gitsigns = function()
  local present, gitsigns = pcall(require, "gitsigns")

  if not present then
    return
  end

  local options = {
    signs = {
      add =          { hl = "GitSignsAdd",    text = "▎",  numhl = "GitSignsAddNr",    linehl = "GitSignsAddLn"    },
      change =       { hl = "GitSignsChange", text = "▎",  numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete =       { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete =    { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      changedelete = { hl = "GitSignsChange", text = "▎",  numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
  }

  options = load_override(options, "lewis6991/gitsigns.nvim")
  gitsigns.setup(options)
end

M.luasnip = function()
  local present, luasnip = pcall(require, "luasnip")

  if not present then
    return
  end

  local options = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  options = load_override(options, "L3MON4D3/LuaSnip")
  luasnip.config.set_config(options)
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

M.notify = function()
  local present, notify = pcall(require, "notify")

  if not present then
    return
  end

  local opts = {
    fps = 60,
    icons = {
      DEBUG = "",
      ERROR = "",
      INFO = "",
      TRACE = "✎",
      WARN = ""
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

M.packer_init = function()
  return {
    display = {
      -- set icons
      working_sym = '',
      error_sym   = '',
      done_sym    = '',
      removed_sym = '',
      moved_sym   = '',
      -- set keymaps
      keybindings = { toggle_info = 'l' },
      -- have packer use a popup window
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
    },
  }
end

-- FIXME: fix some colour stuff
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
