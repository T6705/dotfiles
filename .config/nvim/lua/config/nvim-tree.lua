local g = vim.g
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.o.termguicolors = true

g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' } -- empty by default, don't auto open tree on specific filetypes.
g.nvim_tree_side = "left"
g.nvim_tree_width = 40 -- 30 by default, can be width_in_columns or 'width_in_percent%'

map('n', '<leader>E', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>R', ':NvimTreeRefresh<CR>', opts)
map('n', '<leader>F', ':NvimTreeFindFile<CR>', opts)
