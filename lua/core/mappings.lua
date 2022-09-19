-- n, v, i, t = mode names

-- local function termcodes(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

local M = {}

M.general = {
  n = {
    -- unbind arrow keys
    ["<UP>"]        = { "<NOP>", "unbind up arrow key" },
    ["<DOWN>"]      = { "<NOP>", "unbind down arrow key" },
    ["<LEFT>"]      = { "<NOP>", "unbind left arrow key" },
    ["<RIGHT>"]     = { "<NOP>", "unbind right arrow key" },
    ["<C-UP>"]      = { "<NOP>", "unbind ctrl-up arrow key" },
    ["<C-DOWN>"]    = { "<NOP>", "unbind ctrl-down arrow key" },
    ["<C-LEFT>"]    = { "<NOP>", "unbind ctrl-left arrow key" },
    ["<C-RIGHT>"]   = { "<NOP>", "unbind ctrl-right arrow key" },
    ["<C-A-UP>"]    = { "<NOP>", "unbind ctrl-alt-up arrow key" },
    ["<C-A-DOWN>"]  = { "<NOP>", "unbind ctrl-alt-down arrow key" },
    ["<C-A-LEFT>"]  = { "<NOP>", "unbind ctrl-alt-left arrow key" },
    ["<C-A-RIGHT>"] = { "<NOP>", "unbind ctrl-altr-ight arrow key" },
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },

    -- save 
    ["<C-s>"] = { "<CMD>lua require('core.utils').write()<CR>", "save file" },

    -- removed undo/redo msgs
    ["u"]     = { "<CMD>silent undo<CR>", "undo" },
    ["<C-r>"] = { "<CMD>silent redo<CR>", "redo" },

    ["<C-/>"] = {"<CMD>noh | echo ''<CR>", "remove search"},
  },

  i = {
    -- unbind arrow keys
    ["<UP>"]        = { "<NOP>", "unbind up arrow key" },
    ["<DOWN>"]      = { "<NOP>", "unbind down arrow key" },
    ["<LEFT>"]      = { "<NOP>", "unbind left arrow key" },
    ["<RIGHT>"]     = { "<NOP>", "unbind right arrow key" },
    ["<C-UP>"]      = { "<NOP>", "unbind ctrl-up arrow key" },
    ["<C-DOWN>"]    = { "<NOP>", "unbind ctrl-down arrow key" },
    ["<C-LEFT>"]    = { "<NOP>", "unbind ctrl-left arrow key" },
    ["<C-RIGHT>"]   = { "<NOP>", "unbind ctrl-right arrow key" },
    ["<C-A-UP>"]    = { "<NOP>", "unbind ctrl-alt-up arrow key" },
    ["<C-A-DOWN>"]  = { "<NOP>", "unbind ctrl-alt-down arrow key" },
    ["<C-A-LEFT>"]  = { "<NOP>", "unbind ctrl-alt-left arrow key" },
    ["<C-A-RIGHT>"] = { "<NOP>", "unbind ctrl-altr-ight arrow key" },

    -- save
    ["<C-s>"] = { "<CMD>lua require('core.utils').write()<CR>", "save file" },

    -- remap ins esc
    ["jk"]    = { "<ESC>" },
    ["<ESC>"] = { "<NOP>" },
  },

  v = {
    -- unbind arrow keys
    ["<UP>"]        = { "<NOP>", "unbind up arrow key" },
    ["<DOWN>"]      = { "<NOP>", "unbind down arrow key" },
    ["<LEFT>"]      = { "<NOP>", "unbind left arrow key" },
    ["<RIGHT>"]     = { "<NOP>", "unbind right arrow key" },
    ["<C-UP>"]      = { "<NOP>", "unbind ctrl-up arrow key" },
    ["<C-DOWN>"]    = { "<NOP>", "unbind ctrl-down arrow key" },
    ["<C-LEFT>"]    = { "<NOP>", "unbind ctrl-left arrow key" },
    ["<C-RIGHT>"]   = { "<NOP>", "unbind ctrl-right arrow key" },
    ["<C-A-UP>"]    = { "<NOP>", "unbind ctrl-alt-up arrow key" },
    ["<C-A-DOWN>"]  = { "<NOP>", "unbind ctrl-alt-down arrow key" },
    ["<C-A-LEFT>"]  = { "<NOP>", "unbind ctrl-alt-left arrow key" },
    ["<C-A-RIGHT>"] = { "<NOP>", "unbind ctrl-altr-ight arrow key" },

    -- save
    ["<C-s>"] = { "<CMD>lua require('core.utils').write()<CR>", "save file" },
  },

  c = {
    ["ESC"] = { "<NOP>", "unbind esc key cuz it was replaced by 'jk'" },
    ["jk"] = { "<ESC>", "easier way to exit cmd mode" },
  }
}

M.tabline = {
  plugin = true,

  n = {
    ["<S-j>"]   = { "<CMD>BufferLineCyclePrev<CR>", "tabline cycle prev" },
    ["<S-k>"]   = { "<CMD>BufferLineCycleNext<CR>", "tabline cycle next" },
    ["<S-A-j>"] = { "<CMD>BufferLineMovePrev <CR>", "tabline move prev"  },
    ["<S-A-k>"] = { "<CMD>BufferLineMoveNext <CR>", "tabline move next"  },
    ["<S-x>"]   = { "<CMD>lua require('bufdelete').bufdelete(0)<CR>", "tab deletion" },
  }
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "lsp declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    },

    ["L"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "lsp implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "lsp signature_help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "lsp definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "lsp code_action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "lsp references",
    },

    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "goto prev",
    },

    ["d]"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "goto_next",
    },

    -- TODO: replace with trouble.nvim
    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
    },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.formatting {}
      end,
      "lsp formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "list workspace folders",
    },
  },
}

M.nvim_tree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files"    },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>",  "live grep"     },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>",    "find buffers"  },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>",  "help page"     },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>",   "find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>",    "show keys"     },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status"   },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
  },
}

M.todo = {
  plugin = true,

  n = {
    ["<leader>ft"] = { "<CMD>TodoTelescope<CR>", "find todos" },
  }
}

return M
