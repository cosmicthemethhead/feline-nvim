-- insparation (aka plagiarism):
--   NvChad             - https://github.com/NvChad/NvChad/
--   christianChiarulli - https://github.com/christianChiarulli/nvim/

require("core")
require("core.options")

-- setup packer && plugins
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
-- make sure that packer was installed
if fn.empty(fn.glob(install_path)) > 0 then
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })

  print "Cloning packer.."
  fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }

  -- install plugins && compile their configs
  vim.cmd "packadd packer.nvim"
  require "plugins"
  vim.cmd "PackerSync"

  -- install binaries from mason.nvim && tsparsers
  vim.api.nvim_create_autocmd("User", {
    pattern = "PackerComplete",
    callback = function()
      vim.cmd "bw | silent! MasonInstallAll" -- close packer window
      require("packer").loader "nvim-treesitter"
    end,
  })
  print "Finished cloning packer"
end

pcall(require, "custom")

require("core.utils").load_mappings()
require("plugins.configs.colourschemes").tokyonight()
