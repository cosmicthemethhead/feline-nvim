local present, mason = pcall(require, "mason")

if not present then
  vim.notify("failed to load: mason", "error", {
    title = "plugin.configs.mason",
  })
  return
end

local opts = {
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

opts = require("core.utils").load_override(opts, "williamboman/mason.nvim")

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
end, {})

mason.setup(opts)
