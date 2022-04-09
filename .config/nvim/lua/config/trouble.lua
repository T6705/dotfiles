local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opts)
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", opts)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
map("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)
