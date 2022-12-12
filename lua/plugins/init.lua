-- WishList:
--  translator: potamides/pantran.nvim
--  easier movement: justinmk/vim-sneak

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
  -- lsp info ui
  ["j-hui/fidget.nvim"] = {
    wants = "nvim-lspconfig",
    config = function()
      require("plugins.configs._ui").fidget()
    end
  },
  -- better notification ui
  ["rcarriga/nvim-notify"] = {
    config = function()
      require("plugins.configs._ui").notify()
    end
  },
  -- smooth scrolling
  ["psliwka/vim-smoothie"] = { },
  -- scrollbar that shows diagnostics & search result locations
  ["petertriho/nvim-scrollbar"] = {
    config = function()
      require("scrollbar").setup()
    end
  },
  -- helps me remember keymaps
  ["folke/which-key.nvim"] = {
    config = function()
      require("which-key").setup()
    end
  },
  ["RRethy/vim-illuminate"] = {
    setup = function()
      require("core.lazy_load").on_file_open "vim-illuminate"
    end,
    config = function()
      require("plugins.configs._ui").illuminate()
    end
  },

  --- syntax highlighting ---
  ["Fymyte/rasi.vim"]         = { ft = "rasi" },
  ["elkowar/yuck.vim"]        = { ft = "yuck" },
  ["tikhomirov/vim-glsl"]     = { ft = "glsl" },
  ["baskerville/vim-sxhkdrc"] = { ft = "conf" },

  --- editing ---
  ["monaqa/dial.nvim"] = { },
  -- autopairs parentheses
  ["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = function()
      require("plugins.configs._editing").autopairs()
    end,
  },
  -- better searching
  ["junegunn/vim-slash"] = { },
  ---- parentheses editing
  ["kylechui/nvim-surround"] = {
    config = function()
      require("nvim-surround").setup()
    end
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
    setup = function()
      require("core.utils").load_mappings "telescope"
    end,
    config = function()
      require "plugins.configs.telescope"
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
  ["hrsh7th/cmp-nvim-lua"]     = { after = "cmp_luasnip" },
  ["hrsh7th/cmp-nvim-lsp"]     = { after = "cmp-nvim-lua" },
  ["hrsh7th/cmp-buffer"]       = { after = "cmp-nvim-lsp" },
  ["hrsh7th/cmp-path"]         = { after = "cmp-buffer" },

  --- snippet ---
  ["rafamadriz/friendly-snippets"] = {
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  },
  ["L3MON4D3/LuaSnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs._misc").luasnip()
    end,
  },

  --- lsp, dap, linter and formatter installer ---
  ["williamboman/mason.nvim"] = {
    config = function()
      require "plugins.configs.mason"
    end
  },

  --- lsp ---
  ["neovim/nvim-lspconfig"] = {
    wants = "mason-lspconfig.nvim",
    after = "mason-lspconfig.nvim",
    config = function()
      require "plugins.configs.lspconfig"
    end
  },
  ["williamboman/mason-lspconfig.nvim"] = {
    after = "mason.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end
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

  --- indentation ---
  ["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "indent-blankline.nvim"
    end,
    config = function()
      require("plugins.configs._misc").blankline()
    end,
  },

  --- comment stuff ---
  ["numToStr/Comment.nvim"] = {
    branch = "master",
    config = function()
      require("plugins.configs._comment").comment()
    end
  },
  -- better better todo comment highlighting
  ["folke/todo-comments.nvim"] = {
    setup = function()
      require("core.utils").load_mappings("todo")
    end,
    config = function()
      require("plugins.configs._comment").todo()
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
      require("plugins.configs._misc").gitsigns()
    end,
  },

  --- rust ---
  -- show crates data
  ["Saecki/crates.nvim"] = {
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end
  },
  ["simrat39/rust-tools.nvim"] = { },

  --- language specific plugins ---
  -- mardown preview
  ["iamcco/markdown-preview.nvim"] = {
    event = { "Filetype markdown" },
    run = "cd app && npm install",
    ft = "markdown",
  },
  -- latex preview
  ["frabjous/knap"] = { ft = "tex" },
  ["stevearc/vim-arduino"] = { ft = "arduino" };

  --- colour stuff ---
  -- colour viewer
  ["norcalli/nvim-colorizer.lua"] = {
    setup = function()
      require("core.lazy_load").on_file_open "nvim-colorizer.lua"
    end,
    config = function()
      require("plugins.configs._misc").colorizer()
    end
  },
  ["nvim-colortils/colortils.nvim"] = { },

  --- colourscheme ---
  ["folke/tokyonight.nvim"] = { },
}

-- load all plugins
local present, packer = pcall(require, "packer")

if present then
  vim.cmd "packadd packer.nvim"

  -- override with default plugins with user ones
  plugins = require("core.utils").merge_plugins(plugins)

  -- load packer init options
  local init_options = require("plugins.configs._misc").packer_init()
  init_options = require("core.utils").load_override(init_options, "wbthomason/packer.nvim")
  packer.init(init_options)

  for _, v in pairs(plugins) do
    packer.use(v)
  end
end
