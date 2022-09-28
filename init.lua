-- insparation (aka plagiarism):
--   NvChad             - https://github.com/NvChad/NvChad/
--   christianChiarulli - https://github.com/christianChiarulli/nvim/


--   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆
--    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦
--          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄
--           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄
--          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀
--   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄
--  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄
-- ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄
-- ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄
--      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆
--       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃

--         ,.=:!!t3z.,
--        :tt;:;tt333EE3
--        Et;:;ztt33EEEL @Ee.,      ..,
--       ;tt;:;tt333EE7 ;EEEEEEttttt33#
--      :Et;:;zt333EEQ. $EEEEEttttt33QL
--      it;::;tt333EEF @EEEEEEttttt33F
--     ;3=*^'''"*455V :EEEEEEttttt33@.
--     ,.=:::;!t=., ' @EEEEEEtttz33QF
--    ;;:;:::;;zt33}   "4EEEtttji3P*
--   :t;:::::;;tt33.:Z3z..  '' ,..g.
--   i;::::::;zt33F AEEEtttt;;;;ztF
--  ;;;:::::;;t33V ;EEEttttt;;;;t3
--  E;;;:::;;zt33L @EEEtttt;;;;z3F
-- {3=*^'''"*4E3) ;EEEtttt;;;;;tZ'
--                 "VEEzjt:;z=>*'

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

vim.cmd [[ colorscheme tokyonight ]]
require("plugins.configs.colourschemes").tokyonight()

vim.cmd [[
  function! HandleURL()
    let s:url = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
    echo s:url
    if s:url != ""
      silent exec "!xdg-open '".s:url."'"
    else
      echo "No URL found in line."
    endif
  endfunction

  map <leader>u :call HandleURL()<cr>
]]
