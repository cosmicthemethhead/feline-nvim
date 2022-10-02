local overides = { }

local telescope = function(prompt_title_fg, prompt_title_bg, prompt_bg, results_bg, preview_bg)
  vim.cmd(string.format(
    [[
      hi TelescopePromptTitle   guifg=%s guibg=%s
      hi TelescopePromptBorder  guifg=%s guibg=%s
      hi TelescopePromptPrefix  guifg=%s guibg=%s
      hi TelescopePromptNormal  guibg=%s

      hi TelescopeResultsTitle  guifg=%s guibg=%s
      hi TelescopeResultsBorder guifg=%s guibg=%s
      hi TelescopeResultsNormal guifg=#CAD3F5 guibg=%s

      hi TelescopePreviewTitle  guifg=%s guibg=%s
      hi TelescopePreviewBorder guifg=%s guibg=%s
      hi TelescopePreviewNormal guibg=%s
    ]],

    prompt_title_fg, prompt_title_bg,
    prompt_bg, prompt_bg,
    prompt_title_bg, prompt_bg,
    prompt_bg,

    results_bg, results_bg,
    results_bg, results_bg,
    results_bg,

    preview_bg, preview_bg,
    preview_bg, preview_bg,
    preview_bg
  ))
end

overides.tokyonight = function()
  vim.cmd [[
  try
    colorscheme tokyonight
  catch
    colorscheme slate
    echo "WARNING: tokyonight not found"
  ]]

  telescope("#6e152e", "#e072a8", "#202333", "#1a1c2b", "#171926")
end

return overides
