local cmd = vim.cmd            -- execute Vim commands
local opt = vim.opt
local exec = vim.api.nvim_exec -- execute Vimscript
local fn = vim.fn              -- call Vim functions
local g = vim.g                -- global variables
local o = vim.o                -- global options
local b = vim.bo               -- buffer-scoped options
local w = vim.wo               -- windows-scoped options

-- cmd [[
-- let g:python_host_prog = system('which python2')
-- let g:python3_host_prog = system('which python3')
-- ]]
g.python3_host_prog = '/usr/local/bin/python3'

g.mapleader = ' '

o.updatetime = 200

opt.guifont = { "FiraCode Nerd Font Mono", ":h14" }

-- o.clipboard = 'unnamedplus' -- copy/paste to system clipboard
-- o.clipboard = 'unnamed'

cmd 'packadd justify'
cmd 'packadd shellmenu'
cmd 'packadd swapmouse'
cmd 'packadd vimball'

o.mouse = 'a' -- enable mouse support

o.ttimeout = true
o.ttimeoutlen = 100

o.formatoptions = "q"
o.formatoptions = o.formatoptions .. "j" -- Delete comment character when joining commented lines
o.formatoptions = o.formatoptions .. "r" -- enter extends comments
o.formatoptions = o.formatoptions .. "n" -- format numbered lists using 'formatlistpat'
o.formatoptions = o.formatoptions .. "1" -- don't break after one letter word

-- Show filler lines, to keep the text synchronized with a window that has inserted lines at the same position
cmd [[set diffopt+=filler]]
cmd [[set diffopt+=internal,algorithm:patience]]
cmd [[set diffopt+=indent-heuristic]]
cmd [[set diffopt+=algorithm:histogram]]

----------------------------------------------------------------------------------
-- Encoding
----------------------------------------------------------------------------------
o.binary = true
o.bomb = true
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.fileformats = 'unix,dos,mac'

-- Fix backspace indent
o.backspace = "indent,eol,start" -- make backspace behave in a sane manner

----------------------------------------------------------------------------------
-- Tabs
----------------------------------------------------------------------------------
b.expandtab = true   -- use spaces instead of tabs
b.shiftwidth = 4     -- number of spaces to use for indent and unindent (1 tab == 4 spaces)
b.tabstop = 4        -- the visible width of tabs
b.smartindent = true -- autoindent new lines
b.softtabstop = 4    -- edit as if the tabs are 4 characters wide

-- toggle invisible characters
o.list = true
opt.listchars = { tab = '▸ ', eol = "¬", trail = "⋅", extends = "❯", precedes = "❮" }

-- highlight SpecialKey ctermbg=none " make the highlighting of tabs less annoying
o.showbreak = "↪"
o.breakindent = true
o.breakindentopt = "sbr"

----------------------------------------------------------------------------------
-- UI
----------------------------------------------------------------------------------
o.termguicolors = true -- enable 24-bit RGB colors
-- g.gruvbox_italic = 1
-- g.gruvbox_contrast_dark = "hard"
-- cmd.colorscheme("gruvbox")

o.pumblend = 30

-- opt.numberwidth = 3
-- opt.statuscolumn = '%s%=%l %C%#Yellow#%{v:relnum == 0 ? ">" : ""}%#IndentBlankLineChar#%{v:relnum == 0 ? "" : "│"} '

