" vim:foldmethod=marker:foldlevel=0

""" === augroup === {{{

augroup configgroup
    au!
    au BufRead * call ChangeEncoding()
    au BufNewFile * call SetTitle()
    au BufNewFile * normal G
    au BufRead,BufNewFile *.{md,notes,todo,txt} setlocal spell " automtically turn on spell-checking
    au BufReadPost quickfix nnoremap <buffer> <Left> :Qolder<CR>
    au BufReadPost quickfix nnoremap <buffer> <Right> :Qnewer<CR>
    au BufWinEnter *.{doc,docx,epub,odp,odt,pdf,rtf} call HandleSpecialFile()
    au BufWritePost .vimrc,.vimrc.local,init.vim source %
    au BufWritePost .vimrc.local source %
    au FileType json setlocal equalprg=python\ -m\ json.tool
    au FileType markdown syntax sync fromstart
    au FocusGained *: redraw!     " Redraw screen every time when focus gained
    au FocusLost *: wa            " Set vim to save the file on focus out
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
    au BufRead,BufNewFile *.{css,html,js} setlocal formatprg=prettier\ --stdin\ --single-quote\ --trailing-comma
    au BufRead,BufNewFile *.{html,js,xml} CompleteTags
augroup END

" Close vim if the only window left open is a NERDTree or quickfix
augroup finalcountdown
    au!
    au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) || &buftype == 'quickfix' | q | endif
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
    au FileType java call JavaConfig()
    au FileType cpp call CppConfig()
    au BufRead,BufNewFile *.{tmpl,htm,js} call JavascriptConfig()
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

augroup auto_quickfix_window
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

set completeopt=longest,menuone,preview
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

" Completion for spellings
"set spell
set complete+=kspell
set ofu=syntaxcomplete#Complete " Set omni-completion method

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
" text object
" -------------------------------------------------------------------------------
" regular expressions that match numbers (order matters .. keep '\d' last!)
" note: \+ will be appended to the end of each
let s:regNums = [ '0b[01]', '0x\x', '\d' ]

fu! s:inNumber()
    " select the next number on the line
    " this can handle the following three formats (so long as s:regNums is
    " defined as it should be above this function):
    "   1. binary  (eg: "0b1010", "0b0000", etc)
    "   2. hex     (eg: "0xffff", "0x0000", "0x10af", etc)
    "   3. decimal (eg: "0", "0000", "10", "01", etc)
    " NOTE: if there is no number on the rest of the line starting at the
    "       current cursor position, then visual selection mode is ended (if
    "       called via an omap) or nothing is selected (if called via xmap)

    " need magic for this to work properly
    let l:magic = &magic
    set magic

    let l:lineNr = line('.')

    " create regex pattern matching any binary, hex, decimal number
    let l:pat = join(s:regNums, '\+\|') . '\+'

    " move cursor to end of number
    if (!search(l:pat, 'ce', l:lineNr))
        " if it fails, there was not match on the line, so return prematurely
        return
    endif

    " start visually selecting from end of number
    normal! v

    " move cursor to beginning of number
    call search(l:pat, 'cb', l:lineNr)

    " restore magic
    let &magic = l:magic
endfu

fu! s:aroundNumber()
    " select the next number on the line and any surrounding white-space;
    " this can handle the following three formats (so long as s:regNums is
    " defined as it should be above these functions):
    "   1. binary  (eg: "0b1010", "0b0000", etc)
    "   2. hex     (eg: "0xffff", "0x0000", "0x10af", etc)
    "   3. decimal (eg: "0", "0000", "10", "01", etc)
    " NOTE: if there is no number on the rest of the line starting at the
    "       current cursor position, then visual selection mode is ended (if
    "       called via an omap) or nothing is selected (if called via xmap);
    "       this is true even if on the space following a number

    " need magic for this to work properly
    let l:magic = &magic
    set magic

    let l:lineNr = line('.')

    " create regex pattern matching any binary, hex, decimal number
    let l:pat = join(s:regNums, '\+\|') . '\+'

    " move cursor to end of number
    if (!search(l:pat, 'ce', l:lineNr))
        " if it fails, there was not match on the line, so return prematurely
        return
    endif

    " move cursor to end of any trailing white-space (if there is any)
    call search('\%'.(virtcol('.')+1).'v\s*', 'ce', l:lineNr)

    " start visually selecting from end of number + potential trailing whitspace
    normal! v

    " move cursor to beginning of number
    call search(l:pat, 'cb', l:lineNr)

    " move cursor to beginning of any white-space preceding number (if any)
    call search('\s*\%'.virtcol('.').'v', 'b', l:lineNr)

    " restore magic
    let &magic = l:magic
endfu

fu! s:inIndentation()
    " select all text in current indentation level excluding any empty lines
    " that precede or follow the current indentationt level;
    "
    " the current implementation is pretty fast, even for many lines since it
    " uses "search()" with "\%v" to find the unindented levels
    "
    " NOTE: if the current level of indentation is 1 (ie in virtual column 1),
    "       then the entire buffer will be selected
    "
    " WARNING: python devs have been known to become addicted to this

    " magic is needed for this
    let l:magic = &magic
    set magic

    " move to beginning of line and get virtcol (current indentation level)
    " BRAM: there is no searchpairvirtpos() ;)
    normal! ^
    let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

    " pattern matching anything except empty lines and lines with recorded
    " indentation level
    let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

    " find first match (backwards & don't wrap or move cursor)
    let l:start = search(l:pat, 'bWn') + 1

    " next, find first match (forwards & don't wrap or move cursor)
    let l:end = search(l:pat, 'Wn')

    if (l:end !=# 0)
        " if search succeeded, it went too far, so subtract 1
        let l:end -= 1
    endif

    " go to start (this includes empty lines) and--importantly--column 0
    exe 'normal! '.l:start.'G0'

    " skip empty lines (unless already on one .. need to be in column 0)
    call search('^[^\n\r]', 'Wc')

    " go to end (this includes empty lines)
    exe 'normal! Vo'.l:end.'G'

    " skip backwards to last selected non-empty line
    call search('^[^\n\r]', 'bWc')

    " go to end-of-line 'cause why not
    normal! $o

    " restore magic
    let &magic = l:magic
endfu

fu! s:aroundIndentation()
    " select all text in the current indentation level including any emtpy
    " lines that precede or follow the current indentation level;
    "
    " the current implementation is pretty fast, even for many lines since it
    " uses "search()" with "\%v" to find the unindented levels
    "
    " NOTE: if the current level of indentation is 1 (ie in virtual column 1),
    "       then the entire buffer will be selected
    "
    " WARNING: python devs have been known to become addicted to this

    " magic is needed for this (/\v doesn't seem work)
    let l:magic = &magic
    set magic

    " move to beginning of line and get virtcol (current indentation level)
    " BRAM: there is no searchpairvirtpos() ;)
    normal! ^
    let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

    " pattern matching anything except empty lines and lines with recorded
    " indentation level
    let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

    " find first match (backwards & don't wrap or move cursor)
    let l:start = search(l:pat, 'bWn') + 1

    " NOTE: if l:start is 0, then search() failed; otherwise search() succeeded
    "       and l:start does not equal line('.')
    " FORMER: l:start is 0; so, if we add 1 to l:start, then it will match
    "         everything from beginning of the buffer (if you don't like
    "         this, then you can modify the code) since this will be the
    "         equivalent of "norm! 1G" below
    " LATTER: l:start is not 0 but is also not equal to line('.'); therefore,
    "         we want to add one to l:start since it will always match one
    "         line too high if search() succeeds

    " next, find first match (forwards & don't wrap or move cursor)
    let l:end = search(l:pat, 'Wn')

    " NOTE: if l:end is 0, then search() failed; otherwise, if l:end is not
    "       equal to line('.'), then the search succeeded.
    " FORMER: l:end is 0; we want this to match until the end-of-buffer if it
    "         fails to find a match for same reason as mentioned above;
    "         again, modify code if you do not like this); therefore, keep
    "         0--see "NOTE:" below inside the if block comment
    " LATTER: l:end is not 0, so the search() must have succeeded, which means
    "         that l:end will match a different line than line('.')

    if (l:end !=# 0)
        " if l:end is 0, then the search() failed; if we subtract 1, then it
        " will effectively do "norm! -1G" which is definitely not what is
        " desired for probably every circumstance; therefore, only subtract one
        " if the search() succeeded since this means that it will match at least
        " one line too far down
        " NOTE: exe "norm! 0G" still goes to end-of-buffer just like "norm! G",
        "       so it's ok if l:end is kept as 0. As mentioned above, this means
        "       that it will match until end of buffer, but that is what I want
        "       anyway (change code if you don't want)
        let l:end -= 1
    endif

    " finally, select from l:start to l:end
    exe 'normal! '.l:start.'G0V'.l:end.'G$o'

    " restore magic
    let &magic = l:magic
endfu

" -------------------------------------------------------------------------------
" colder quickfix list
" -------------------------------------------------------------------------------
fu! s:isLocation()
    " Get dictionary of properties of the current window
    let wininfo = filter(getwininfo(), {i,v -> v.winnr == winnr()})[0]
    return wininfo.loclist
endfu

fu! s:length()
    " Get the size of the current quickfix/location list
    return len(s:isLocation() ? getloclist(0) : getqflist())
endfu

fu! s:getProperty(key, ...)
    " getqflist() and getloclist() expect a dictionary argument
    " If a 2nd argument has been passed in, use it as the value, else 0
    let l:what = {a:key : a:0 ? a:1 : 0}
    let l:listdict = s:isLocation() ? getloclist(0, l:what) : getqflist(l:what)
    return get(l:listdict, a:key)
endfu

fu! s:isFirst()
    return s:getProperty('nr') <= 1
endfu

fu! s:isLast()
    return s:getProperty('nr') == s:getProperty('nr', '$')
endfu

fu! s:history(goNewer)
    " Build the command: one of colder/cnewer/lolder/lnewer
    let l:cmd = (s:isLocation() ? 'l' : 'c') . (a:goNewer ? 'newer' : 'older')

    " Apply the cmd repeatedly until we hit a non-empty list, or first/last list
    " is reached
    while 1
        if (a:goNewer && s:isLast()) || (!a:goNewer && s:isFirst()) | break | endif
        " Run the command. Use :silent to suppress message-history output.
        " Note that the :try wrapper is no longer necessary
        silent exe l:cmd
        if s:length() | break | endif
    endwhile

    " Set the height of the quickfix window to the size of the list, max-height 10
    exe 'resize' min([ 10, max([ 1, s:length() ]) ])

    " Echo a description of the new quickfix / location list.
    " And make it look like a rainbow.
    let l:nr = s:getProperty('nr')
    let l:last = s:getProperty('nr', '$')
    echohl MoreMsg | echon '('
    echohl Identifier | echon l:nr
    if l:last > 1
        echohl LineNr | echon ' of '
        echohl Identifier | echon l:last
    endif
    echohl MoreMsg | echon ') '
    echohl MoreMsg | echon '['
    echohl Identifier | echon s:length()
    echohl MoreMsg | echon '] '
    echohl Normal | echon s:getProperty('title')
    echohl None
endfu

command! Qolder call s:history(0)
command! Qnewer call s:history(1)

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
" :RangerExplorer (vim only)
" -------------------------------------------------------------------------------
if ! has('nvim')
    fu! RangerExplorer()
        if executable("ranger")
            exe "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
            if filereadable('/tmp/vim_ranger_current_file')
                exe 'edit ' . system('cat /tmp/vim_ranger_current_file')
                call system('rm /tmp/vim_ranger_current_file')
            endif
            redraw!
        endif
    endfu
    command! RangerExplorer call RangerExplorer()
endif

" -------------------------------------------------------------------------------
" :EX | chmod +x
" -------------------------------------------------------------------------------
command! EX if !empty(expand('%'))
         \|   write
         \|   call system('chmod +x '.expand('%'))
         \|   silent e
         \| else
         \|   echohl WarningMsg
         \|   echo 'Save the file first'
         \|   echohl None
         \| endif

" -------------------------------------------------------------------------------
" compile_and_run | <Leader>cr
" -------------------------------------------------------------------------------
fu! Compile_and_Run()
    if has('terminal')
        exe 'w'
        let l:r=15
        let l:name="vim-term"
        let l:opts = {}
        let l:opts.term_name = l:name
        let l:opts.term_rows = l:r
        let l:cmd = ''
        if &filetype == 'c'
            echo 'compiling'
            exe "!time gcc -O3 -Wall -Wextra % -o %<"
            let l:cmd="time ".expand('%:p:r')
        elseif &filetype == 'c'
            echo 'compiling'
            exe "!time g++ -O3 -Wall -Wextra -std=c++11 % -o %<"
            let l:cmd="time ".expand('%:p:r')
        elseif &filetype == 'java'
            exe 'cd %:p:h'
            echo 'compiling'
            exe '!time javac %'
            let l:cmd="time java ".expand('%<')
        elseif &filetype == 'sh'
            "exe 'term ++rows='.r.'time bash '.expand('%')
            let l:cmd="bash ".expand('%')
        elseif &filetype == 'php'
            "exe 'term ++rows='.r.'time php '.expand('%')
            let l:cmd="php ".expand('%')
        elseif &filetype == 'python'
            "exe 'term ++rows='.r.'time python3 '.expand('%')
            let l:cmd="python3 ".expand('%')
        elseif &filetype == 'go'
            "exe 'term ++rows='.r.'time go run '.expand('%')
            let l:cmd="go run ".expand('%')
        else
            let l:cmd=$SHELL
        endif
        if &buftype == 'terminal'
            let l:opts.curwin = v:true
        else
            let l:windowsWithTerminal = filter(range(1, winnr('$')), 'getwinvar(v:val, "&buftype") == "terminal"')
            if !empty(l:windowsWithTerminal)
                exe l:windowsWithTerminal[0] . 'wincmd w'
                let l:opts.curwin = v:true
            endif
        endif
        call term_start(l:cmd, l:opts)
        exe 'wincmd k'
    else
        echo "no terminal =["
    endif
endfu
command! CompileandRun call Compile_and_Run()

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
    elseif expand("%:e") == 'py'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# -*- coding: utf-8 -*-")
        call append(line(".")+1, "")
    elseif expand("%:e") == 'rb'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")
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
" :HandleSpecialFile
" -------------------------------------------------------------------------------
fu! HandleSpecialFile()
    if get(b:, 'did_filter_special_file', 0)
        return
    endif
    let fname = shellescape(expand('%:p'), 1)
    let ext = expand('%:e')
    let ext2cmd = {
    \               'doc' : '%!antiword '.fname,
    \               'docx': '%!pandoc -f docx -t markdown '.fname,
    \               'epub': '%!pandoc -f epub -t markdown '.fname,
    \               'odp' : '%!odt2txt '.fname,
    \               'odt' : '%!odt2txt '.fname,
    \               'pdf' : '%!pdftotext -nopgbrk -layout -q -eol unix '.fname.' -',
    \               'rtf' : '%!unrtf --text',
    \             }
    if has_key(ext2cmd, ext)
        setl ma noro
        sil exe ext2cmd[ext]
        let b:did_filter_special_file = 1
        setl noma ro nomod
    endif
endfu
command! HandleSpecialFile call HandleSpecialFile()

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
" :OpenUrl
" -------------------------------------------------------------------------------
fu! HandleURL()
    let s:uri = matchstr(getline("."), '\(http\|https\|ftp\)://[a-zA-Z0-9][a-zA-Z0-9_-]*\(\.[a-zA-Z0-9][a-zA-Z0-9_-]*\)*\(:\d\+\)\?\(/[a-zA-Z0-9_/.\-+%?&=;@$,!''*~]*\)\?\(#[a-zA-Z0-9_/.\-+%#?&=;@$,!''*~]*\)\?')

    echo s:uri
    if s:uri != ""
        if executable("firefox")
            silent exe "!firefox '".s:uri."'"
        elseif executable("chromium")
            silent exe "!chromium'".s:uri."'"
        elseif executable("qutebrowser")
            silent exe "!qutebrowser'".s:uri."'"
        else
            echo "no browser available"
        endif
    else
        echo "No url found in line."
    endif
    redraw!
    redraws!
endfu
command! OpenUrl call HandleURL()

" -------------------------------------------------------------------------------
" :ShowMeUrl
" -------------------------------------------------------------------------------
fu! ShowMeUrl()
    %!grep -oE "(http[s]?|ftp|file)://[a-zA-Z0-9][a-zA-Z0-9_-]*(\.[a-zA-Z0-9][a-zA-Z0-9_-]*)*(:\d\+)?(\/[a-zA-Z0-9_/.\-+%?&=;@$,\!''*~-]*)?(\#[a-zA-Z0-9_/.\-+%\#?&=;@$,\!''*~]*)?"
    silent exe "sort u"
    silent exe "%s/'$//g"
endfu
command! ShowMeUrl call ShowMeUrl()

" -------------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" -------------------------------------------------------------------------------
fu! s:root()
    let root = systemlist('git rev-parse --show-toplevel')[0]
    if v:shell_error
        echo 'Not in git repo'
    else
        exe 'lcd' root
        echo 'Changed directory to: '.root
    endif
endfu
command! Root call s:root()

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

fu! JavaConfig()
    inorea <buffer> psvm public static void main(String[] args){<CR>}<Esc>k:call getchar()<CR>
    inorea <buffer> sop System.out.println("%");<Esc>F%s<C-o>:call getchar()<CR>
    inorea <buffer> sep System.err.println("%");<Esc>F%s<C-o>:call getchar()<CR>
    inorea <buffer> try try {<CR>} catch (Exception e) {<CR> e.printStackTrace();<CR>}<Esc>3k:call getchar()<CR>
    inorea <buffer> ctm System.currentTimeMillis()
endfu

fu! CppConfig()
    inorea <buffer> inc #include <><Esc>i<C-o>:call getchar()<CR>
    inorea <buffer> main int main() {}<Esc>i<CR><Esc>Oreturn 0;<Esc>O<Esc>k:call getchar()<CR>
    inorea <buffer> amain int main(int argc, char* argv[]) {}<Esc>i<CR><Esc>Oreturn 0;<Esc>O<Esc>k:call getchar()<CR>
endfu

fu! JavascriptConfig()
    inorea <buffer> csl console.log("")<Esc>==f"ci"
    inorea <buffer> csi console.info("")<Esc>==f"ci"
    inorea <buffer> csw console.warn("")<Esc>==f"ci"
    inorea <buffer> cse console.error("")<Esc>==f"ci"
endfu

fu! PythonConfig()
    inorea <buffer> ifmain if __name__ == "__main__":<CR>main()<Esc>
    inorea <buffer> try: try:<CR>pass<CR>except Exception as e:<CR>tb    = sys.exc_info()[-1]<CR>stk   = traceback.extract_tb(tb, 1)<CR>fname = stk[0][2]<CR>now   = time.ctime()<CR>print("{} >>> {}, {}, {}".format(now, fname, type(e), str(e)))<CR>

    " -------------------------------------------------------------------------------
    " isort
    " -------------------------------------------------------------------------------
    if executable("isort")
        nnoremap <silent> <Leader>is :%!isort -<CR>
    else
        nnoremap <Leader>is :echo "isort is not installed"<CR>
    endif

    " -------------------------------------------------------------------------------
    " yapf
    " -------------------------------------------------------------------------------
    if executable("yapf")
        nnoremap <Leader>fx :0,$!yapf<CR>
    else
        nnoremap <Leader>fx :echo "yapf is not installed"<CR>
    endif

endfu

fu! CompleteTags()
    if has('nvim')
        inoremap <buffer> > ></<C-x><C-o><C-n><Cr><Esc>:startinsert!<CR><C-O>?</<CR>
        inoremap <buffer> ><CR> ></<C-x><C-o><C-n><Cr><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
    else
        inoremap <buffer> > ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR>
        inoremap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
    endif
    inoremap <buffer> ><Leader> >
endfu
command! CompleteTags call CompleteTags()

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

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" :J json prettify
command! J :%!python -m json.tool

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
xnoremap J :m '>+1<CR>gv=gv
xnoremap K :m '<-2<CR>gv=gv

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

" Explore dir with ranger
if executable("ranger")
    nnoremap <silent> <Leader>E :RangerExplorer<CR>
elseif exists(":Lexplore") != 1
    nnoremap <silent> <Leader>E :Lexplore<CR>
elseif exists(":Vexplore") != 1
    nnoremap <silent> <Leader>E :Vexplore<CR>
else
    nnoremap <silent> <Leader>E :Explore<CR>
endif

" Completetion

" Use <Tab> and <S-Tab> for navigate completion list:
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <enter> to confirm complete
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

inoremap ,, <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>

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
    nnoremap <silent> <Leader>pt mm:silent %!prettier --stdin --stdin-filepath % --trailing-comma all --single-quote<CR>`m:delmarks m<CR>zz
else
    nnoremap <Leader>pt :echo "prettier is not installed"<CR>
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
" text object
" -------------------------------------------------------------------------------
" "in line" (entire line sans white-space; cursor at beginning--ie, ^)
xnoremap <silent> il :<C-u>normal! g_v^<CR>
onoremap <silent> il :<C-u>normal! g_v^<CR>
" "around line" (entire line sans trailing newline; cursor at beginning--ie, 0)
xnoremap <silent> al :<C-u>normal! $v0<CR>
onoremap <silent> al :<C-u>normal! $v0<CR>
" "in document" (from first line to last; cursor at top--ie, gg)
xnoremap <silent> id :<C-u>normal! G$Vgg0<CR>
onoremap <silent> id :<C-u>normal! GVgg<CR>
" "in number" (next number after cursor on current line)
xnoremap <silent> in :<C-u>call <sid>inNumber()<CR>
onoremap <silent> in :<C-u>call <sid>inNumber()<CR>
" "around number" (next number on line and possible surrounding white-space)
xnoremap <silent> an :<C-u>call <sid>aroundNumber()<CR>
onoremap <silent> an :<C-u>call <sid>aroundNumber()<CR>
" "in indentation" (indentation level sans any surrounding empty lines)
xnoremap <silent> ii :<C-u>call <sid>inIndentation()<CR>
onoremap <silent> ii :<C-u>call <sid>inIndentation()<CR>
" "around indentation" (indentation level and any surrounding empty lines)
xnoremap <silent> ai :<C-u>call <sid>aroundIndentation()<CR>
onoremap <silent> ai :<C-u>call <sid>aroundIndentation()<CR>

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
