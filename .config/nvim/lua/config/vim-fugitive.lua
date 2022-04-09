local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>gb', ':Gblame<CR>', opts)
map('n', '<leader>gc', ':Gcommit<CR>', opts)
map('n', '<leader>gd', ':Gvdiff<CR>', opts)
map('n', '<leader>gps', ':Gpush<CR>', opts)
map('n', '<leader>gpu', ':Gpull<CR>', opts)
map('n', '<leader>gr', ':Gremove<CR>', opts)
map('n', '<leader>gs', ':Gstatus<CR>', opts)
map('n', '<leader>gw', ':Gwrite<CR>', opts)
