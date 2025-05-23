" vim:foldmethod=marker:foldlevel=0

""" === augroup === {{{

augroup configgroup
    au!

    if has('nvim')
        au BufWinEnter,WinEnter term://* startinser
    endif
    au BufRead * call ChangeEncoding()
    au BufNewFile * call SetTitle()
    au BufNewFile * normal G
    au BufRead,BufNewFile *.{md,notes,todo,txt} setlocal spell " automtically turn on spell-checking
    au BufReadPost quickfix nnoremap <buffer> <Left> :Qolder<CR>
    au BufReadPost quickfix nnoremap <buffer> <Right> :Qnewer<CR>
    au BufWinEnter *.todo call Todo()
    au BufWritePost .vimrc,.vimrc.local,init.vim source %
    au BufWritePost .vimrc.local source %
    au FileType json setlocal equalprg=python\ -m\ json.tool
    au FileType json syntax match Comment +\/\/.\+$+
    au FileType markdown syntax sync fromstart
    au FileType vim setlocal foldmethod=marker
    au FileType vim setlocal foldlevelstart=0
    au FocusGained * :redraw!     " Redraw screen every time when focus gained
    au FocusLost * :wa            " Set vim to save the file on focus out
    au InsertLeave * silent! set nopaste
    au VimResized * wincmd =
    au! BufWritePre * %s/\s\+$//e " Automatically removing all trailing whitespace
augroup END

augroup tabs
    "set expandtab     " Use spaces instead of tabs
    "set shiftwidth=4  " number of spaces to use for indent and unindent (1 tab == 4 spaces)
    "set smarttab      " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    "set softtabstop=4 " edit as if the tabs are 4 characters wide
    "set tabstop=4     " the visible width of tabs
    au!
    au BufRead,BufNewFile * setlocal expandtab shiftwidth=4 smarttab softtabstop=4 tabstop=4
    au BufRead,BufNewFile *.{css,dart,html,js} setlocal expandtab shiftwidth=2 smarttab softtabstop=2 tabstop=2
augroup END

augroup todo
    au!
    au BufRead,BufNewFile *.{notes,todo,txt} nnoremap <silent> <Leader>i 0i[ ] ""<Left>
    au BufRead,BufNewFile *.{notes,todo,txt} nnoremap <silent> <Leader>o o[ ] ""<Left>
    au BufRead,BufNewFile *.{notes,todo,txt} nnoremap <silent> <Leader>O O[ ] ""<Left>
    au BufRead,BufNewFile *.{notes,todo,txt} nnoremap <silent> <Leader>td mm:s/\[\ \]/\[X\]<CR>:put = strftime('%Y/%m/%d %H:%M:%S')<CR>kJ`m:delmarks m<CR>zz
    au BufRead,BufNewFile *.{notes,todo,txt} nnoremap <silent> <Leader>tu mm:s/\[X\]/\[\ \]<CR>:s/[0-9]*\/[0-9]*\/[0-9]* [0-9]*:[0-9]*:[0-9]*$/<CR>`m:delmarks m<CR>zz
augroup END

augroup html_js_css
    au!
    au BufRead,BufNewFile *.{css,html,js} setlocal formatprg=prettier\ --single-quote\ --trailing-comma
    "au BufRead,BufNewFile *.{html,js,xml} CompleteTags
augroup END

" close preview on completion complete
augroup completionhide
    au!
    au InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    "if v:version > 703 || v:version == 703 && has('patch598')
    "    au CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
    "endif
augroup end

" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
    au!
    au BufEnter * :syntax sync maxlines=200
augroup END

" Restore cursor position when opening file
augroup vimrc-restore-cursor-position
    au!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup LangConfig
    au BufRead,BufNewFile *.py call PythonConfig()
augroup END

augroup auto_mkdir
    au!
    au BufWritePre * if !isdirectory(expand('<afile>:p:h')) | call mkdir(expand('<afile>:p:h'), 'p') | endif
augroup END

augroup vimrc_active_options
    au!
    au WinEnter,BufEnter * setlocal nu
    au WinLeave,BufLeave * setlocal nonu
augroup END

augroup auto_open_quickfix_window
    au!
    au QuickFixCmdPost [^l]* cwindow
    au QuickFixCmdPost l*    lwindow
    au VimEnter * cwindow
augroup END

augroup autoRead
    au!
    au CursorHold * silent! checktime " auto update buffer
augroup END

"augroup Yanks
"    autocmd!
"    au TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
"augroup END
""" }}}