o.filetype = 'on'
b.autoindent = true -- Copy indent from last line when starting new line
o.background = 'dark'
b.cindent = true
w.cursorline = true              -- highlight current line
o.hidden = true                  -- current buffer can be put into background
-- o.cmdheight = 0
o.laststatus = 2                 -- Status bar always on
o.lazyredraw = true              -- Don't redraw while executing macros (good performance config)
w.number = true                  -- show line number
w.relativenumber = true          -- show relative line numbers
o.ruler = true                   -- Always show current position
w.signcolumn = 'yes'             -- always show signcolumns
o.shortmess = "a"                -- use every short text trick
o.shortmess = o.shortmess .. "O" -- file read message overwrites subsequent
o.shortmess = o.shortmess .. "s" -- no search hit bottom crap
o.shortmess = o.shortmess .. "t" -- truncate file message
o.shortmess = o.shortmess .. "T" -- truncate messages in the middle
o.shortmess = o.shortmess .. "I" -- no intro message
o.shortmess = o.shortmess .. "c" -- no ins-completion messages
o.scrolloff = 3                  -- 3 lines above/below cursor when scrolling

-- Tweak autocompletion behavior for <C-n>/<C-p> in insert mode
-- Default is ".,w,b,u,t,i" without "i", where:
-- . - scan current buffer. Same to invoking <C-x><C-n> individually
-- w - buffers in other windows
-- b - loaded buffers in buffer list
-- u - unloaded buffers in buffer list
-- t - tags. Same to invoking <C-x><C-]> individually
-- i - included files. We don't need this.
-- kspell, when spell check is active, use words from spellfiles
cmd [[set complete-=i]]
cmd [[set complete+=kspell]]

-- set ofu=syntaxcomplete#Complete " Set omni-completion method
-- "set ofu=ale#completion#OmniFunc " Set omni-completion method

o.completeopt = 'longest,menuone' -- completion options
o.showcmd = true                  -- show incomplete commands
w.so = 7                          -- Set 7 lines to the cursor - when moving vertically using j/k
o.t_Co = "256"                    -- Explicitly tell vim that the terminal supports 256 colors
o.title = true
o.titleold = "Terminal"
o.titlestring = '%F'
o.ttyfast = true  -- faster redrawing
o.syntax = 'on'   -- switch syntax highlighting on
b.synmaxcol = 200 -- only syntax highlighting the first 200 characters of each line

----------------------------------------------------------------------------------
-- Wildmenu
----------------------------------------------------------------------------------
o.wildmenu = true                                               -- Turn on the WiLd menu
o.wildmode = "list:longest"                                     -- complete files like a shell
o.wildignore = "*.a,*.o,*.obj,*.exe,*.dll,*.manifest"           -- compiled object files
o.wildignore = o.wildignore .. "*.DS_Store"                     --OSX bullshit
o.wildignore = o.wildignore .. "*.aux,*.out,*.toc"              --LaTeX intermediate files
o.wildignore = o.wildignore .. "*.jpg,*.bmp,*.gif,*.png,*.jpeg" --binary images
o.wildignore = o.wildignore .. "*.luac"                         --Lua byte code
o.wildignore = o.wildignore .. "*.orig,*.rej"                   --Merge resolution files
o.wildignore = o.wildignore .. "*.pdf,*.zip,*.so"               --binaries
o.wildignore = o.wildignore .. "*.pyc,*.pyo"                    --Python byte code
o.wildignore = o.wildignore .. ".hg,.git,.svn"                  --Version Controls"

----------------------------------------------------------------------------------
-- Searching
----------------------------------------------------------------------------------
o.hlsearch = true   -- highlight search results
o.ignorecase = true -- Ignore case when searching
o.inccommand = 'split'
o.incsearch = true  -- Makes search act like search in modern browsers
o.magic = true      -- For regular expressions turn magic on
o.showmatch = true  -- Show matching brackets when text indicator is over them
o.smartcase = true  -- case-sensitive if expresson contains a capital letter

-- Folding
-- o.foldmethod = 'marker'
-- o.foldmethod = 'indent'
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldcolumn = '1'
o.foldenable = true -- fold by default
o.foldlevel = 99
o.foldlevelstart = 99

-- autochange dir
o.autochdir = true

-- error bells
o.errorbells = false
-- set t_vb=
o.tm = 500
o.visualbell = true

-- Directories for swp files
o.wb = false
o.backup = false
b.swapfile = false

