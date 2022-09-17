local plugins = {
  ["nvim-lua/plenary.nvim"] = { module = "plenary" },

  ["lewis6991/impatient.nvim"] = { },

  -- ["cosmicthemethhead/yarnline"] = { },

  ["wbthomason/packer.nvim"] = {
    cmd = require("core.lazy_load").packer_cmds,
    config = function()
      require "plugins"
    end,
  },

  ["kyazdani42/nvim-web-devicons"] = {
    config = function()
      require("plugins.configs.devicons")
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    module = "nvim-treesitter",
    setup = function()
      require("core.lazy_load").on_file_open "nvim-treesitter"
    end,
    cmd = require("core.lazy_load").treesitter_cmds,
    run = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  },

  ["lewis6991/gitsigns.nvim"] = {
    ft = "gitcommit",
    setup = function()
      require("core.lazy_load").gitsigns()
    end,
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
  },

  -- Markdown
  ["iamcco/markdown-preview.nvim"] = {
    event = { "Filetype markdown" },
    run = "cd app && npm install",
    ft = "markdown",
  },

  -- file managing , picker etc
  ["kyazdani42/nvim-tree.lua"] = {
    config = function()
      require "plugins.configs.nvim-tree"
    end,
    setup = function()
      require("core.utils").load_mappings("nvim_tree")
    end,
  },

  ["nvim-telescope/telescope.nvim"] = {
    config = function()
      require "plugins.configs.telescope"
    end,
    setup = function()
      require("core.utils").load_mappings "telescope"
    end,
  },

  ["Saecki/crates.nvim"] = {
    event = { "BufRead Cargo.toml" },
    config = function()
      require('crates').setup()
    end
  },

  ["catppuccin/nvim"] = { as = "catppuccin" },
}

-- load all plugins
local present, packer = pcall(require, "packer")

if present then
  vim.cmd "packadd packer.nvim"

  -- override with default plugins with user ones
  plugins = require("core.utils").merge_plugins(plugins)

  -- load packer init options
  local init_options = require("plugins.configs.others").packer_init()
  init_options = require("core.utils").load_override(init_options, "wbthomason/packer.nvim")
  packer.init(init_options)

  for _, v in pairs(plugins) do
    packer.use(v)
  end
end
