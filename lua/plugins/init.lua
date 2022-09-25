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
  ["rcarriga/nvim-notify"] = {
    config = function()
      require("plugins.configs.others").notify()
    end
  },
  -- smooth scrolling
  ["psliwka/vim-smoothie"] = { },
  ["folke/which-key.nvim"] = {
    config = function()
      require("which-key").setup()
    end
  },

  --- editing ---
  ["monaqa/dial.nvim"] = { },
  ---- parentheses editing
  ["kylechui/nvim-surround"] = {
    config = function()
      require("nvim-surround").setup()
    end
  },
  -- autopairs parentheses
  ["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  },
  ["Pocco81/true-zen.nvim"] = {
    setup = function()
      require("core.utils").load_mappings("true_zen")
    end,
    config = function()
      require("plugins.configs.true-zen")
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

  --- fuzzy finder ---
  ["nvim-telescope/telescope.nvim"] = {
    config = function()
      require "plugins.configs.telescope"
    end,
    setup = function()
      require("core.utils").load_mappings "telescope"
    end,
  },

  --- terminal intagration ---
  ["akinsho/toggleterm.nvim"] = {
    config = function()
      require("plugins.configs.toggleterm")
    end
  },

  --- file explorer ---
  ["kyazdani42/nvim-tree.lua"] = {
    config = function()
      require ("plugins.configs.nvim-tree")
    end,
    setup = function()
      require("core.utils").load_mappings("nvim_tree")
    end,
  },

  --- completion ---
  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    config = function()
      require "plugins.configs.cmp"
    end,
  },
  ["saadparwaiz1/cmp_luasnip"] = { after = "LuaSnip" },
  ["hrsh7th/cmp-nvim-lua"] = { after = "cmp_luasnip" },
  ["hrsh7th/cmp-buffer"] = { --[[ after = "cmp-nvim-lsp" ]] },
  ["hrsh7th/cmp-path"] = { after = "cmp-buffer" },

  --- snippet ---
  ["rafamadriz/friendly-snippets"] = {
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  },
  ["L3MON4D3/LuaSnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  },

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
  -- mardown preview
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
  -- latex preview
  ["frabjous/knap"] = {
    ft = "tex",
    config = function()
      require("plugins.configs.knap")
    end
  },

  --- colour stuff ---
  -- colour viewer
  ["norcalli/nvim-colorizer.lua"] = {
    config = function()
      require("colorizer").setup()
    end
  },
  ["nvim-colortils/colortils.nvim"] = { },
  -- colourscheme
  ["catppuccin/nvim"] = {
    as = "catppuccin",
    config = function()
      vim.cmd [[colorscheme catppuccin]]
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
