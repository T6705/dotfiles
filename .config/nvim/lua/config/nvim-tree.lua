local g = vim.g
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.o.termguicolors = true

g.nvim_tree_add_trailing = 1                               -- 0 by default, append a trailing slash to folder names
g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' }   -- empty by default, don't auto open tree on specific filetypes.
g.nvim_tree_git_hl = 1                                     -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_group_empty = 1                                -- 0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_highlight_opened_files = 1                     -- 0 by default, will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_icon_padding = ' '                             -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
g.nvim_tree_indent_markers = 1                             -- 0 by default, this option shows indent markers when folders are open
g.nvim_tree_respect_buf_cwd = 1                            -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
g.nvim_tree_root_folder_modifier = ':~'                    -- This is the default. See :help filename-modifiers for more options
g.nvim_tree_side = "left"
g.nvim_tree_symlink_arrow = ' >> '                         -- defaults to ' ➛ '. used as a separator between symlinks' source and target.
g.nvim_tree_width = 40                                     -- 30 by default, can be width_in_columns or 'width_in_percent%'

map('n', '<leader>E', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>R', ':NvimTreeRefresh<CR>', opts)
map('n', '<leader>F', ':NvimTreeFindFile<CR>', opts)
