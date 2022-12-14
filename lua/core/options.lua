local opt = vim.opt
local g = vim.g

opt.mouse = ''                -- disable mouse
opt.laststatus = 3            -- global statusline
opt.title = true              -- custom term title
opt.clipboard = "unnamedplus" -- use system clipboard
opt.showmode = false          -- dont print mode changes
opt.cursorline = true
opt.wrap = false

-- tab
opt.smarttab = true  -- easyer tab deletion
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 2
opt.tabstop = 2

-- number
opt.number = true
opt.relativenumber = true
opt.numberwidth = 3
opt.ruler = false

-- scrolling margin
opt.scrolloff = 8     -- vertical
opt.sidescrolloff = 8 -- horizontal

-- show a char in place of whitespace characters
opt.list = true
opt.listchars:append "space:⋅"

-- bufferline
opt.showtabline = 2

opt.fillchars:append { eob = ' ' }

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

g.mapleader = " "

-- disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
