-- n, v, i, t = mode names

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {
  n = {
    -- unbind arrow keys
    ["<UP>"]        = {"<NOP>", "unbind up arrow key"};
    ["<DOWN>"]      = {"<NOP>", "unbind down arrow key"};
    ["<LEFT>"]      = {"<NOP>", "unbind left arrow key"};
    ["<RIGHT>"]     = {"<NOP>", "unbind right arrow key"};
    ["<C-UP>"]      = {"<NOP>", "unbind ctrl-up arrow key"};
    ["<C-DOWN>"]    = {"<NOP>", "unbind ctrl-down arrow key"};
    ["<C-LEFT>"]    = {"<NOP>", "unbind ctrl-left arrow key"};
    ["<C-RIGHT>"]   = {"<NOP>", "unbind ctrl-right arrow key"};
    ["<C-A-UP>"]    = {"<NOP>", "unbind ctrl-alt-up arrow key"};
    ["<C-A-DOWN>"]  = {"<NOP>", "unbind ctrl-alt-down arrow key"};
    ["<C-A-LEFT>"]  = {"<NOP>", "unbind ctrl-alt-left arrow key"};
    ["<C-A-RIGHT>"] = {"<NOP>", "unbind ctrl-altr-ight arrow key"};
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },

    -- save 
    ["<C-s>"] = { "<CMD>lua require('core.utils').write()<CR>", "save file" },

    -- removed undo/redo msgs
    ["u"] = {"<CMD>silent undo<CR>", "undo"},
    ["<C-r>"] = {"<CMD>silent redo<CR>", "redo"},
  },

  i = {
    -- unbind arrow keys
    ["<UP>"]        = {"<NOP>", "unbind up arrow key"};
    ["<DOWN>"]      = {"<NOP>", "unbind down arrow key"};
    ["<LEFT>"]      = {"<NOP>", "unbind left arrow key"};
    ["<RIGHT>"]     = {"<NOP>", "unbind right arrow key"};
    ["<C-UP>"]      = {"<NOP>", "unbind ctrl-up arrow key"};
    ["<C-DOWN>"]    = {"<NOP>", "unbind ctrl-down arrow key"};
    ["<C-LEFT>"]    = {"<NOP>", "unbind ctrl-left arrow key"};
    ["<C-RIGHT>"]   = {"<NOP>", "unbind ctrl-right arrow key"};
    ["<C-A-UP>"]    = {"<NOP>", "unbind ctrl-alt-up arrow key"};
    ["<C-A-DOWN>"]  = {"<NOP>", "unbind ctrl-alt-down arrow key"};
    ["<C-A-LEFT>"]  = {"<NOP>", "unbind ctrl-alt-left arrow key"};
    ["<C-A-RIGHT>"] = {"<NOP>", "unbind ctrl-altr-ight arrow key"};
  },

  v = {
    -- unbind arrow keys
    ["<UP>"]        = {"<NOP>", "unbind up arrow key"};
    ["<DOWN>"]      = {"<NOP>", "unbind down arrow key"};
    ["<LEFT>"]      = {"<NOP>", "unbind left arrow key"};
    ["<RIGHT>"]     = {"<NOP>", "unbind right arrow key"};
    ["<C-UP>"]      = {"<NOP>", "unbind ctrl-up arrow key"};
    ["<C-DOWN>"]    = {"<NOP>", "unbind ctrl-down arrow key"};
    ["<C-LEFT>"]    = {"<NOP>", "unbind ctrl-left arrow key"};
    ["<C-RIGHT>"]   = {"<NOP>", "unbind ctrl-right arrow key"};
    ["<C-A-UP>"]    = {"<NOP>", "unbind ctrl-alt-up arrow key"};
    ["<C-A-DOWN>"]  = {"<NOP>", "unbind ctrl-alt-down arrow key"};
    ["<C-A-LEFT>"]  = {"<NOP>", "unbind ctrl-alt-left arrow key"};
    ["<C-A-RIGHT>"] = {"<NOP>", "unbind ctrl-altr-ight arrow key"};
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
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "show keys" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
  },
}

return M
