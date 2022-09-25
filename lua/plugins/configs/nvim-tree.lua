local present, nvim_tree = pcall(require, "nvim-tree")

if not present then
  vim.notify("failed to load: nvim-tree", "error", {
    title = "plugin.configs.nvim-tree",
  })
  return
end

local config_present, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_present then
  vim.notify("failed to load: nvim-tree_config", "error", {
    title = "plugin.configs.nvim-tree_config",
  })
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

local options = {
  filters = {
    dotfiles = false,
    exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
  },
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = { "alpha" },
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  view = {
    width = 25,
    hide_root_folder = true,
    side = "left",
    adaptive_size = true,
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
    number = false,
    relativenumber = false,
  },
  git = {
    enable = true,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "none",

    indent_markers = {
      enable = false,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = true,
      },

      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          open = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged  = "",
          staged    = "",
          unmerged  = "",
          renamed   = "",
          untracked = "",
          deleted   = "",
          ignored   = "",
        },
      },
    },
  },
}

vim.g.nvimtree_side = options.view.side
nvim_tree.setup(options)
