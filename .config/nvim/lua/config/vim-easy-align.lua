local map = vim.api.nvim_set_keymap
local opts = { silent = true }

map('n', 'ga', '<Plug>(EasyAlign)', opts)
map('x', 'ga', '<Plug>(EasyAlign)', opts)
