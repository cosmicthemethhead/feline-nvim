local present, bufferline = pcall(require, "bufferline")
if not present then
  vim.notify("failed to load: bufferline", "error", {
    title = "plugins.configs.bufferline",
  })
  return
end

bufferline.setup {
  options = {
    right_mouse_command  = nil,
    left_mouse_command   = nil,
    middle_mouse_command = nil,
    left_trunc_marker  = '…',
    right_trunc_marker = '…',
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 18,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return '('..count..')'
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = " neo-vim",
        text_align = "center",
        separator = false,
        padding = 1
      }
    },

    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    enforce_regular_tabs = false,
    always_show_bufferline = false,
  }
}

require('bufferline.groups').builtin.pinned:with({ icon = "" })
