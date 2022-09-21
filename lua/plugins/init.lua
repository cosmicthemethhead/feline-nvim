local plugins = {
  --- utils ---
  -- pkg mgr
  ["wbthomason/packer.nvim"] = {
    cmd = require("core.lazy_load").packer_cmds,
    config = function()
      require "plugins"
    end,
  },
  -- util funcs used by several plugins
  ["nvim-lua/plenary.nvim"] = { module = "plenary" },
  -- speeds up starup time
  ["lewis6991/impatient.nvim"] = { },

  --- ui ---
  -- icons api
  ["kyazdani42/nvim-web-devicons"] = {
    config = function()
      require("plugins.configs.devicons")
    end,
  },

  --- tab/buffer ---
  -- tabline
  ["akinsho/bufferline.nvim"] = {
    tag = "v2.*",
    setup = function()
      require("core.utils").load_mappings("tabline")
    end,
    config = function()
      require("plugins.configs.bufferline")
    end
  },
  -- better buffer deletion
  ["famiu/bufdelete.nvim"] = { },

  --- fuzzy finders ---
  ["nvim-telescope/telescope.nvim"] = {
    config = function()
      require "plugins.configs.telescope"
    end,
    setup = function()
      require("core.utils").load_mappings "telescope"
    end,
  },

  --- file explorer ---
  ["kyazdani42/nvim-tree.lua"] = {
    config = function()
      require "plugins.configs.nvim-tree"
    end,
    setup = function()
      require("core.utils").load_mappings("nvim_tree")
    end,
  },

  --- lsp stuff ---
  -- lsp installer
  ["williamboman/mason.nvim"] = {
    cmd = require("core.lazy_load").mason_cmds,
    config = function()
      require "plugins.configs.mason"
    end,
  },
  ["williamboman/mason-lspconfig.nvim"] = { },
  -- lsp mgr
  ["neovim/nvim-lspconfig"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-lspconfig"
    end,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  --- completion ---
  ["hrsh7th/cmp-nvim-lua"] = {
    config = function()
      require("plugins.configs.cmp")
    end
  },
  ["christianchiarulli/nvim-cmp"] = { },
  ["hrsh7th/cmp-buffer"] = { }, -- buffer completions
  ["hrsh7th/cmp-path"] = { }, -- path completions

  --- treesitter ---
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
  -- colour coded parentheses
  ["p00f/nvim-ts-rainbow"] = {
    after = "nvim-treesitter"
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "indent-blankline.nvim"
    end,
    config = function()
      require("plugins.configs.others").blankline()
    end,
  },

  --- comment stuff ---
  ["numToStr/Comment.nvim"] = {
    config = function()
      require("plugins.configs.others").comment()
    end
  },
  -- better better todo comment highlighting
  ["folke/todo-comments.nvim"] = {
    setup = function()
      require("core.utils").load_mappings("todo")
    end,
    config = function()
      require("plugins.configs.others").todo()
    end
  },

  --- git ---
  -- git dif highlighting
  ["lewis6991/gitsigns.nvim"] = {
    ft = "gitcommit",
    setup = function()
      require("core.lazy_load").gitsigns()
    end,
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
  },

  --- language specific plugins ---
  -- mardown viewer
  ["iamcco/markdown-preview.nvim"] = {
    event = { "Filetype markdown" },
    run = "cd app && npm install",
    ft = "markdown",
  },
  -- show rust crates data
  ["Saecki/crates.nvim"] = {
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end
  },

  --- editing ---
  ["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  },

  --- colour stuff ---
  -- colour viewer
  ["norcalli/nvim-colorizer.lua"] = {
    config = function()
      require("colorizer").setup()
    end
  },
  -- colourscheme
  ["catppuccin/nvim"] = {
    as = "catppuccin",
    config = function()
      vim.cmd [[ colorscheme catppuccin ]]
      require("plugins.configs.colourschemes").catppuccin()
    end
  },
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
