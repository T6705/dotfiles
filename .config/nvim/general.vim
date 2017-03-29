" vim:foldmethod=marker:foldlevel=0

""" === General Setting === {{{

let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = '/usr/bin/python3.5'

let mapleader=' '

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

if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

if has('mouse')
    set mouse=a
endif

command! PU PlugUpdate | PlugUpgrade

" ----------------------------------------------------------------------------------------
" Encoding
" ----------------------------------------------------------------------------------------
set binary
set bomb
set encoding=utf-8 " Set utf8 as standard encoding and en_US as the standard language
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
set fileencoding=utf-8
set fileencodings=utf-8
set ffs=unix,dos,mac " Use Unix as the standard file type

" Fix backspace indent
set backspace=indent,eol,start " make backspace behave in a sane manner

" ----------------------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------------------
"set completeopt+=longest
"set noexpandtab   " insert tabs rather than spaces for <Tab>
"set shiftround    " round indent to a multiple of 'shiftwidth'
"set smarttab      " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
"set softtabstop=4 " edit as if the tabs are 4 characters wide
set expandtab     " Use spaces instead of tabs
set shiftwidth=4  " number of spaces to use for indent and unindent (1 tab == 4 spaces)
set softtabstop=0
set tabstop=4     " the visible width of tabs

" toggle invisible characters
set invlist
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
highlight SpecialKey ctermbg=none " make the highlighting of tabs less annoying
set showbreak=↪
nmap <leader>l :set list!<cr>

" ----------------------------------------------------------------------------------------
" UI
" ----------------------------------------------------------------------------------------
colorscheme molokai
filetype indent on                                                                                " load filetype-specific indent files
set background=dark
set cursorline                                                                                    " highlight current line
set hidden                                                                                        " current buffer can be put into background
set lazyredraw                                                                                    " Don't redraw while executing macros (good performance config)
set number                                                                                        " show line numbers
set ruler                                                                                         " Always show current position
set scrolloff=3
set showcmd                                                                                       " show incomplete commands
set so=7                                                                                          " Set 7 lines to the cursor - when moving vertically using j/k
set laststatus=2                                                                                  " Status bar
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\ " Format the status line
set t_Co=256                                                                                      " Explicitly tell vim that the terminal supports 256 colors
set title
set titleold="Terminal"
set titlestring=%F
set ttyfast                                                                                       " faster redrawing
syntax on                                                                                         " switch syntax highlighting on

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
"Wildmenu
" ----------------------------------------------------------------------------------------
set wildmenu                                     " Turn on the WiLd menu
" set wildmode=full
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
    set wildignore+=.hg,.git,.svn                    " Version Controls"
    set wildignore+=*.DS_Store                       " OSX SHIT"
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
set history=1000             " change history to 1000
set nocompatible             " not compatible with vi
set path+=**
set shell=/bin/zsh

" ctags
set tags=./tags;/

set splitbelow
set splitright
""" }}}
