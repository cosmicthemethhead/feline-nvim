local present, mason = pcall(require, "mason")

if not present then
  vim.notify("failed to load: mason", "error", {
    title = "plugin.configs.mason",
  })
  return
end

local options = {
  ensure_installed = { "lua-language-server" }, -- not an option from mason.nvim

  ui = {
    icons = {
      package_pending = " ",
      package_installed = "ﱣ ",
      package_uninstalled = " ﮊ",
    },
  },

  max_concurrent_installers = 10,
}

options = require("core.utils").load_override(options, "williamboman/mason.nvim")

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
end, {})

mason.setup(options)