""" === General Setting === {{{

if executable('python2')
    let g:python_host_prog = system('which python2')
endif
if executable('python3')
    let g:python3_host_prog = system('which python3')
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

runtime macros/matchit.vim

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

if has('nvim-0.3.2') || has("patch-8.1.0360")
    "" Turn off whitespaces compare and folding in vimdiff
    "set diffopt+=iwhite
    "set diffopt+=vertical

    " Show filler lines, to keep the text synchronized with a window that has inserted lines at the same position
    set diffopt+=filler

    set diffopt+=internal,algorithm:patience
    set diffopt+=indent-heuristic
    set diffopt+=algorithm:histogram
endif

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
if has('nvim')
    let g:molokai_path = expand('~/.config/nvim/colors/molokai.vim')
else
    let g:molokai_path = expand('~/.vim/colors/molokai.vim')
endif
if empty(glob(g:molokai_path))
    if !executable("curl")
        echoerr "You have to install curl or install molokai.vim yourself!"
    else
        echo "Installing molokai.vim"
        echo ""
        silent exe "!curl -fLo " . g:molokai_path . " --create-dirs https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim"
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
set relativenumber    " show relative line numbers
set ruler             " Always show current position
set signcolumn=yes    " always show signcolumns
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
    endif
endfu

fu! Scrollbar()
    let width = 10
    let perc = (line('.') - 1.0) / (max([line('$'), 2]) - 1.0)
    let before = float2nr(round(perc * (width - 3)))
    let after = width - 3 - before
    return '[' . repeat(' ',  before) . '=' . repeat(' ', after) . ']'
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
set statusline+=%0*\ %{Scrollbar()}                     " Scrollbar
set statusline+=%0*\ %P\ \                              " modified? readonly? top/bot.

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
set wildoptions+=fuzzy
set wildoptions+=pum
set wildoptions+=tagfile

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
set foldtext=CustomFold()

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
        call mkdir(undo_dir, "p", 0700)
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
        set gfn=FiraCode\ Nerd\ Font:h16
    else
        set gfn=Fira\ Code\ Nerd\ Font:h16
    endif

    if &encoding ==# 'latin1'
        set encoding=utf-8 " Set utf8 as standard encoding and en_US as the standard language
    endif
endif
""" }}}

