local M = { }
local merge_tb = vim.tbl_deep_extend

M.update_title = function()
  vim.opt.titlestring = "neovim - "..vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

M.load_config = function()
  local config = require "core.default_config"
  local chadrc_exists, chadrc = pcall(require, "custom.chadrc")

  if chadrc_exists then
    -- merge user config if it exists and is a table; otherwise display an error
    if type(chadrc) == "table" then
      config = merge_tb("force", config, chadrc) or {}
    else
      error "chadrc must return a table!"
    end
  end

  return config
end

-- override plugin options table with custom ones
M.load_override = function(options_table, name)
  local plugin_configs, plugin_options = M.load_config().plugins, nil

  -- support old plugin syntax for override
  local user_override = plugin_configs.override and plugin_configs.override[name]
  if user_override and type(user_override) == "table" then
    plugin_options = user_override
  end

  -- if no old style plugin override is found, then use the new syntax
  if not plugin_options and plugin_configs[name] then
    local override_options = plugin_configs[name].override_options or {}
    if type(override_options) == "table" then
      plugin_options = override_options
    elseif type(override_options) == "function" then
      plugin_options = override_options()
    end
  end

  -- make sure the plugin options are a table
  plugin_options = type(plugin_options) == "table" and plugin_options or {}

  return merge_tb("force", options_table, plugin_options)
end

M.packer_sync = function(...)
  local git_exists, git = pcall(require, "nvchad.utils.git")
  local defaults_exists, defaults = pcall(require, "nvchad.utils.config")
  local packer_exists, packer = pcall(require, "packer")

  if git_exists and defaults_exists then
    local current_branch_name = git.get_current_branch_name()

    -- warn the user if we are on a snapshot branch
    if current_branch_name:match(defaults.snaps.base_snap_branch_name .. "(.+)" .. "$") then
      vim.api.nvim_echo({
        { "WARNING: You are trying to use ", "WarningMsg" },
        { "PackerSync" },
        {
          " on a NvChadSnapshot. This will cause issues if NvChad dependencies contain "
            .. "any breaking changes! Plugin updates will not be included in this "
            .. "snapshot, so they will be lost after switching between snapshots! Would "
            .. "you still like to continue? [y/N]\n",
          "WarningMsg",
        },
      }, false, {})

      local ans = vim.trim(string.lower(vim.fn.input "-> "))

      if ans ~= "y" then
        return
      end
    end
  end

  if packer_exists then
    packer.sync(...)

    local plugins = M.load_config().plugins
    local old_style_options = plugins.user or plugins.override or plugins.remove
    if old_style_options then
      vim.notify_once("NvChad: This plugin syntax is deprecated, use new style config.", "Error")
    end
  else
    error "Packer could not be loaded!"
  end
end

-- merge default/user plugin tables
M.merge_plugins = function(plugins)
  local plugin_configs = M.load_config().plugins
  local user_plugins = plugin_configs

  -- old plugin syntax for adding plugins
  if plugin_configs.user and type(plugin_configs.user) == "table" then
    user_plugins = plugin_configs.user
  end

  -- support old plugin removal syntax
  local remove_plugins = plugin_configs.remove
  if type(remove_plugins) == "table" then
    for _, v in ipairs(remove_plugins) do
      plugins[v] = nil
    end
  end

  plugins = merge_tb("force", plugins, user_plugins)

  local final_table = {}

  for key, val in pairs(plugins) do
    if val and type(val) == "table" then
      plugins[key] = val.rm_default_opts and user_plugins[key] or plugins[key]
      plugins[key][1] = key
      final_table[#final_table + 1] = plugins[key]
    end
  end

  return final_table
end

return M