-- Disable the vlinking cursor
o.gcr = 'a:blinkon0'
o.scrolloff = 3

-- Use modeline overrides
g.modeline = true
g.modelines = 10

b.autoread = true -- detect when a file is changed
-- set fileformats=unix,dos,mac
o.history = 1000

o.splitright = true -- vertical split to the right
o.splitbelow = true -- horizontal split to the bottom
o.splitkeep = "topline"

-- set spell
o.spell = true
o.spelllang = 'en_us,nl'

-- Use persistent history, Keep undo history across sessions by storing it in a file
cmd [[
if has('persistent_undo')
    let undo_dir = expand('~/.cache/nvim-undo-dir')
    if !isdirectory(undo_dir)
        call mkdir(undo_dir, "p", 0700)
    endif
    set undodir=~/.cache/nvim-undo-dir
    set undofile
endif
]]

-- autocmd
vim.api.nvim_create_augroup('bufcheck', { clear = true })

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group    = 'bufcheck',
  pattern  = { "*.txt", "*.md", "*.tex" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  group    = 'bufcheck',
  pattern  = '*.sh',
  callback = function()
    vim.api.nvim_put({ "#!/bin/bash" }, "", true, true)
    vim.fn.append(1, '')
    vim.fn.cursor(2, 0)
  end
})

-- highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
  group    = 'bufcheck',
  pattern  = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  group    = 'bufcheck',
  pattern  = '*',
  callback = function()
    if fn.line("'\"") > 1 and fn.line("'\"") <= fn.line("$") then
      fn.setpos('.', fn.getpos("'\""))
      cmd('normal zz')
      cmd('silent! foldopen')
    end
  end
})

-- Check if any buffers were changed outside of Vim
vim.api.nvim_create_autocmd({ "CursorHold", "FocusGained", "TermClose", "TermLeave" }, {
  group   = 'bufcheck',
  pattern = '*',
  command = 'silent! checktime'
})

-- relativenumber on current Buf/Win
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, { group = 'bufcheck', pattern = '*', command = 'setlocal nu' })
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, { group = 'bufcheck', pattern = '*', command = 'setlocal rnu' })
vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, { group = 'bufcheck', pattern = '*', command = 'setlocal nornu' })

-- Automatically deletes all trailing whitespace and newlines at end of file
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "%s/\\s\\+$//e" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "%s/\\n\\+\\%$//e" })

-- Automatically formatting on save
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "lua vim.lsp.buf.format()" })

-- -- open all folds in that file
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "FileReadPost" }, { pattern = "*", command = "normal zR" })

-- Redraw screen every time when focus gained
vim.api.nvim_create_autocmd('FocusGained', { pattern = '*', command = 'silent! redraw!' })

-- Set vim to save the file on focus out
vim.api.nvim_create_autocmd('FocusLost', { pattern = '*', command = 'silent! wa' })

-- auto leave paste mode
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'silent! set nopaste' })

-- don't auto commenting new lines
vim.api.nvim_create_autocmd('BufEnter', { pattern = '*', command = 'set fo-=c fo-=r fo-=o' })

-- Make all windows (almost) equally high and wide
vim.api.nvim_create_autocmd('VimResized', { pattern = '*', command = 'wincmd =' })

-- tabs
vim.api.nvim_create_autocmd('FileType',
  {
    pattern = 'xml,html,xhtml,css,scss,javascript,lua,yaml',
    command = 'setlocal expandtab smarttab shiftwidth=2 softtabstop=2 tabstop=2'
  })

-- Open files with external application
vim.api.nvim_create_autocmd('BufEnter',
  {
    pattern = { "*.png", "*.jpg", "*.gif", "*.pdf" },
    command = 'execute "!open ".fnameescape(expand("%")) "&" | bwipeout'
  })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- close the tab/nvim when nvim-tree is the last window.
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end
})