""" === Functions === {{{
" -------------------------------------------------------------------------------
" :LightTheme (PaperColor)
" -------------------------------------------------------------------------------
fu! LightTheme()
    if has('nvim')
        let g:PaperColor_path = expand('~/.config/nvim/colors/PaperColor.vim')
    else
        let g:PaperColor_path = expand('~/.vim/colors/PaperColor.vim')
    endif
    if empty(glob(g:PaperColor_path))
        if !executable("curl")
            echoerr "You have to install curl or install PaperColor.vim yourself!"
        endif
        echo "Installing PaperColor.vim"
        echo ""
        silent exe "!curl -fLo " . g:PaperColor_path .  " --create-dirs https://raw.githubusercontent.com/NLKNguyen/papercolor-theme/master/colors/PaperColor.vim"
        "let g:transparent_background = 1
    endif
    let g:allow_bold=1
    let g:allow_italic=1
    set background=light
    colorscheme PaperColor
    if has('nvim') && has('termguicolors')
      set termguicolors
    endif
endfu
command! LightTheme call LightTheme()

" -------------------------------------------------------------------------------
" :DarkTheme (Molokai)
" -------------------------------------------------------------------------------
fu! DarkTheme()
    if has('nvim')
        let g:molokai_path = expand('~/.config/nvim/colors/molokai.vim')
    else
        let g:molokai_path = expand('~/.vim/colors/molokai.vim')
    endif
    if empty(glob(g:molokai_path))
        if !executable("curl")
            echoerr "You have to install curl or install molokai.vim yourself!"
        endif
        echo "Installing molokai.vim"
        echo ""
        silent exe "!curl -fLo " . g:molokai_path . " --create-dirs https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim"
    endif
    set background=dark
    colorscheme molokai
    if has('nvim') && has('termguicolors')
      set termguicolors
    endif
endfu
command! DarkTheme call DarkTheme()

" -------------------------------------------------------------------------------
" :GruvboxLight
" -------------------------------------------------------------------------------
fu! GruvboxLight()
    if has('nvim')
        let g:gruvbox_path = expand('~/.config/nvim/colors/gruvbox.vim')
    else
        let g:gruvbox_path = expand('~/.vim/colors/gruvbox.vim')
    endif
    if empty(glob(g:gruvbox_path))
        if !executable("curl")
            echoerr "You have to install curl or install gruvbox.vim yourself!"
        endif
        echo "Installing gruvbox.vim"
        echo ""
        silent exe "!curl -fLo " . g:gruvbox_path . " --create-dirs https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim"
    endif
    let g:gruvbox_italic=1
    let g:gruvbox_contrast_light="hard"
    set background=light
    colorscheme gruvbox
    if has('nvim') && has('termguicolors')
      set termguicolors
    endif
endfu
command! GruvboxLight call GruvboxLight()

" -------------------------------------------------------------------------------
" :GruvboxDark
" -------------------------------------------------------------------------------
fu! GruvboxDark()
    if has('nvim')
        let g:gruvbox_path = expand('~/.config/nvim/colors/gruvbox.vim')
    else
        let g:gruvbox_path = expand('~/.vim/colors/gruvbox.vim')
    endif
    if empty(glob(g:gruvbox_path))
        if !executable("curl")
            echoerr "You have to install curl or install gruvbox.vim yourself!"
        endif
        echo "Installing gruvbox.vim"
        echo ""
        silent exe "!curl -fLo " . g:gruvbox_path . " --create-dirs https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim"
    endif
    let g:gruvbox_italic=1
    let g:gruvbox_contrast_dark="soft"
    set background=dark
    colorscheme gruvbox
    if has('nvim') && has('termguicolors')
      set termguicolors
    endif
endfu
command! GruvboxDark call GruvboxDark()

" -------------------------------------------------------------------------------
" :Todo
" -------------------------------------------------------------------------------
fu! Todo()
    if exists("b:current_syntax")
        finish
    endif

    " Custom conceal
    syntax match todoCheckbox "\[\ \]" conceal cchar=
    syntax match todoCheckbox "\[x\]" conceal cchar=

    let b:current_syntax = "todo"

    hi def link todoCheckbox Todo
    hi Conceal guibg=NONE

    setlocal cole=1

    command! Check :s/\(\s*\)\[ \]/\1\[x\]/
    command! Uncheck :s/\(\s*\)\[x\]/\1\[ \]/
endfu
command! Todo call Todo()

fu! Osc52Yank()
    let buffer=system('base64 -w0', @0)
    let buffer=substitute(buffer, "\n$", "", "")
    let buffer='\e]52;c;'.buffer.'\x07'
    silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape("/dev/pts/0")
    redraw!
    redraws!
endfu
command! Osc52CopyYank call Osc52Yank()

" -------------------------------------------------------------------------------
" Finder
" -------------------------------------------------------------------------------
fu! FilterClose(bufnr)
    wincmd p
    exe "bwipe" a:bufnr
    redraw
    echo "\r"
    return []
endfu

fu! Finder(input, prompt) abort
 let l:prompt = a:prompt . '>'
 let l:filter = ""
 let l:undoseq = []
 botright 10new +setlocal\ buftype=nofile\ bufhidden=wipe\
     \ nobuflisted\ nonumber\ norelativenumber\ noswapfile\ nowrap\
     \ foldmethod=manual\ nofoldenable\ modifiable\ noreadonly
 let l:cur_buf = bufnr('%')
 if type(a:input) ==# v:t_string
     let l:input = systemlist(a:input)
     call setline(1, l:input)
 else " Assume List
     call setline(1, a:input)
 endif
 setlocal cursorline
 redraw
 echo l:prompt . " "
 while 1
     let l:error = 0 " Set to 1 when pattern is invalid
     try
         let ch = getchar()
     catch /^Vim:Interrupt$/    " CTRL-C
         return FilterClose(l:cur_buf)
     endtry
     if ch ==# "\<bs>" " Backspace
         let l:filter = l:filter[:-2]
         let l:undo = empty(l:undoseq) ? 0 : remove(l:undoseq, -1)
         if l:undo
             silent norm u
         endif
     elseif ch >=# 0x20 " Printable character
         let l:filter .= nr2char(ch)
         let l:seq_old = get(undotree(), 'seq_cur', 0)
         try " Ignore invalid regexps
             exe 'silent keepp g!:\m' . escape(l:filter, '~\[:') . ':norm "_dd'
         catch /^Vim\%((\a\+)\)\=:E/
             let l:error = 1
         endtry
         let l:seq_new = get(undotree(), 'seq_cur', 0)
         " seq_new != seq_old iff the buffer has changed
         call add(l:undoseq, l:seq_new != l:seq_old)
     elseif ch ==# 0x1B " Escape
         return FilterClose(l:cur_buf)
     elseif ch ==# 0x0D " Enter
         let l:result = empty(getline('.')) ? [] : [getline('.')]
         call FilterClose(l:cur_buf)
         return l:result
     elseif ch ==# 0x0C " CTRL-L (clear)
         call setline(1, type(a:input) ==# v:t_string ? l:input : a:input)
         let l:undoseq = []
         let l:filter = ""
         redraw
     elseif ch ==# 0x0B " CTRL-K
         norm k
     elseif ch ==# 0x0A " CTRL-J
         norm j
     endif
     redraw
     echo (l:error ? "[Invalid pattern] " : "").l:prompt l:filter
 endwhile
endfu

fu! Buffers()
    if exists('v:t_string')
        let buffers = split(execute('ls'), "\n")
        let choice = Finder(buffers, 'Switch to buffer')
        if !empty(choice)
            exe "buffer" split(choice[0], '\s\+')[0]
        endif
    endif
endfu
command! Buffers call Buffers()

fu! Colors()
    if exists('v:t_string')
        let colorschemes = map(globpath(&runtimepath, "colors/*.vim", 0, 1),
                    \                'fnamemodify(v:val, ":t:r")')
        let colorschemes += map(globpath(&packpath,
                    \                "pack/*/{opt,start}/*/colors/*.vim", 0, 1),
                    \                'fnamemodify(v:val, ":t:r")')
        let choice = Finder(colorschemes, 'Choose colorscheme')
        if !empty(choice)
            exe "colorscheme" choice[0]
        endif
    endif
endfu
command! Colors call Colors()

fu! Files()
    if exists('v:t_string')
        if exists(":FZF") != 0
            exe "FZF"
            let choice = ""
        elseif executable("rg")
            let choice = Finder('rg --files --no-ignore --hidden --follow .', "Choose file")
        elseif executable("fd")
            let choice = Finder('fd --type f --hidden --follow .', "Choose file")
        elseif executable("find")
            let choice = Finder('find . -type f', "Choose file")
        endif
        if !empty(choice)
            exe "edit" choice[0]
        endif
    endif
endfu
command! Files call Files()
" -------------------------------------------------------------------------------
" :BufSearch <pattern> | Search in all currently opened buffers
" -------------------------------------------------------------------------------
fu! ClearQuickfixList()
    call setqflist([])
endfu
fu! Vimgrepall(pattern)
    call ClearQuickfixList()
    exe 'bufdo noau vimgrepadd ' . a:pattern . ' %'
    cnext
    cwindow
endfu
command! -nargs=1 BufSearch call Vimgrepall(<f-args>)

" -------------------------------------------------------------------------------
" :Shuffle | Shuffle selected lines
" -------------------------------------------------------------------------------
fu! s:shuffle() range
ruby << RB
  first, last = %w[a:firstline a:lastline].map { |e| VIM::evaluate(e).to_i }
  (first..last).map { |l| $curbuf[l] }.shuffle.each_with_index do |line, i|
    $curbuf[first + i] = line
  end
RB
endfu
command! -range Shuffle <line1>,<line2>call s:shuffle()

" -------------------------------------------------------------------------------
" :ClearRegisters
" -------------------------------------------------------------------------------
fu! ClearRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exe 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
endfu
command! ClearRegisters call ClearRegisters()

" -------------------------------------------------------------------------------
" :ChangeEncoding
" -------------------------------------------------------------------------------
fu! ChangeEncoding()
    if executable("file")
        let result = system("file " . escape(escape(escape(expand("%"), ' '), '['), ']'))
        if result =~ "Little-endian UTF-16" && &enc != "utf-16le"
            exe "e ++enc=utf-16le"
        elseif result =~ "ISO-8859" && &enc != "iso-8859-1"
            exe "e ++enc=iso-8859-1"
        endif
    endif
endfu
command! ChangeEncoding call ChangeEncoding()

" -------------------------------------------------------------------------------
" :SetTitle
" -------------------------------------------------------------------------------
fu! SetTitle()
    if expand("%:e") == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif expand("%:e") == 'cpp'
        call setline(1, "#include <iostream>")
        call append(line("."), "using namespace std;")
        call append(line(".")+1, "")
    elseif expand("%:e") == 'c'
        call setline(1, "#include <stdio.h>")
        call append(line("."), "")
    elseif expand("%:e") == 'java'
        exe 'cd %:p:h'
        call setline(1, "public class ".expand("%<")." {")
        call append(line("."), "}")
    endif
endfu
command! SetTitle call SetTitle()

" -------------------------------------------------------------------------------
" :Hexmode
" -------------------------------------------------------------------------------
fu! ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        silent :e " this will reload the file without trickeries
        "(DOS line endings will be shown entirely )
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfu
command! Hexmode call ToggleHex()

" -------------------------------------------------------------------------------
" autofold
" -------------------------------------------------------------------------------
fu! s:open_folds(action) abort
    if a:action ==# 'is_active'
        return exists('s:open_folds')
    elseif a:action ==# 'enable' && !exists('s:open_folds')
        let s:open_folds = {
                    \                    'close'   : &foldclose,
                    \                    'column'  : &foldcolumn,
                    \                    'enable'  : &foldenable,
                    \                    'level'   : &foldlevel,
                    \                    'method'  : &foldmethod,
                    \                    'nestmax' : &foldnestmax,
                    \                    'open'    : &foldopen,
                    \                  }
        set foldclose=all
        set foldcolumn=1
        set foldenable
        set foldlevel=0
        set foldmethod=indent
        "set foldmethod=syntax
        set foldnestmax=1
        set foldopen=all
        echo '[auto open folds] ON'
    elseif a:action ==# 'disable' && exists('s:open_folds')
        for op in keys(s:open_folds)
            exe 'let &fold'.op.' = s:open_folds.'.op
        endfor
        unlet! s:open_folds
        echo '[auto open folds] OFF'
    endif
endfu
command! AutoFoldsEnable  call <sid>open_folds('enable')
command! AutoFoldsDisable call <sid>open_folds('disable')
command! AutoFoldsToggle  call <sid>open_folds(<sid>open_folds('is_active') ? 'disable' : 'enable')

function! CustomFold()
    return printf('   %6d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
endfunction

fu! PythonConfig()
    inorea <buffer> ifmain if __name__ == "__main__":<CR>main()<Esc>

    " -------------------------------------------------------------------------------
    " isort
    " -------------------------------------------------------------------------------
    if executable("isort")
        nnoremap <silent> <Leader>is :%!isort -<CR>
        nnoremap <silent> <Leader>isa :bufdo %!isort -<CR>
        command! -range=% Isort :<line1>,<line2>! isort -
    else
        nnoremap <Leader>is :echo "isort is not installed"<CR>
        nnoremap <Leader>isa :echo "isort is not installed"<CR>
    endif

    nnoremap <silent> <Leader>bp Oimport pdb; pdb.set_trace()  # BREAKPOINT<C-c>
endfu

" -------------------------------------------------------------------------------
" make list-like commands more intuitive
" -------------------------------------------------------------------------------
fu! CCR()
    let cmdline = getcmdline()
    if cmdline =~ '\v\C^(ls|files|buffers)'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ '\v\C^(cli|lli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~ '\C^old'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:sil se more|e #<"
    elseif cmdline =~ '\C^changes'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~ '\C^ju'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\C^marks'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~ '\C^undol'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        return "\<CR>"
    endif
endfu

fu! s:align_around_delimiter() abort
    let delim = input('delimiter: ')
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif
    let max_align_col = 0
    let max_op_width = 0
    for linetext in getline(firstline, lastline)
        let left_width = match(linetext, '\s*' . delim)
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])
            let op_width = strlen(matchstr(linetext, delim))
            let max_op_width = max([max_op_width, op_width+1])
        endif
    endfor
    let LINE = '^\(.\{-}\)\s*\(' . delim . '\)'
    let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
    \                                    max_op_width, submatch(2))'
    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfu

fu! AlignAssignments ()
    "Patterns needed to locate assignment operators...
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'

    "Locate block of code to be considered (same indentation, no blanks)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    "Find the column at which the operators should be aligned...
    let max_align_col = 0
    let max_op_width  = 0
    for linetext in getline(firstline, lastline)
        "Does this line have an assignment in it?
        let left_width = match(linetext, '\s*' . ASSIGN_OP)

        "If so, track the maximal assignment column and operator width...
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])

            let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
            let max_op_width  = max([max_op_width, op_width+1])
         endif
    endfor

    "Code needed to reformat lines so as to align operators...
    let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
    \                                    max_op_width,  submatch(2))'

    " Reformat lines with operators aligned in the appropriate column...
    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfu
command! AlignAssignments call AlignAssignments()

""" }}}

