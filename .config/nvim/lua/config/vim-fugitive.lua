local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>gb', ':Git blame<CR>', opts)
map('n', '<leader>gc', ':Git commit<CR>', opts)
map('n', '<leader>gd', ':Gvdiff<CR>', opts)
map('n', '<leader>gps', ':Git push<CR>', opts)
map('n', '<leader>gpu', ':Git pull<CR>', opts)
map('n', '<leader>gr', ':GRemove<CR>', opts)
map('n', '<leader>gs', ':Git<CR>', opts)
map('n', '<leader>gw', ':Gwrite<CR>', opts)
