local present, devicons= pcall(require, "nvim-web-devicons")
if not present then
  vim.notify("failed to load: devicons", "error", {
    title = "plugins.configs.devicons",
  })
  return
end

local colours = {
  yellow = "#FFE9A0",
  blue   = "#87A2FB",
  pink   = "#FFC4C4"
}
local prefabs = {
  img = {
    icon = '',
    colour = colours.pink,
  },
  executable = {
    icon = '',
  }
}

local opts =  {
  -- image
  ["ico"] = {
    icon = prefabs.img.icon,
    color = prefabs.img.colour,
    name = "ico"
  },
  ["png"] = {
    icon = prefabs.img.icon,
    color = prefabs.img.colour,
    name = "png"
  },
  ["jpg"] = {
    icon = prefabs.img.icon,
    color = prefabs.img.colour,
    name = "jpg"
  },

  -- github
  [".gitignore"] = {
    icon = '',
    color = colours.pink,
    name = ".gitignore",
  },
  ["LICENSE"] = {
    icon = '',
    color = colours.yellow,
    name = "LICENSE",
  },
  ["md"] = { icon = '' },

  ["out"] = prefabs.executable;

  ["lua"] = {
    icon = '',
    color = colours.blue,
    name = "lua",
  },

  -- java/type script
  ["js"] = {
    icon = '',
    color = colours.yellow,
    name = "js"
  },
  ["ts"] = {
    icon = 'ﯤ',
    color = colours.blue,
    name = "ts"
  },

  -- web misc
  ["html"] = {
    icon = '',
    color = "#FF7878",
    name = "html",
  },
  ["css"] = {
    icon = '',
    color = "#B1B2FF",
    name = "css",
  },
}

opts = require("core.utils").load_override(opts, "lukas-reineke/indent-blankline.nvim")
devicons.set_icon(opts)
