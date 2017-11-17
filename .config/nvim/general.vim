" vim:foldmethod=marker:foldlevel=0

""" === General Setting === {{{

if executable('python2')
    let g:python_host_prog = '/usr/bin/python2'
endif
if executable('python3')
    let g:python3_host_prog = '/usr/bin/python3'
endif

let mapleader=' '

let php_sql_query = 1
let php_htmlInStrings = 1

set updatetime=500

"cnoreabbrev W w
"cnoreabbrev W! w!
"cnoreabbrev Wa wa
"cnoreabbrev Wq wq
cnoreabbrev WQ Wq
cnoreabbrev wQ wq
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Q q
cnoreabbrev Qall qall

"if has('unnamedplus')
"    " x,y,p using system clipboard(* and +)
"    set clipboard=unnamed,unnamedplus
"endif
"set clipboard=unnamed

if has('nvim')
    packadd vimball
endif

if has('patch-7.4.1480')
    packadd justify
    packadd shellmenu
    packadd swapmouse
endif

if has('mouse')
    set mouse=a
endif

if !has('nvim') && &ttimeoutlen == -1
    set ttimeout
    set ttimeoutlen=100
endif

if v:version > 703 || v:version == 703 && has("patch-7.3.541")
    set formatoptions+=j " Delete comment character when joining commented lines
endif

if !has('nvim') && v:version > 704 || (v:version == 704 && has('patch401'))
    setlocal cryptmethod=blowfish2  " medium strong method
endif

" ----------------------------------------------------------------------------------------
" Encoding
" ----------------------------------------------------------------------------------------
set binary
set bomb
if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8 " Set utf8 as standard encoding and en_US as the standard language
endif
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
set fileencoding=utf-8
set fileencodings=utf-16le,utf-8,latin1,default,ucs-bom
set ffs=unix,dos,mac " Use Unix as the standard file type

" Fix backspace indent
set backspace=indent,eol,start " make backspace behave in a sane manner

" ----------------------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------------------
"set completeopt+=longest
"set noexpandtab   " insert tabs rather than spaces for <TAB>
"set shiftround    " round indent to a multiple of 'shiftwidth'
set expandtab     " Use spaces instead of tabs
set shiftwidth=4  " number of spaces to use for indent and unindent (1 tab == 4 spaces)
set smarttab      " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set softtabstop=4 " edit as if the tabs are 4 characters wide
set tabstop=4     " the visible width of tabs

" toggle invisible characters
set invlist
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
highlight SpecialKey ctermbg=none " make the highlighting of tabs less annoying
if has('patch-7.4.338')
    "let &showbreak = '↳ '
    set showbreak=↪
    set breakindent
    set breakindentopt=sbr
endif
nmap <Leader>l :set list!<CR>

" ----------------------------------------------------------------------------------------
" UI
" ----------------------------------------------------------------------------------------
colorscheme molokai
"filetype on
filetype indent on                                                " load filetype-specific indent files
filetype plugin on
set autoindent
set background=dark
set cindent
set cursorline                                                    " highlight current line
set display+=lastline
set hidden                                                        " current buffer can be put into background
set laststatus=2                                                  " Status bar always on
set lazyredraw                                                    " Don't redraw while executing macros (good performance config)
set number                                                        " show line numbers
"set relativenumber                                               " show relative line numbers
set ruler                                                         " Always show current position

if !&scrolloff
    set scrolloff=3                                                 " 3 lines above/below cursor when scrolling
endif
if !&sidescrolloff
    set sidescrolloff=5
endif

set showcmd                                                       " show incomplete commands
set so=7                                                          " Set 7 lines to the cursor - when moving vertically using j/k
set t_Co=256                                                      " Explicitly tell vim that the terminal supports 256 colors
set title
set titleold="Terminal"
set titlestring=%F
set ttyfast                                                       " faster redrawing
if has('syntax') && !exists('g:syntax_on')
    "syntax enable
    syntax on                                                         " switch syntax highlighting on
endif

" Set font according to system
if has("mac") || has("macunix")
    set gfn=Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=Hack:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" ----------------------------------------------------------------------------------------
" statusline
" ----------------------------------------------------------------------------------------
" tpope's
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P

""" === basic statusline === {{{
"set statusline=
"set statusline+=%0*\ [%n]                            " buffernr
"set statusline+=%0*\ %<%F\                           " File+path
"set statusline+=%1*\ %y\                             " FileType
"set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''} " Encoding
"set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\       " Encoding2
"set statusline+=%4*\ %{&ff}\                         " FileFormat (dos/unix..)
"set statusline+=%5*\ %=\ row:%l/%L\        " Rownumber/total (%)
"set statusline+=%6*\ col:%03c\                       " Colnr
"set statusline+=%0*\ \ %m%r%w\ %P\ \                 " Modified? Readonly? Top/bot.

"hi User1 ctermfg=red ctermbg=black
"hi User2 ctermfg=blue ctermbg=black
"hi User3 ctermfg=green ctermbg=black
"hi User4 ctermfg=yellow ctermbg=black
"hi User5 ctermfg=cyan ctermbg=black
"hi User6 ctermfg=magenta ctermbg=black
""" }}}

""" === advance statusline === {{{
"let g:currentmode={ 'n'  : 'Normal ', 'no' : 'N-Operator Pending ', 'v'  : 'Visual ', 'V'  : 'V-Line ', '' : 'V-Block ', 's'  : 'Select ', 'S'  : 'S-Line ', '^S' : 'S-Block ', 'i'  : 'Insert ', 'R'  : 'Replace ', 'Rv' : 'V-Replace ', 'c'  : 'Command ', 'cv' : 'Vim Ex ', 'ce' : 'Ex ', 'r'  : 'Prompt ', 'rm' : 'More ', 'r?' : 'Confirm ', '!'  : 'Shell ', 't'  : 'Terminal ' }

"" Automatically change the statusline color depending on mode
"function! ChangeStatuslineColor()
"  if (mode() =~# '\v(n|no)')
"    exe 'hi! StatusLine ctermfg=008'
"  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V-Block' || get(g:currentmode, mode(), '') ==# 't')
"    exe 'hi! StatusLine ctermfg=005'
"  elseif (mode() ==# 'i')
"    exe 'hi! StatusLine ctermfg=004'
"  else
"    exe 'hi! StatusLine ctermfg=006'
"  endif
"  return ''
"endfunction

"" Find out current buffer's size and output it.
"function! FileSize()
"  let bytes = getfsize(expand('%:p'))
"  if (bytes >= 1024)
"    let kbytes = bytes / 1024
"  endif
"  if (exists('kbytes') && kbytes >= 1000)
"    let mbytes = kbytes / 1000
"  endif

"  if bytes <= 0
"    return '0'
"  endif

"  if (exists('mbytes'))
"    return mbytes . 'MB '
"  elseif (exists('kbytes'))
"    return kbytes . 'KB '
"  else
"    return bytes . 'B '
"  endif
"endfunction

"function! ReadOnly()
"  if &readonly || !&modifiable
"    return '\ue0a2'
"  else
"    return ''
"  endif
"endfunction

"function! GitInfo()
"  let git = fugitive#head()
"  if git != ''
"    return '\ue0a0 '.fugitive#head()
"  else
"    return ''
"  endfi
"endfunction

"set statusline=
"set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
"set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
"set statusline+=%1*\ [%n]                                " buffernr
"set statusline+=%2*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
"set statusline+=%#warningmsg#
"set statusline+=%*
"set statusline+=%3*\ %=                                  " Space
"set statusline+=%4*\ %y\                                 " FileType
"set statusline+=%5*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ " Encoding & Fileformat
"set statusline+=%6*\ %-3(%{FileSize()}%)                 " File size
"set statusline+=%7*\ %=\ row:%l/%L\ \                    " Rownumber/total (%)
"set statusline+=%7*\ col:%03c\                           " Colnr
"set statusline+=%0*\ \ %m%r%w\ %P\ \                     " Modified? Readonly? Top/bot.

"hi User1 ctermfg=red ctermbg=black
"hi User2 ctermfg=blue ctermbg=black
"hi User3 ctermfg=green ctermbg=black
"hi User4 ctermfg=yellow ctermbg=black
"hi User5 ctermfg=cyan ctermbg=black
"hi User6 ctermfg=magenta ctermbg=black
"hi User7 ctermfg=white ctermbg=black
"hi User8 ctermfg=blue ctermbg=black
"hi User9 ctermfg=green ctermbg=black
""" }}}

" ----------------------------------------------------------------------------------------
"Wildmenu
" ----------------------------------------------------------------------------------------
set wildmenu                                     " Turn on the WiLd menu
"set wildmode=full
set wildmode=list:longest                        " complete files like a shell
set wildignore+=*.aux,*.out,*.toc                " Latex Indermediate files"
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " Binary Imgs"
set wildignore+=*.luac                           " Lua byte code"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " Compiled Object files"
set wildignore+=*.orig,*.rej                     " Merge resolution files"
set wildignore+=*.pyc                            " Python Object codes"
set wildignore+=*.spl                            " Compiled speolling world list"
set wildignore+=*.sw?                            " Vim swap files"
set wildignore+=migrations                       " Django migrations"
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=.hg,.git,.svn                " Version Controls"
    set wildignore+=*.DS_Store                   " OSX SHIT"
endif

" ----------------------------------------------------------------------------------------
" Searching
" ----------------------------------------------------------------------------------------
set hlsearch
set ignorecase " Ignore case when searching
if has('nvim')
    set inccommand=split
endif
set incsearch  " Makes search act like search in modern browsers
set magic      " For regular expressions turn magic on
set showmatch  " Show matching brackets when text indicator is over them
set smartcase  " When searching try to be smart about cases

" Folding
"set foldmethod=marker
set foldmethod=indent
set foldlevel=99
set nofoldenable  " don't fold by default

" autochange dir
set autochdir

" error bells
set noerrorbells
set t_vb=
set tm=500
set visualbell

" Directories for swp files
set nobackup
set nowb
set noswapfile

" Disable the vlinking cursor
set gcr=a:blinkon0
set scrolloff=3

" Use modeline overrides
set modeline
set modelines=10

set autoread                 " detect when a file is changed
set fileformats=unix,dos,mac
set gfn=Monospace\ 10
set guioptions=egmrti
if &history < 1000
    set history=1000         " change history to 1000
endif
set nocompatible             " not compatible with vi
set path+=**

if executable('zsh')
    set shell=/bin/zsh
else
    set shell=/bin/bash
endif

" ctags
set tags=./tags;/

set splitbelow
set splitright

" Use persistent history, Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let undo_dir = expand('~/.vim/undo_dir')
    if !isdirectory(undo_dir)
        call mkdir(undo_dir, "", 0700)
    endif
    set undodir=~/.vim-undo-dir
    set undofile
endif

" ----------------------------------------------------------------------------------------
" gvim
" ----------------------------------------------------------------------------------------
" With this, the gui (gvim and macvim) now doesn't have the toolbar, the left
" and right scrollbars and the menu.
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=M
""" }}}