""" === Mappings === {{{

" :W (sudo saves the file)
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" :J (json prettify)
command! J :%!python -m json.tool

" sort words on the same line
command! Sortw :call setline(line('.'),join(sort(split(getline('.'))), ' '))

" -------------------------------------------------------------------------------
" Copy and Paste
" -------------------------------------------------------------------------------
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

"" Make `Y` behave like `C` and `D`
"nnoremap Y y$

" change word under cursor and dot repeat
nnoremap c* *Ncgn
nnoremap c# #NcgN

nnoremap <Leader>p "+gP
nnoremap <Leader>x "+x
nnoremap <Leader>y mm:Osc52CopyYank<CR>`m:delmarks m<CR>zz
vnoremap <Leader>x "+x
vnoremap <Leader>y mm:Osc52CopyYank<CR>`m:delmarks m<CR>zz

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" select the current line without indentation
nnoremap vv ^vg_

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

" Map arrow keys to window resize commands.
nnoremap <Right> 2<C-W>>
nnoremap <Left> 2<C-W><
nnoremap <Up> 2<C-W>+
nnoremap <Down> 2<C-W>-

" moving up and down work as you would expect
"nnoremap <silent> j gj
"nnoremap <silent> k gk
"nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
"nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
nnoremap <silent> 0 g0
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" move to beginning/end of line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

nnoremap <silent> G :norm! Gzz<CR>
nnoremap <silent> N Nzzzv
nnoremap <silent> [[ [[zz
nnoremap <silent> [] []zz
nnoremap <silent> ][ ][zz
nnoremap <silent> ]] ]]zz
nnoremap <silent> g; g;zz " go to place of last change
nnoremap <silent> gV `[v`] " highlight last inserted text
nnoremap <silent> gg :norm! ggzz<CR>
nnoremap <silent> g= mmgg=G`m
nnoremap <silent> gQ mmgggqG`m
nnoremap <silent> n nzzzv
nnoremap <silent> { {zz
nnoremap <silent> } }zz

" Jump to matching pairs easily, with Shift-Tab
nmap <silent> <S-Tab> %zz
vmap <silent> <S-Tab> %zz

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Vmap for maintain Visual Mode after shifting > and <
xnoremap < <gv
xnoremap > >gv

" Move visual block
xnoremap J :m '>+1<CR>gv=gvzz
xnoremap K :m '<-2<CR>gv=gvzz

" Scrolling
noremap <C-j> 2<C-e>
noremap <C-k> 2<C-y>

nnoremap <silent> <Leader>ffo :!firefox %<CR>

" hexedit
"inoremap <silent> <F7> <Esc>:%!xxd<CR>
"inoremap <silent> <F8> <Esc>:%!xxd -r<CR>
"noremap <silent> <F7> :%!xxd<CR>
"noremap <silent> <F8> :%!xxd -r<CR>

" qq to record, Q to replay (recursive noremap due to peekaboo)
nnoremap Q @q
xnoremap Q :'<,'>:normal @q<CR>

" Switch to the directory of opened buffer
nnoremap <silent> <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" Change current word to uppercase
nnoremap <silent> <Leader>u gUiw

" Change current word to lowercase
nnoremap <silent> <Leader>l guiw

" clear highlighted search
nnoremap <silent> <Leader>sc :set hlsearch! hlsearch?<CR>

" Press <Leader>bg in order to toggle light/dark background
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

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
nnoremap <silent> <Leader>/ "fyiw :/<C-r>f<CR>

" window navigation
nnoremap <silent> <Leader>wh <C-W>h
nnoremap <silent> <Leader>wj <C-W>j
nnoremap <silent> <Leader>wk <C-W>k
nnoremap <silent> <Leader>wl <C-W>l
nnoremap <silent> <Leader>wx <C-W>x
nnoremap <silent> <Leader>wH <C-W>H
nnoremap <silent> <Leader>wJ <C-W>J
nnoremap <silent> <Leader>wK <C-W>K
nnoremap <silent> <Leader>wL <C-W>L
" Make splits the same width
nnoremap <silent> <Leader>we <C-w>=
nnoremap <silent> <Leader>wz :wincmd _ \|wincmd \| \| normal 0 <CR>

" Quickly edit your macros
nnoremap <silent> <Leader>m  :<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><left>

" quickfix
let g:quickfix_height = 50
"nmap <silent> [l <Plug>(ale_previous)
"nmap <silent> [l <Plug>(ale_previous_wrap)
"nmap <silent> ]l <Plug>(ale_next)
"nmap <silent> ]l <Plug>(ale_next_wrap)

" quickfix
let g:quickfix_height = 50
nnoremap <silent> <Leader>lc :lclose<CR>
nnoremap <silent> <Leader>lo :lopen<CR>
nnoremap <silent> <Leader>lw :lwindow<CR>
nnoremap <silent> [L :lfirst<CR>zz
nnoremap <silent> [l :lprev<CR>zz
nnoremap <silent> ]L :llast<CR>zz
nnoremap <silent> ]l :lnext<CR>zz

nnoremap <silent> <Leader>qc :cclose<CR>
nnoremap <silent> <Leader>qo :copen<CR>
nnoremap <silent> <Leader>qw :cwindow<CR>
nnoremap <silent> [Q :cfirst<CR>zz
nnoremap <silent> [q :cprev<CR>zz
nnoremap <silent> ]Q :clast<CR>zz
nnoremap <silent> ]q :cnext<CR>zz

" Tabs
nnoremap ]t gt
nnoremap [t gT
nnoremap <silent> <Leader>tn :tabnew<CR>

" Buffer nav
nnoremap <silent> [b :bp<CR>
nnoremap <silent> ]b :bn<CR>
nnoremap <silent> <Leader>q :bd!<CR>
nnoremap <silent> <Leader>bn :enew<CR>
"nnoremap <silent> <Leader>bs :ls<CR>:buffer<Space>
nnoremap <silent> <Leader>bs :Buffers<CR>
nnoremap <silent> <Leader>vbs :ls<CR>:sbuffer<Space>
nnoremap <silent> <bs> <C-^>

" add space after comma
nnoremap <silent> <Leader>, :%s/, */, /g<CR>
vnoremap <silent> <Leader>, :s/, */, /g<CR>

" Explore dir
nnoremap <silent> <Leader> e :Files<CR>

if exists(":Lexplore") != 1
    nnoremap <silent> <Leader>E :Lexplore<CR>
elseif exists(":Vexplore") != 1
    nnoremap <silent> <Leader>E :Vexplore<CR>
else
    nnoremap <silent> <Leader>E :Explore<CR>
endif

" Completetion
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <Tab> and <S-Tab> for navigate completion list:
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <enter> to confirm complete
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

inoremap <silent> ,, <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ",,"<CR>

" file names
inoremap <silent> ,f <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",f"<CR>

" line
inoremap <silent> ,l <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",l"<CR>

" keyword from current file
inoremap <silent> ,w <C-x><C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",w"<CR>

" omni completion
inoremap <silent> ,o <C-x><C-o><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",o"<CR>

" folding
nnoremap <silent> <Leader>f za<CR>
vnoremap <silent> <Leader>f za<CR>

" Make the dot command work as expected in visual mode (via
" https://www.reddit.com/r/vim/comments/3y2mgt/do_you_have_any_minor_customizationsmappings_that/cya0x04)
vnoremap . :norm.<CR>

" compile and run
noremap <silent> <Leader>cr :CompileandRun<CR>

" Markdown headings
nnoremap <silent> <Leader>1 m`yypVr=``
nnoremap <silent> <Leader>2 m`yypVr-``
nnoremap <silent> <Leader>3 m`^i### <Esc>``4l
nnoremap <silent> <Leader>4 m`^i#### <Esc>``5l
nnoremap <silent> <Leader>5 m`^i##### <Esc>``6l

" Make check spelling on or off
nnoremap <silent> <Leader>cson   :set spell<CR>
nnoremap <silent> <Leader>csoff :set nospell<CR>

" Correcting spelling mistakes
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"moves to the last incorrectly spelled word and changes it to the top spell suggestion
nnoremap <Leader>z [s1z=

" search and replace
nnoremap <Leader>sr  :'{,'}s/\<<C-r>=expand('<cword>')<CR>\>/
nnoremap <Leader>sra :%s/\<<C-r>=expand('<cword>')<CR>\>/

nnoremap <silent> <Leader>rp /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap <silent> <Leader>RP ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN
nnoremap <silent> <Leader>dw /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgn
nnoremap <silent> <Leader>DW ?\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgN

" Recompute syntax highlighting
nnoremap <silent> <Leader>ss :syntax sync fromstart<CR>

" alignment function
"nnoremap <silent>  ;=  :AlignAssignments<CR>
nnoremap <silent> ga :<c-u>call <sid>align_around_delimiter()<CR>

" -------------------------------------------------------------------------------
" prettier
" -------------------------------------------------------------------------------
if executable("prettier")
    nnoremap <silent> <Leader>pt mm:silent %!prettier --stdin-filepath % --trailing-comma all --single-quote<CR>`m:delmarks m<CR>zz
    nnoremap <silent> <Leader>pta mm:bufdo silent %!prettier --stdin-filepath % --trailing-comma all --single-quote<CR>`m:delmarks m<CR>zz
else
    nnoremap <Leader>pt :echo "prettier is not installed"<CR>
    nnoremap <Leader>pta :echo "prettier is not installed"<CR>
endif

" -------------------------------------------------------------------------------
" Surround
" -------------------------------------------------------------------------------
nnoremap cs({ m1F(m2%r}`2r{`1
nnoremap cs{( m1F{m2%r)`2r(`1
nnoremap cs([ m1F(m2%r]`2r[`1
nnoremap cs[( m1F[m2%r)`2r(`1
nnoremap cs[{ m1F[m2%r}`2r{`1
nnoremap cs{[ m1F{m2%r]`2r[`1

vnoremap S# "zdi#<C-R>z#<Esc>
vnoremap S* "zdi*<C-R>z*<Esc>
vnoremap S" "zdi"<C-R>z"<Esc>
vnoremap S' "zdi'<C-R>z'<Esc>
vnoremap S( "zdi(<C-R>z)<Esc>
vnoremap S{ "zdi{<C-R>z}<Esc>
vnoremap S[ "zdi[<C-R>z]<Esc>

" -------------------------------------------------------------------------------
" Search in project
" -------------------------------------------------------------------------------
command! -nargs=+ -complete=file_in_path -bar Grep  silent! grep! <args> | redraw!
command! -nargs=+ -complete=file_in_path -bar LGrep silent! lgrep! <args> | redraw!

"cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
"cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

nnoremap ;f :find <Right>
nnoremap ;g :Grep <C-r><C-w><CR>
xnoremap <Leader>g :<C-u>let cmd = "Grep " . visual#GetSelection() <bar>
                        \ call histadd("cmd", cmd) <bar>
                        \ exe cmd<CR>

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("ag")
    set grepprg=ag\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" smooth listing
cnoremap <expr> <CR> CCR()

" -------------------------------------------------------------------------------
" nvim
" -------------------------------------------------------------------------------
if has('nvim') || has('terminal')
    "command! Term terminal
    "command! VTerm vnew | terminal

    tnoremap <Esc> <C-\><C-n>
    "tnoremap <a-a> <Esc>a
    "tnoremap <a-b> <Esc>b
    "tnoremap <a-d> <Esc>d
    "tnoremap <a-f> <Esc>f
endif

""" }}}

""" === plugin config === {{{

" -------------------------------------------------------------------------------
" netrw
" -------------------------------------------------------------------------------
"let g:netrw_altv         = 1 " open splits to the right
"let g:netrw_browse_split = 4 " open in prior window
"let g:netrw_liststyle    = 1 " Detail View
let g:netrw_banner      = 0                      " disable annoying banner
let g:netrw_bufsettings = 'relativenumber'
let g:netrw_hide        = 1                      " hide dotfiles by default
let g:netrw_list_hide   = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles
let g:netrw_list_hide   = netrw_gitignore#Hide()
let g:netrw_liststyle   = 3                      " tree view
let g:netrw_preview     = 1
let g:netrw_sizestyle   = "H"                    " Human-readable file sizes
let g:netrw_winsize     = 30

""" }}}
