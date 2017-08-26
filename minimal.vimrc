" vim:foldmethod=marker:foldlevel=0

""" === augroup === {{{

augroup configgroup
    autocmd!
    autocmd BufRead,BufNewFile *.md setlocal spell "automatically turn on spell-checking for Markdown files
    autocmd BufRead,BufNewFile *.txt setlocal spell "automatically turn on spell-checking for text files
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FocusGained *: redraw!     " Redraw screen every time when focus gained
    autocmd FocusLost *: wa            " Set vim to save the file on focus out
    autocmd InsertLeave * silent! set nopaste
    autocmd VimResized * wincmd =
    autocmd! BufWritePre * %s/\s\+$//e " Automatically removing all trailing whitespace
augroup END

""" }}}

""" === General Setting === {{{

let mapleader=' '

let php_sql_query = 1
let php_htmlInStrings = 1

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

if has('mouse')
    set mouse=a
endif

if !has('nvim') && &ttimeoutlen == -1
    set ttimeout
    set ttimeoutlen=100
endif

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " Delete comment character when joining commented lines
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
"set noexpandtab   " insert tabs rather than spaces for <Tab>
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
set showbreak=↪
nmap <Leader>l :set list!<CR>

" ----------------------------------------------------------------------------------------
" UI
" ----------------------------------------------------------------------------------------
"colorscheme molokai
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

" ----------------------------------------------------------------------------------------
" statusline
" ----------------------------------------------------------------------------------------
"set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c) " Format the status line
set statusline=%t                                                 " tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'},                   " file encoding
set statusline+=%{&ff}]                                           " file format
set statusline+=%h                                                " help file flag
set statusline+=%m                                                " modified flag
set statusline+=%r                                                " read only flag
set statusline+=%y                                                " filetype
set statusline+=%=                                                " left/right separator
set statusline+=%c,                                               " cursor column
set statusline+=%l/%L                                             " cursor line/total lines
set statusline+=\ %P                                              " percent through file

" ----------------------------------------------------------------------------------------
"Wildmenu
" ----------------------------------------------------------------------------------------
set wildmenu                                     " Turn on the WiLd menu
"set wildmode=full
"set wildmode=longest,list,full
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

" ctags
set tags=./tags;/

set splitbelow
set splitright

""" }}}

