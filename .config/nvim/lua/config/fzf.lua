local g = vim.g
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

g.fzf_buffers_jump        = 1                                                                        -- [Buffers] Jump to the existing window if possible
g.fzf_commands_expect     = 'alt-enter,ctrl-x'                                                       -- [Commands] --expect expression for directly executing the command
g.fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"' -- [[B]Commits] Customize the options used by 'git log':
g.fzf_preview_window      = {'right:50%', 'ctrl-/'}
g.fzf_tags_command        = 'ctags -R --exclude=@.gitignore --exclude=.mypy_cache'                   -- [Tags] Command to generate tags file

-- map('n', '<leader>e', ':Files<CR>', opts)
-- map('n', '<leader>ws', ':Windows<CR>', opts)
-- map('n', '<leader>ms', ':Marks<CR>', opts)
-- map('n', '<leader>ts', ':Tags<CR>', opts)
-- map('n', '<leader>bs', ':Buffers<CR>', opts)
map('n', '<leader>bls', ':Lines<CR>', opts)
