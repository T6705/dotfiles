require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim'
    }
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg" -- find command (defaults to `fd`)
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('media_files')

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<leader>bf', ':Telescope buffers<CR>', opts)
map('n', '<leader>ms', ':Telescope marks<CR>', opts)
map('n', '<leader>rg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>ts', ':Telescope tags<CR>', opts)
map('n', '<leader>bs', "<cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>", opts)
map('n', '<leader>e', "<cmd>lua require('telescope.builtin').find_files({hidden=true})<CR>", opts)
map('n', '<leader>i', ':Telescope lsp_implementation<CR>', opts)
map('n', '<leader>r', ':Telescope lsp_references<CR>', opts)
map('n', '<leader>ca', ':Telescope lsp_code_actions<CR>', opts)
