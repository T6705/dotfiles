local cmd = vim.cmd -- execute Vim commands
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- :W (sudo saves the file)
-- (useful for handling the permission-denied error)
-- command! W w !sudo tee % > /dev/null

-- :J (json prettify)
-- command! J :%!python -m json.tool

-- sort words on the same line
-- command! Sortw :call setline(line('.'),join(sort(split(getline('.'))), ' '))

-- sort folds
-- command! SortF :call sortfolds#SortFolds()

-- command! PU PlugUpdate | PlugUpgrade

--------------------------------------------------------------------------------
-- Copy and Paste
--------------------------------------------------------------------------------
-- Make `Y` behave like `C` and `D`
map('n', 'Y', 'y$', opts)

-- change word under cursor and dot repeat
map('n', 'c*', '*Ncgn', opts)
map('n', 'c#', '#NcgN', opts)

-- native multi-cursor in vim
map('n', 'cn', '*``cgn', opts)
map('n', 'cN', '*``cgN', opts)

map('n', '<leader>p', '"+gP', opts)
map('n', '<leader>x', '"+x', opts)
map('n', '<leader>y', 'mm:Osc52CopyYank<CR>`m:delmarks m<CR>zz', opts)
map('v', '<leader>x', '"+x', opts)
map('v', '<leader>y', '"+y', opts)

-- cursor does not jump back to where you started the selection.
map("v", "y", "ygv<esc>", opts)

-- select the current line without indentation
map('n', 'vv', '^vg_', opts)

local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end

-- It solves the issue, where you want to delete empty line, but dd will override you last yank. Code above will check if u are deleting empty line, if so - use black hole register.
map("n", "dd", smart_dd, { noremap = true, expr = true })

-- No arrow keys in insert mode
-- ino <down> <Nop>
-- ino <left> <Nop>
-- ino <right> <Nop>
-- ino <up> <Nop>

-- Map arrow keys to window resize commands.
map('n', '<Right>', '2<C-W>>', opts)
map('n', '<Left>', '2<C-W><', opts)
map('n', '<Up>', '2<C-W>+', opts)
map('n', '<Down>', '2<C-W>-', opts)

-- moving up and down work as you would expect
-- map('n', '0', 'g0', opts)
-- map('n', '^', 'g^', opts)
-- map('n', 'j', 'gj', opts)
-- map('n', 'k', 'gk', opts)
-- map('v', '0', 'g0', opts)
-- map('v', '^', 'g^', opts)
map("n", "j", "v:count ? 'j' : 'gj'", { noremap = true, expr = true })
map("n", "k", "v:count ? 'k' : 'gk'", { noremap = true, expr = true })
map('n', '$', 'g$', opts)
map('v', 'j', 'gj', opts)
map('v', 'k', 'gk', opts)
map('v', '$', 'g$', opts)

-- move to beginning/end of line
map('n', 'H', 'g^', opts)
map('n', 'L', 'g$', opts)
map('v', 'H', 'g^', opts)
map('v', 'L', 'g$', opts)

-- map('n', 'N', 'Nzzzv', opts)
-- map('n', 'n', 'nzzzv', opts)
-- map('n', '[[', '[[zz', opts)
-- map('n', '[]', '[]zz', opts)
-- map('n', '][', '][zz', opts)
-- map('n', ']]', ']]zz', opts)
map('n', 'gg', ':norm! ggzz<CR>', opts)
map('n', 'G', ':norm! Gzz<CR>', opts)
map('n', 'g=', 'mmgg=G`m', opts)
map('n', 'gQ', 'mmgggqG`m', opts)
map('n', '{', '{zz', opts)
map('n', '}', '}zz', opts)

-- Jump to matching pairs easily, with Shift-Tab
-- map('n', '<S-Tab>', '%', {})
-- map('v', '<S-Tab>', '%', {})

-- Keep the cursor in place while joining lines
map('n', 'J', 'mzJ`z', opts)

-- Vmap for maintain Visual Mode after shifting > and <
map('x', '<', '<gv', opts)
map('x', '>', '>gv', opts)

