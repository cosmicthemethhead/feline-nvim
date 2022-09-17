local present, devicons= pcall(require, "nvim-web-devicons")
if not present then
  vim.notify("failed to load: devicons", "error", {
    title = "plugins.config.devicons",
  })
  return
end

local colours = {
  yellow = "#FFE9A0",
  purple = "#87A2FB",
  pink = "#FFC4C4"
}
local prefabs = {
  img = {
    icon = '',
    colour = colours.pink,
  }
}

local bin = ''

devicons.set_icon {
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
  ["LICENSE"] = { icon = '' },
  ["md"]      = { icon = '' },

  ["bin"]     = { icon = bin },

  -- java/type script
  ["js"] = {
    icon = '',
    color = colours.yellow,
    name = "js"
  },
  ["ts"] = {
    icon = 'ﯤ',
    color = colours.purple,
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
