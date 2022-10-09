local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  vim.notify("failed to load: treesitter", "error", {
    title = "plugin.configs.treesitter",
  })
  return
end

local options = {
  ensure_installed = "all", -- one of "all" or a list of languages
  sync_install = false,     -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" },  -- List of parsers to ignore installing

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  rainbow = {
    enable = true,
    extended_mode = true, -- enable for html tags
    max_file_lines = 999, -- don't enable for files with more than x lines

    colors = {
      "#ffd700",
      "#e762d6",
      "#029df8",
    },
  }
}

-- check for any override
options = require("core.utils").load_override(options, "nvim-treesitter/nvim-treesitter")
treesitter.setup(options)
