local cmd = vim.cmd -- execute Vim commands
local opt = vim.opt
local fn = vim.fn   -- call Vim functions
local g = vim.g     -- global variables
local o = vim.o     -- global options
local b = vim.bo    -- buffer-scoped options
local w = vim.wo    -- windows-scoped options

-- cmd [[
-- let g:python_host_prog = system('which python2')
-- let g:python3_host_prog = system('which python3')
-- ]]
g.python3_host_prog = '/usr/local/bin/python3'

g.mapleader = ' '

opt.updatetime = 200

opt.guifont = { "FiraCode Nerd Font Mono", ":h14" }

-- opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
-- opt.clipboard = 'unnamed'

cmd 'packadd justify'
cmd 'packadd shellmenu'
cmd 'packadd swapmouse'
cmd 'packadd vimball'

opt.mouse = 'a' -- enable mouse support

opt.ttimeout = true
opt.ttimeoutlen = 100

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
opt.binary = true
opt.bomb = true
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.fileformats = 'unix,dos,mac'

-- Fix backspace indent
opt.backspace = "indent,eol,start" -- make backspace behave in a sane manner

----------------------------------------------------------------------------------
-- Tabs
----------------------------------------------------------------------------------
b.expandtab = true   -- use spaces instead of tabs
b.shiftwidth = 4     -- number of spaces to use for indent and unindent (1 tab == 4 spaces)
b.tabstop = 4        -- the visible width of tabs
b.smartindent = true -- autoindent new lines
b.softtabstop = 4    -- edit as if the tabs are 4 characters wide

-- toggle invisible characters
opt.list = true
opt.listchars = { tab = '▸ ', eol = "¬", trail = "⋅", extends = "❯", precedes = "❮" }

-- highlight SpecialKey ctermbg=none " make the highlighting of tabs less annoying
opt.showbreak = "↪"
opt.breakindent = true
opt.breakindentopt = "sbr"

----------------------------------------------------------------------------------
-- UI
----------------------------------------------------------------------------------
opt.termguicolors = true -- enable 24-bit RGB colors
-- g.gruvbox_italic = 1
-- g.gruvbox_contrast_dark = "hard"
-- cmd.colorscheme("gruvbox")

opt.pumblend = 30

-- opt.numberwidth = 3
-- opt.statuscolumn = '%s%=%l %C%#Yellow#%{v:relnum == 0 ? ">" : ""}%#IndentBlankLineChar#%{v:relnum == 0 ? "" : "│"} '

opt.filetype = 'on'
b.autoindent = true -- Copy indent from last line when starting new line
opt.background = 'dark'
b.cindent = true
w.cursorline = true                  -- highlight current line
opt.hidden = true                    -- current buffer can be put into background
-- opt.cmdheight = 0
opt.laststatus = 2                   -- Status bar always on
opt.lazyredraw = true                -- Don't redraw while executing macros (good performance config)
w.number = true                      -- show line number
w.relativenumber = true              -- show relative line numbers
opt.ruler = true                     -- Always show current position
w.signcolumn = 'yes'                 -- always show signcolumns
o.shortmess = "a"                    -- use every short text trick
o.shortmess = o.shortmess .. "O"     -- file read message overwrites subsequent
o.shortmess = o.shortmess .. "s"     -- no search hit bottom crap
o.shortmess = o.shortmess .. "t"     -- truncate file message
o.shortmess = o.shortmess .. "T"     -- truncate messages in the middle
o.shortmess = o.shortmess .. "I"     -- no intro message
o.shortmess = o.shortmess .. "c"     -- no ins-completion messages
o.mopt = "wait:1000,history:5000"    --  Goodbye to the "press enter" in messages
vim.g.markdown_recommended_stype = 0 -- fix markdown indentation settings
opt.scrolloff = 3                    -- 3 lines above/below cursor when scrolling
if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

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

opt.completeopt = 'longest,menuone' -- completion options
opt.showcmd = true                  -- show incomplete commands
w.so = 7                            -- Set 7 lines to the cursor - when moving vertically using j/k
opt.title = true
opt.titleold = "Terminal"
opt.titlestring = '%F'
opt.ttyfast = true -- faster redrawing
opt.syntax = 'on'  -- switch syntax highlighting on
b.synmaxcol = 200  -- only syntax highlighting the first 200 characters of each line

----------------------------------------------------------------------------------
-- Wildmenu
----------------------------------------------------------------------------------
opt.wildmenu = true                                             -- Turn on the WiLd menu
opt.wildmode = "list:longest"                                   -- complete files like a shell
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
opt.hlsearch = true   -- highlight search results
opt.ignorecase = true -- Ignore case when searching
opt.inccommand = 'split'
opt.incsearch = true  -- Makes search act like search in modern browsers
opt.magic = true      -- For regular expressions turn magic on
opt.showmatch = true  -- Show matching brackets when text indicator is over them
opt.smartcase = true  -- case-sensitive if expresson contains a capital letter

-- Folding
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true -- fold by default
opt.foldmethod = 'indent'

-- error bells
opt.errorbells = false
-- set t_vb=
opt.tm = 500
opt.visualbell = true

-- Directories for swp files
opt.wb = false
opt.backup = false
b.swapfile = false

-- Disable the vlinking cursor
opt.gcr = 'a:blinkon0'
opt.scrolloff = 3

-- Use modeline overrides
g.modeline = true
g.modelines = 10

opt.autochdir = true
opt.autowrite = true
b.autoread = true -- detect when a file is changed
opt.history = 1000

opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- horizontal split to the bottom
opt.splitkeep = "topline"

-- set spell
opt.spell = true
opt.spelllang = 'en_us,nl'

-- Use persistent history, Keep undo history across sessions by storing it in a file
-- cmd [[
-- if has('persistent_undo')
--     let undo_dir = expand('~/.cache/nvim-undo-dir')
--     if !isdirectory(undo_dir)
--         call mkdir(undo_dir, "p", 0700)
--     endif
--     set undodir=~/.cache/nvim-undo-dir
--     set undofile
-- endif
-- ]]
if vim.fn.has('persistent_undo') == 1 then
  local undo_dir = vim.fn.expand('~/.cache/nvim-undo-dir/')

  if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p")
  end

  if vim.fn.getfperm(undo_dir) ~= "rwx------" then
    vim.fn.setfperm(undo_dir, "rwx------")
  end

  opt.undodir = undo_dir
  opt.undofile = true
end

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
vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "FileReadPost" }, { pattern = "*", command = "normal zR" })

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

vim.api.nvim_create_autocmd('InsertEnter', { pattern = '*', command = 'normal zz' })

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

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*.txt", "*.tex", "*.typ", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- https://github.com/folke/snacks.nvim/blob/main/docs/rename.md
vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    if event.data.actions.type == "move" then
      Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
    end
  end,
})

-- -- close the tab/nvim when nvim-tree is the last window.
-- vim.api.nvim_create_autocmd("BufEnter", {
--   nested = true,
--   callback = function()
--     if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
--       vim.cmd "quit"
--     end
--   end
-- })


-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports-and-formatting
-- Use the following configuration to have your imports organized on save using the logic of goimports and your code formatted.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end
})
