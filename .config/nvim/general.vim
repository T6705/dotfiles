" vim:foldmethod=marker:foldlevel=0

""" === General Setting === {{{

if executable('python2')
    let g:python_host_prog = '/usr/bin/python2'
endif
if executable('python3')
    let g:python3_host_prog = '/usr/bin/python3'
endif

let mapleader=' '

let php_htmlInStrings = 1 " highlight HTML in string
let php_sql_query     = 1 " highlight SQL syntax in string

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

if has('patch-7.4.1480')
    packadd justify
    packadd shellmenu
    packadd swapmouse
endif

if has('nvim')
    packadd vimball
endif

if has('mouse')
    set mouse=a
endif

if !has('nvim') && &ttimeoutlen == -1
    set ttimeout
    set ttimeoutlen=100
endif

if v:version > 703 || v:version == 703 && has("patch-7.3.541")
    set formatoptions=q  " allow gq to work on comment
    set formatoptions+=j " Delete comment character when joining commented lines
    set formatoptions+=r " enter extends comments
    set formatoptions+=n " format numbered lists using 'formatlistpat'
    set formatoptions+=1 " don't break after one letter word
endif

if !has('nvim') && v:version > 704 || (v:version == 704 && has('patch401'))
    setlocal cryptmethod=blowfish2  " medium strong method
endif

set diffopt=
set diffopt+=hiddenoff
set diffopt+=internal
set diffopt+=iwhiteall
set diffopt+=algorithm:patience

" -------------------------------------------------------------------------------
" Encoding
" -------------------------------------------------------------------------------
set binary
set bomb
set encoding=utf-8
set ffs=unix,dos,mac " Use Unix as the standard file type
set fileencoding=utf-8
set fileencodings=utf-16le,utf-8,latin1,default,ucs-bom

" Fix backspace indent
set backspace=indent,eol,start " make backspace behave in a sane manner

" -------------------------------------------------------------------------------
" Tabs
" -------------------------------------------------------------------------------
"set noexpandtab   " insert tabs rather than spaces for <TAB>
"set shiftround    " round indent to a multiple of 'shiftwidth'
set expandtab     " Use spaces instead of tabs
set shiftwidth=4  " number of spaces to use for indent and unindent (1 tab == 4 spaces)
set smarttab      " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set softtabstop=4 " edit as if the tabs are 4 characters wide
set tabstop=4     " the visible width of tabs

" toggle invisible characters
set invlist
if &encoding == "utf-8"
    set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
else
    set listchars=tab:\|\ ,nbsp:~,eol:$,trail:.,extends:>,precedes:<
endif
highlight SpecialKey ctermbg=none " make the highlighting of tabs less annoying
if has('patch-7.4.338')
    "let &showbreak = '↳ '
    set showbreak=↪
    set breakindent
    set breakindentopt=sbr
endif
nmap <Leader>l :set list!<CR>

" -------------------------------------------------------------------------------
" UI
" -------------------------------------------------------------------------------
if empty(glob('~/.config/nvim/colors/molokai.vim'))
    if !executable("curl")
        echoerr "You have to install curl or install molokai.vim yourself!"
    else
        echo "Installing molokai.vim"
        echo ""
        silent !curl -fLo ~/.config/nvim/colors/molokai.vim --create-dirs https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
    endif
endif
colorscheme molokai

if has('nvim')
    set pumblend=30
endif

"filetype on
filetype indent on    " load filetype-specific indent files
filetype plugin on
set autoindent        " Copy indent from last line when starting new line
set background=dark
set cindent
set cursorline        " highlight current line
set display+=lastline
set hidden            " current buffer can be put into background
set laststatus=2      " Status bar always on
set lazyredraw        " Don't redraw while executing macros (good performance config)
set number            " show line numbers
"set relativenumber   " show relative line numbers
set ruler             " Always show current position
set shortmess=a       " use every short text trick
set shortmess+=O      " file read message overwrites subsequent
set shortmess+=s      " no search hit bottom crap
set shortmess+=t      " truncate file message
set shortmess+=T      " truncate messages in the middle
set shortmess+=I      " no intro message
if has("patch-7.4.314")
    set shortmess+=c      " no ins-completion messages
endif
if !&scrolloff
    set scrolloff=3   " 3 lines above/below cursor when scrolling
endif
if !&sidescrolloff
    set sidescrolloff=5
endif

" Tweak autocompletion behavior for <C-n>/<C-p> in insert mode
" Default is ".,w,b,u,t,i" without "i", where:
" . - scan current buffer. Same to invoking <C-x><C-n> individually
" w - buffers in other windows
" b - loaded buffers in buffer list
" u - unloaded buffers in buffer list
" t - tags. Same to invoking <C-x><C-]> individually
" i - included files. We don't need this.
" kspell, when spell check is active, use words from spellfiles
set complete-=i
set complete+=kspell

set ofu=syntaxcomplete#Complete " Set omni-completion method

if has('nvim')
    set completeopt=longest,menuone
else
    set completeopt=longest,menuone,preview
endif
set showcmd           " show incomplete commands
set so=7              " Set 7 lines to the cursor - when moving vertically using j/k
set t_Co=256          " Explicitly tell vim that the terminal supports 256 colors
set title
set titleold="Terminal"
set titlestring=%F
set ttyfast           " faster redrawing
if has('syntax') && !exists('g:syntax_on')
    " syntax enable
    syntax on         " switch syntax highlighting on
    set synmaxcol=200 " only syntax highlighting the first 200 characters of each line
endif

if has('nvim') && has('termguicolors')
  set termguicolors
endif

" -------------------------------------------------------------------------------
" statusline
" -------------------------------------------------------------------------------
""" === basic statusline === {{{

let g:currentmode={ 'n'  : 'Normal ', 'no' : 'N-Operator Pending ', 'v'  : 'Visual ', 'V'  : 'V-Line ', '' : 'V-Block ', 's'  : 'Select ', 'S'  : 'S-Line ', '^S' : 'S-Block ', 'i'  : 'Insert ', 'R'  : 'Replace ', 'Rv' : 'V-Replace ', 'c'  : 'Command ', 'cv' : 'Vim Ex ', 'ce' : 'Ex ', 'r'  : 'Prompt ', 'rm' : 'More ', 'r?' : 'Confirm ', '!'  : 'Shell ', 't'  : 'Terminal ' }

" Automatically change the statusline color depending on mode
fu! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg=008'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V-Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermfg=005'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg=004'
  else
    exe 'hi! StatusLine ctermfg=006'
  endif
  return ''
endfu

" Find out current buffer's size and output it.
fu! FileSize() abort
    let l:bytes = getfsize(expand('%:p'))
    if (l:bytes >= 1024)
        let l:kbytes = l:bytes / 1024
    endif
    if (exists('kbytes') && l:kbytes >= 1000)
        let l:mbytes = l:kbytes / 1000
    endif

    if l:bytes <= 0
        return '0'
    endif

    if (exists('mbytes'))
        return l:mbytes . 'MB '
    elseif (exists('kbytes'))
        return l:kbytes . 'KB '
    else
        return l:bytes . 'B '
    endif
endfu

fu! ReadOnly() abort
    if &readonly || !&modifiable
        return ''
    else
        return ''
    endif
endfu

fu! GitInfo()
    let git = fugitive#head()
    if git != ''
        return ''.fugitive#head()
    else
        return ''
    endfi
endfu

set statusline=
set statusline+=%{ChangeStatuslineColor()}              " changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}  " current mode
set statusline+=%7*\ [%n]                               " buffernr
set statusline+=%7*\ %<%F\ %{ReadOnly()}%m%r%w\         " file+path+readonly+modified
set statusline+=%1*\ %y\                                " filetype
set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}    " encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\          " encoding2
set statusline+=%4*\ %{&ff}\                            " fileformat (dos/unix..)
set statusline+=%=
set statusline+=%2*\ [%b][0x%b]\                        " ascii and byte code under cursor
set statusline+=%5*\ row:%l/%L\                         " rownumber/total
set statusline+=%6*\ col:%03c\                          " colnr
set statusline+=%4*\ %-3(%{FileSize()}%)                " file size
set statusline+=%0*\ \ %P\ \                            " modified? readonly? top/bot.

hi User1 ctermfg=red ctermbg=black
hi User2 ctermfg=blue ctermbg=black
hi User3 ctermfg=green ctermbg=black
hi User4 ctermfg=yellow ctermbg=black
hi User5 ctermfg=cyan ctermbg=black
hi User6 ctermfg=magenta ctermbg=black
hi User7 ctermfg=white ctermbg=black
hi User8 ctermfg=blue ctermbg=black
hi User9 ctermfg=green ctermbg=black

""" }}}

" -------------------------------------------------------------------------------
"Wildmenu
" -------------------------------------------------------------------------------
set wildmenu                                     " Turn on the WiLd menu
"set wildmode=full
set wildmode=list:longest                        " complete files like a shell
set wildignore=*.a,*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.DS_Store                          " OSX bullshit
set wildignore+=*.aux,*.out,*.toc                   " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg      " binary images
set wildignore+=*.luac                              " Lua byte code
set wildignore+=*.orig,*.rej                        " Merge resolution files
set wildignore+=*.pdf,*.zip,*.so                    " binaries
set wildignore+=*.pyc,*.pyo                         " Python byte code
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=.hg,.git,.svn                " Version Controls"
endif

" -------------------------------------------------------------------------------
" Searching
" -------------------------------------------------------------------------------
set hlsearch   " highlight search results
set ignorecase " Ignore case when searching
if has('nvim')
    set inccommand=split
endif
set incsearch  " Makes search act like search in modern browsers
set magic      " For regular expressions turn magic on
set showmatch  " Show matching brackets when text indicator is over them
set smartcase  " case-sensitive if expresson contains a capital letter

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
if &history < 1000
    set history=1000         " change history to 1000
endif
if has('vim_starting')
    set nocompatible         " not compatible with vi
endif
set path+=**

if exists('$SHELL')
    set shell=$SHELL
elseif executable('bash')
    set shell=/bin/bash
else
    set shell=/bin/sh
endif

" ctags
set tags=./tags;/

set splitbelow
set splitright

"set spell
set spelllang=en_us,nl

" Use persistent history, Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let undo_dir = expand('~/.cache/vim-undo-dir')
    if !isdirectory(undo_dir)
        call mkdir(undo_dir, "", 0700)
    endif
    set undodir=~/.cache/vim-undo-dir
    set undofile
endif

" -------------------------------------------------------------------------------
" gvim
" -------------------------------------------------------------------------------
if has('gui_running')
    " With this, the gui (gvim and macvim) now doesn't have the toolbar, the left
    " and right scrollbars and the menu.
    set guioptions=egmrti
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=m
    set guioptions-=M
    set mousemodel=popup

    " Set font according to system
    if has("mac") || has("macunix")
        set gfn=Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
    elseif has("win16") || has("win32")
        set gfn=Hack:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
    elseif has("gui_gtk2")
        set gfn=Hack\ 10,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
    elseif has("linux")
        set gfn=Hack\ 10,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
    elseif has("unix")
        set gfn=Hack\ Nerd\ Font\ Mono\ 10,Hack\ 10
    else
        set gfn=Hack\ Nerd\ Font\ Mono\ 10,Hack\ 10
    endif

    if &encoding ==# 'latin1'
        set encoding=utf-8 " Set utf8 as standard encoding and en_US as the standard language
    endif
endif
""" }}}
