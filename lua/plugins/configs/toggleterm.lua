local present, toggleterm = pcall(require, "toggleterm")
if not present then
  vim.notify("failed to load: toggleterm", "error", {
    title = "toggleterm",
  })
  return
end

toggleterm.setup {
  size = 20,
  open_mapping = [[<C-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
}

function _G.set_terminal_keymaps()
  local opts = {noremap = true}

  -- vim.api.nvim_buf_set_keymap(0, "t", "<ESC>", [[<C-\><C-n>]],       opts)
  vim.api.nvim_buf_set_keymap(0, "t", "jk",    [[<C-\><C-n>]],       opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
