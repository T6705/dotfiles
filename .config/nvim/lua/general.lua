local cmd = vim.cmd -- execute Vim commands
local opt = vim.opt
local exec = vim.api.nvim_exec -- execute Vimscript
local fn = vim.fn -- call Vim functions
local g = vim.g -- global variables
local o = vim.o -- global options
local b = vim.bo -- buffer-scoped options
local w = vim.wo -- windows-scoped options

-- cmd [[
-- let g:python_host_prog = system('which python2')
-- let g:python3_host_prog = system('which python3')
-- ]]
g.python3_host_prog = '/usr/local/bin/python3'

g.mapleader = ' '

o.updatetime = 200

-- o.clipboard = 'unnamedplus' -- copy/paste to system clipboard
-- o.clipboard = 'unnamed'

cmd 'packadd justify'
cmd 'packadd shellmenu'
cmd 'packadd swapmouse'
cmd 'packadd vimball'

o.mouse = 'a' -- enable mouse support

o.ttimeout = true
o.ttimeoutlen = 100

cmd [[set formatoptions=q]] -- allow gq to work on comment
cmd [[set formatoptions+=j]] -- Delete comment character when joining commented lines
cmd [[set formatoptions+=r]] -- enter extends comments
cmd [[set formatoptions+=n]] -- format numbered lists using 'formatlistpat'
cmd [[set formatoptions+=1]] -- don't break after one letter word

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
-- set ffs=unix,dos,mac " Use Unix as the standard file type
-- set fileencodings=utf-16le,utf-8,latin1,default,ucs-bom

-- Fix backspace indent
cmd [[set backspace=indent,eol,start]] -- make backspace behave in a sane manner

----------------------------------------------------------------------------------
-- Tabs
----------------------------------------------------------------------------------
b.expandtab = true -- use spaces instead of tabs
b.shiftwidth = 4 -- number of spaces to use for indent and unindent (1 tab == 4 spaces)
b.tabstop = 4 -- the visible width of tabs
b.smartindent = true -- autoindent new lines
b.softtabstop = 4 -- edit as if the tabs are 4 characters wide

-- toggle invisible characters
o.list = true
-- vim.opt.listchars:append("eol:¬")
-- vim.opt.listchars:append("trail:⋅")
cmd [[set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮]]
-- highlight SpecialKey ctermbg=none " make the highlighting of tabs less annoying
o.showbreak = "↪"
o.breakindent = true
o.breakindentopt = "sbr"

----------------------------------------------------------------------------------
-- UI
----------------------------------------------------------------------------------
o.termguicolors = true -- enable 24-bit RGB colors
g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
cmd [[colorscheme catppuccin]]
-- g.gruvbox_italic = 1
-- g.gruvbox_contrast_dark = "hard"
-- cmd([[colorscheme gruvbox]])

o.pumblend = 30

-- "filetype on
-- filetype indent on    " load filetype-specific indent files
-- filetype plugin on
o.filetype = 'on'
b.autoindent = true -- Copy indent from last line when starting new line
o.background = 'dark'
b.cindent = true
w.cursorline = true -- highlight current line
-- set display+=lastline
o.hidden = true -- current buffer can be put into background

o.laststatus = 2 -- Status bar always on
o.lazyredraw = true -- Don't redraw while executing macros (good performance config)
w.number = true -- show line number
w.relativenumber = true -- show relative line numbers
o.ruler = true -- Always show current position
w.signcolumn = 'yes' -- always show signcolumns
cmd [[set shortmess=a]] -- use every short text trick
cmd [[set shortmess+=O]] -- file read message overwrites subsequent
cmd [[set shortmess+=s]] -- no search hit bottom crap
cmd [[set shortmess+=t]] -- truncate file message
cmd [[set shortmess+=T]] -- truncate messages in the middle
cmd [[set shortmess+=I]] -- no intro message
cmd [[set shortmess+=c]] -- no ins-completion messages
-- if !&scrolloff
--     set scrolloff=3   " 3 lines above/below cursor when scrolling
-- endif
-- if !&sidescrolloff
--     set sidescrolloff=5
-- endif

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
o.showcmd = true -- show incomplete commands
w.so = 7 -- Set 7 lines to the cursor - when moving vertically using j/k
w.t_Co = "256" -- Explicitly tell vim that the terminal supports 256 colors
o.title = true
o.titleold = "Terminal"
o.titlestring = '%F'
o.ttyfast = true -- faster redrawing
o.syntax = 'on' -- switch syntax highlighting on
b.synmaxcol = 1024 -- only syntax highlighting the first 200 characters of each line

----------------------------------------------------------------------------------
-- Wildmenu
----------------------------------------------------------------------------------
cmd [[
set wildmenu                                        " Turn on the WiLd menu
set wildmode=list:longest                           " complete files like a shell
set wildignore=*.a,*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.DS_Store                          " OSX bullshit
set wildignore+=*.aux,*.out,*.toc                   " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg      " binary images
set wildignore+=*.luac                              " Lua byte code
set wildignore+=*.orig,*.rej                        " Merge resolution files
set wildignore+=*.pdf,*.zip,*.so                    " binaries
set wildignore+=*.pyc,*.pyo                         " Python byte code
set wildignore+=.hg,.git,.svn                       " Version Controls"
]]

----------------------------------------------------------------------------------
-- Searching
----------------------------------------------------------------------------------
o.hlsearch = true -- highlight search results
o.ignorecase = true -- Ignore case when searching
o.inccommand = 'split'
o.incsearch = true -- Makes search act like search in modern browsers
o.magic = true -- For regular expressions turn magic on
o.showmatch = true -- Show matching brackets when text indicator is over them
o.smartcase = true -- case-sensitive if expresson contains a capital letter

-- Folding
-- w.foldmethod = 'marker'
-- w.foldmethod = 'indent'
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- set foldlevel=99
w.foldenable = false -- don't fold by default
-- set foldtext=CustomFold()

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
-- if has('vim_starting')
--     set nocompatible         " not compatible with vi
-- endif
-- set path+=**

-- ctags
-- set tags=./tags;/

o.splitright = true -- vertical split to the right
o.splitbelow = true -- orizontal split to the bottom

-- "set spell
-- set spelllang=en_us,nl

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
  callback = function() vim.highlight.on_yank { timeout = 500 } end
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
vim.api.nvim_create_autocmd('CursorHold', {
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
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    -- cmd("%!isort -")
    cmd("Black")
  end
})

-- open all folds in that file
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, { pattern = "*", command = "normal zR" })

-- Redraw screen every time when focus gained
vim.api.nvim_create_autocmd('FocusGained', { pattern = '*', command = 'silent! redraw!' })

-- Set vim to save the file on focus out
vim.api.nvim_create_autocmd('FocusLost', { pattern = '*', command = 'silent! wa' })

-- auto leave paste mode
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'silent! set nopaste' })

-- shows a lightbulb in the sign column whenever a textDocument/codeAction is available at the current cursor position.
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  callback = function()
    require 'nvim-lightbulb'.update_lightbulb()
  end
})

-- don't auto commenting new lines
vim.api.nvim_create_autocmd('BufEnter', { pattern = '*', command = 'set fo-=c fo-=r fo-=o' })

-- Make all windows (almost) equally high and wide
vim.api.nvim_create_autocmd('VimResized', { pattern = '*', command = 'wincmd =' })

-- tabs
vim.api.nvim_create_autocmd('FileType',
  { pattern = 'xml,html,xhtml,css,scss,javascript,lua,yaml',
    command = 'setlocal expandtab smarttab shiftwidth=2 softtabstop=2 tabstop=2' })