-- Move visual block
-- map('x', 'J', ":m '>+1<CR>gv=gvzz", opts)
-- map('x', 'K', ":m '<-2<CR>gv=gvzz", opts)
map("x", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
map("x", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

-- Scrolling
map('n', '<C-j>', '2<C-e>', opts)
map('n', '<C-k>', '2<C-y>', opts)
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)

--inoremap <F8> <Esc>:Hexmode<CR>
--noremap <F8> :Hexmode<CR>

-- qq to record, Q to replay (recursive noremap due to peekaboo)
map('n', 'Q', '@q', opts)
--xnoremap Q :'<,'>:normal @q<CR>

-- Switch to the directory of opened buffer
map('n', '<leader>cd', ':lcd %:p:h<CR>:pwd<CR>', opts)

-- Change current word to uppercase
map('n', '<leader>u', 'gUiw', opts)

-- Change current word to lowercase
map('n', '<leader>l', 'guiw', opts)

-- clear highlighted search
map('n', '<leader>sc', ':set hlsearch! hlsearch?<CR>', opts)

-- Press <leader>bg in order to toggle light/dark background
--map <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

-- automatically insert a \v before any search string, so search uses normal regexes
--map('n', '/', '/\v', opts)
--vnoremap / /\v
--map('n', '?', '?\v', otps)
--vnoremap ? ?\v

-- search for word under the cursor
map('n', '<leader>/', '"fyiw :/<C-r>f<CR>', opts)

-- window navigation
--map('n', '<leader>wh :call functions#WinMove('h')<CR>
--map('n', '<leader>wj :call functions#WinMove('j')<CR>
--map('n', '<leader>wk :call functions#WinMove('k')<CR>
--map('n', '<leader>wl :call functions#WinMove('l')<CR>
map('n', '<leader>wh', '<C-W>h', opts)
map('n', '<leader>wj', '<C-W>j', opts)
map('n', '<leader>wk', '<C-W>k', opts)
map('n', '<leader>wl', '<C-W>l', opts)
map('n', '<leader>wx', '<C-W>x', opts)
map('n', '<leader>wH', '<C-W>H', opts)
map('n', '<leader>wJ', '<C-W>J', opts)
map('n', '<leader>wK', '<C-W>K', opts)
map('n', '<leader>wL', '<C-W>L', opts)
-- Make splits the same width
map('n', '<leader>we', '<C-w>=', opts)
map('n', '<leader>wz', ':wincmd _ |wincmd | | normal 0 <CR>', opts)

-- quickfix
--let g:quickfix_height = 50
map('n', '<leader>lc', ':lclose<CR>', opts)
map('n', '<leader>lo', ':lopen<CR>', opts)
map('n', '<leader>lw', ':lwindow<CR>', opts)
map('n', '[L', ':lfirst<CR>zz', opts)
map('n', '[l', ':lprev<CR>zz', opts)
map('n', ']L', ':llast<CR>zz', opts)
map('n', ']l', ':lnext<CR>zz', opts)

map('n', '<leader>qc', ':cclose<CR>', opts)
map('n', '<leader>qo', ':copen<CR>', opts)
map('n', '<leader>qw', ':cwindow<CR>', opts)
map('n', '[Q', ':cfirst<CR>zz', opts)
map('n', '[q', ':cprev<CR>zz', opts)
map('n', ']Q', ':clast<CR>zz', opts)
map('n', ']q', ':cnext<CR>zz', opts)

-- Tabs
map('n', ']t', 'gt', opts)
map('n', '[t', 'gT', opts)
map('n', '<leader>tn', ':tabnew<CR>', opts)

-- Buffer nav
-- map('n', '[b', ':bp<CR>', opts)
-- map('n', ']b', ':bn<CR>', opts)
map('n', '<leader>q', ':bd!<CR>', opts)
map('n', '<leader>bn', ':enew<CR>', opts)
-- map('n', '<bs>', '<C-^>', opts)

-- Completetion
-- cmd [[
-- inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<CR>" : "\<CR>")
--
-- " Use <Tab> and <S-Tab> for navigate completion list:
-- inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
--
-- " Use <enter> to confirm complete
-- inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
--
-- inoremap ,, <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ",,"<CR>
--
-- " file names
-- inoremap ,f <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",f"<CR>
--
-- " line
-- inoremap ,l <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",l"<CR>
--
-- " keyword from current file
-- inoremap ,w <C-x><C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",w"<CR>
--
-- " omni completion
-- inoremap ,o <C-x><C-o><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",o"<CR>
-- ]]

-- folding
map('n', '<leader>f', 'za<CR>', opts)
map('v', '<leader>f', 'za<CR>', opts)

-- Make the dot command work as expected in visual mode (via
-- https://www.reddit.com/r/vim/comments/3y2mgt/do_you_have_any_minor_customizationsmappings_that/cya0x04)
map('v', '.', ':norm.<CR>', opts)

-- Markdown headings
map('n', '<leader>1', 'm`yypVr=``', opts)
map('n', '<leader>2', 'm`yypVr-``', opts)
map('n', '<leader>3', 'm`^i### <Esc>``4l', opts)
map('n', '<leader>4', 'm`^i#### <Esc>``5l', opts)
map('n', '<leader>5', 'm`^i##### <Esc>``6l', opts)

-- Recompute syntax highlighting
map('n', '<leader>ss', ':syntax sync fromstart<CR>', opts)

---------------------------------------------------------------------------------
-- prettier
---------------------------------------------------------------------------------
map('n', '<leader>pt',
  'mm:silent %!prettier --stdin-filepath % --trailing-comma all --single-quote<CR>`m:delmarks m<CR>zz', opts)
map('n', '<leader>pta',
  'mm:bufdo silent %!prettier --stdin-filepath % --trailing-comma all --single-quote<CR>`m:delmarks m<CR>zz', opts)

---------------------------------------------------------------------------------
-- tpope/vim-surround
---------------------------------------------------------------------------------
map('n', '<leader>`', 'ysiw`', { noremap = false, silent = true })
map('n', '<leader>"', 'ysiw"', { noremap = false, silent = true })
map('n', "<leader>'", "ysiw'", { noremap = false, silent = true })
map('n', '<leader>(', 'ysiw(', { noremap = false, silent = true })
map('n', '<leader>)', 'ysiw)', { noremap = false, silent = true })
map('n', '<leader>]', 'ysiw]', { noremap = false, silent = true })
map('n', '<leader>[', 'ysiw[', { noremap = false, silent = true })
map('n', '<leader>}', 'ysiw}', { noremap = false, silent = true })
map('n', '<leader>{', 'ysiw{', { noremap = false, silent = true })

-- map("n", "<cr>", "ciw", opts)
