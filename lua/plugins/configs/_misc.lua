local M = { }
local load_override = require("core.utils").load_override

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
