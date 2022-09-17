local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
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

  indent = {
    enable = true,
  },
}

-- check for any override
options = require("core.utils").load_override(options, "nvim-treesitter/nvim-treesitter")
treesitter.setup(options)
