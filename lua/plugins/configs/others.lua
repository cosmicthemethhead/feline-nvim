local M = { }

local load_override = require("core.utils").load_override

M.autopairs = function()
  local present1, autopairs = pcall(require, "nvim-autopairs")
  local present2, cmp = pcall(require, "cmp")

  if not (present1 and present2) then
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
      "alpha",
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

return M