""" === Mappings === {{{

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" :J json prettify
command J :%!python -mjson.tool

command Sortw :call setline(line('.'),join(sort(split(getline('.'))), ' '))

" ----------------------------------------------------------------------------------------
" Copy and Paste
" ----------------------------------------------------------------------------------------
"" have x (removes single character) not go into the default registry
"nnoremap x "_x

"" Make X an operator that removes without placing text in the default registry
"nmap X "_d
"nmap XX "_dd
"vmap X "_d
"vmap x "_d

"" when changing text, don't put the replaced text into the default registry
"nnoremap c "_c
"vnoremap c "_c

nnoremap <silent> <Leader>p "+gP
nnoremap <silent> <Leader>x "+x
nnoremap <silent> <Leader>y "+y
vnoremap <silent> <Leader>x "+x
vnoremap <silent> <Leader>y "+y

" place whole file on the system clipboard
nnoremap <silent> <Leader>a :%y+<CR>

"" Escaping
cnoremap <C-F> <Esc>
inoremap <C-F> <Esc>
nnoremap <C-F> <Esc>
vnoremap <C-F> <Esc>
xnoremap <C-F> <Esc>

"" No arrow keys
"no <down> <Nop>
"no <left> <Nop>
"no <right> <Nop>
"no <up> <Nop>

" No arrow keys in insert mode
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

" Saner command-line history
cnoremap <C-h>  <left>
cnoremap <C-j>  <down>
cnoremap <C-k>  <up>
cnoremap <C-l>  <right>
"" CTRL+A moves to start of line in command mode
"cnoremap <C-a> <home>
"" CTRL+E moves to end of line in command mode
"cnoremap <C-e> <end>

"" Map arrow keys to window resize commands.
"nnoremap <Right> 2<C-W>>
"nnoremap <Left> 2<C-W><
"nnoremap <Up> 2<C-W>+
"nnoremap <Down> 2<C-W>-

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> 0 g0
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" move to beginning/end of line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

nnoremap <silent> G :norm! Gzz<CR>
nnoremap <silent> N Nzz
nnoremap <silent> [[ [[zz
nnoremap <silent> [] []zz
nnoremap <silent> ][ ][zz
nnoremap <silent> ]] ]]zz
nnoremap <silent> g; g;zz " go to place of last change
nnoremap <silent> gV `[v`] " highlight last inserted text
nnoremap <silent> gg :norm! ggzz<CR>
nnoremap <silent> n nzz
nnoremap <silent> { {zz
nnoremap <silent> } }zz

" Vmap for maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Scrolling
"nnoremap <silent> <C-d> :call comfortable_motion#flick(400)<CR>
"nnoremap <silent> <C-u> :call comfortable_motion#flick(-400)<CR>
"nnoremap <silent> <C-j> :call comfortable_motion#flick(100)<CR>
"nnoremap <silent> <C-k> :call comfortable_motion#flick(-100)<CR>
noremap <C-j> 2<C-e>
noremap <C-k> 2<C-y>

nnoremap <silent> <Leader>ffo :!firefox %<CR>

" hexedit
"inoremap <silent> <F7> <esc>:%!xxd<CR>
"inoremap <silent> <F8> <esc>:%!xxd -r<CR>
"noremap <silent> <F7> :%!xxd<CR>
"noremap <silent> <F8> :%!xxd -r<CR>

" qq to record, Q to replay (recursive noremap due to peekaboo)
nnoremap Q @q

" Switch to the directory of opened buffer
nnoremap <silent> <Leader>cd :lcd %:p:h<CR>:pwd<CR>


" Change current word to uppercase
nnoremap <Leader>u gUiw

" Change current word to lowercase
nnoremap <Leader>l guiw

" clear highlighted search
nnoremap <silent> <Leader>sc :set hlsearch! hlsearch?<CR>

" automatically insert a \v before any search string, so search uses normal regexes
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" search for ipv4
nnoremap /ip4 /\v([0-9]{1,3}\.){3}[0-9]{1,3}<CR>

" search for ipv6
"nnoremap /ip6 /\v(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}\|([0-9a-fA-F]{1,4}:){1,7}:\|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}\|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}\|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}\|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}\|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}\|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})\|:((:[0-9a-fA-F]{1,4}){1,7}\|:)\|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}\|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]\|(2[0-4]\|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]\|(2[0-4]\|1{0,1}[0-9]){0,1}[0-9])\|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]\|(2[0-4]\|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]\|(2[0-4]\|1{0,1}[0-9]){0,1}[0-9]))

" search for url
nnoremap /url /\v(http\|https\|ftp):\/\/[a-zA-Z0-9][a-zA-Z0-9_-]*(\.[a-zA-Z0-9][a-zA-Z0-9_-]*)*(:\d\+)?(\/[a-zA-Z0-9_/.\-+%?&=;@$,!''*~]*)?(#[a-zA-Z0-9_/.\-+%#?&=;@$,!''*~]*)?<CR>

" search for word under the cursor
nnoremap <Leader>/ "fyiw :/<C-r>f<CR>

" window navigation
nnoremap <silent> <Leader>wx <C-W>x
nnoremap <silent> <Leader>wH <C-W>H
nnoremap <silent> <Leader>wJ <C-W>J
nnoremap <silent> <Leader>wK <C-W>K
nnoremap <silent> <Leader>wL <C-W>L
" Make splits the same width
nnoremap <silent> <Leader>we <C-w>=
nnoremap <silent> <Leader>wz :wincmd _ \|wincmd \| \| normal 0 <CR>

" Quickly edit your macros
nnoremap <Leader>m  :<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><left>

" quickfix
nnoremap <silent> <Leader>lo :lopen<CR>
nnoremap <silent> <Leader>lc :lclose<CR>
nnoremap <silent> [l :lprevious<CR> " Neomake
nnoremap <silent> ]l :lnext<CR>     " Neomake
nnoremap <silent> ]q :cnext<CR>zz
nnoremap <silent> [q :cprev<CR>zz
"nmap <silent> [l <Plug>(ale_previous_wrap) " Asynchronous Lint Engine
"nmap <silent> ]l <Plug>(ale_next_wrap      " Asynchronous Lint Engine

" Tabs
nnoremap ]t gt
nnoremap [t gT
nnoremap <silent> <Leader>nt :tabnew<CR>

" Buffer nav
nnoremap <silent> [b :bp<CR>
nnoremap <silent> ]b :bn<CR>
nnoremap <silent> <Leader>q :bd!<CR>
nnoremap <silent> <Leader>nb :enew<CR>

" add space after comma
nnoremap <Leader>, :%s/, */, /g<CR>
vnoremap <Leader>, :s/, */, /g<CR>

" Explore dir
nnoremap <silent> <Leader>E :Lexplore<CR>

" folding
nnoremap <Leader>f za<CR>
vnoremap <Leader>f za<CR>

" Make the dot command work as expected in visual mode (via
" https://www.reddit.com/r/vim/comments/3y2mgt/do_you_have_any_minor_customizationsmappings_that/cya0x04)
vnoremap . :norm.<CR>

" Markdown headings
nnoremap <Leader>1 m`yypVr=``
nnoremap <Leader>2 m`yypVr-``
nnoremap <Leader>3 m`^i### <esc>``4l
nnoremap <Leader>4 m`^i#### <esc>``5l
nnoremap <Leader>5 m`^i##### <esc>``6l

" Make check spelling on or off
nnoremap <Leader>cson   :set spell<CR>
nnoremap <Leader>csoff :set nospell<CR>

""" }}}

""" === plugin config === {{{

" ----------------------------------------------------------------------------------------
" netrw
" ----------------------------------------------------------------------------------------
"let g:netrw_altv         = 1 " open splits to the right
"let g:netrw_browse_split = 4 " open in prior window
let g:netrw_banner      = 0 " disable annoying banner
let g:netrw_bufsettings = 'relativenumber'
let g:netrw_hide        = 1 " hide dotfiles by default
let g:netrw_list_hide   = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles
let g:netrw_list_hide   = netrw_gitignore#Hide()
"let g:netrw_liststyle   = 1 " Detail View
let g:netrw_liststyle   = 3 " tree view
let g:netrw_preview     = 1
let g:netrw_sizestyle   = "H" " Human-readable file sizes
let g:netrw_winsize     = 30

""" }}}
