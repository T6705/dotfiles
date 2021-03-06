" vim:foldmethod=marker:foldlevel=0

""" === augroup === {{{

augroup configgroup
    au!
    au BufRead,BufNewFile *.md setlocal spell "automatically turn on spell-checking for Markdown files
    au BufRead,BufNewFile *.txt setlocal spell "automatically turn on spell-checking for text files

    " Restore cursor position when opening file
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

    au FileType java setlocal omnifunc=javacomplete#Complete
    au FileType php setlocal omnifunc=phpcomplete#CompletePHP
    au FocusGained *: redraw!     " Redraw screen every time when focus gained
    au FocusLost *: wa            " Set vim to save the file on focus out
    au InsertLeave * silent! set nopaste
    au VimResized * wincmd =
    au! BufWritePre * %s/\s\+$//e " Automatically removing all trailing whitespace
augroup END

augroup Snippet
    au FileType java call JavaAbbrev()
    au FileType cpp call CppAbbrev()
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
augroup END

augroup autoSaveAndRead
    au!
    au TextChanged,InsertLeave,FocusLost * silent! wall
    au CursorHold * silent! checktime
augroup END
""" }}}

""" === General Setting === {{{

if executable('python2')
    let g:python_host_prog = '/usr/bin/python2'
endif
if executable('python3')
    let g:python3_host_prog = '/usr/bin/python3'
endif

let mapleader=' '

let g:loaded_matchparen = 1 " Highlighting matching parens
let php_htmlInStrings   = 1
let php_sql_query       = 1

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
"set title
"set titleold="Terminal"
"set titlestring=%F
set ttyfast                                                       " faster redrawing
if has('syntax') && !exists('g:syntax_on')
    "syntax enable
    syntax on                                                         " switch syntax highlighting on
endif

if has('nvim') && has('termguicolors')
  set termguicolors
endif

" ----------------------------------------------------------------------------------------
" statusline
" ----------------------------------------------------------------------------------------
""" === basic statusline === {{{
set statusline=
set statusline+=%0*\ [%n]                            " buffernr
set statusline+=%0*\ %<%F\                           " File+path
set statusline+=%1*\ %y\                             " FileType
set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''} " Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\       " Encoding2
set statusline+=%4*\ %{&ff}\                         " FileFormat (dos/unix..)
set statusline+=%5*\ %=\ row:%l/%L\        " Rownumber/total (%)
set statusline+=%6*\ col:%03c\                       " Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                 " Modified? Readonly? Top/bot.

hi User1 ctermfg=red ctermbg=black
hi User2 ctermfg=blue ctermbg=black
hi User3 ctermfg=green ctermbg=black
hi User4 ctermfg=yellow ctermbg=black
hi User5 ctermfg=cyan ctermbg=black
hi User6 ctermfg=magenta ctermbg=black
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

" Completion for spellings
"set spell
set complete+=kspell

" Use persistent history, Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let undo_dir = expand('~/.vim-undo-dir')
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
set guioptions=egmrti
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=M

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
    set gfn=Knack\ Nerd\ Font\ Mono\ 10,Hack\ 10
else
    set gfn=Knack\ Nerd\ Font\ Mono\ 10,Hack\ 10
endif

if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8 " Set utf8 as standard encoding and en_US as the standard language
endif
""" }}}


""" === Functions === {{{

" ----------------------------------------------------------------------------------------
" :Shuffle | Shuffle selected lines
" ----------------------------------------------------------------------------------------
fu! s:shuffle() range
ruby << RB
  first, last = %w[a:firstline a:lastline].map { |e| VIM::evaluate(e).to_i }
  (first..last).map { |l| $curbuf[l] }.shuffle.each_with_index do |line, i|
    $curbuf[first + i] = line
  end
RB
endfu
command! -range Shuffle <line1>,<line2>call s:shuffle()

" ----------------------------------------------------------------------------------------
" :ClearRegisters
" ----------------------------------------------------------------------------------------
fu! ClearRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
endfu
command! ClearRegisters call ClearRegisters()

" ----------------------------------------------------------------------------------------
" :RangerExplorer (vim only)
" ----------------------------------------------------------------------------------------
fu RangerExplorer()
    if executable("ranger")
        exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
        if filereadable('/tmp/vim_ranger_current_file')
            exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
            call system('rm /tmp/vim_ranger_current_file')
        endif
        redraw!
    endif
endfu

" ----------------------------------------------------------------------------
" :EX | chmod +x
" ----------------------------------------------------------------------------
command! EX if !empty(expand('%'))
         \|   write
         \|   call system('chmod +x '.expand('%'))
         \|   silent e
         \| else
         \|   echohl WarningMsg
         \|   echo 'Save the file first'
         \|   echohl None
        \| endif

" ----------------------------------------------------------------------------------------
" :WordProcessorMode
" ----------------------------------------------------------------------------------------
fu! WordProcessorMode()
    setlocal textwidth=80
    setlocal smartindent
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfu
command! WordProcessorMode call WordProcessorMode()

" ----------------------------------------------------------------------------------------
" :ChangeEncoding
" ----------------------------------------------------------------------------------------
fu! ChangeEncoding()
    if executable("file")
        let result = system("file " . escape(escape(escape(expand("%"), ' '), '['), ']'))
        if result =~ "Little-endian UTF-16" && &enc != "utf-16le"
            exec "e ++enc=utf-16le"
        elseif result =~ "ISO-8859" && &enc != "iso-8859-1"
            exec "e ++enc=iso-8859-1"
        endif
    endif
endfu
command! ChangeEncoding call ChangeEncoding()

" ----------------------------------------------------------------------------------------
" :HandleSpecialFile
" ----------------------------------------------------------------------------------------
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

" ----------------------------------------------------------------------------------------
" :Hexmode
" ----------------------------------------------------------------------------------------
fu ToggleHex()
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

" ----------------------------------------------------------------------------------------
" :OpenUrl
" ----------------------------------------------------------------------------------------
fu! HandleURL()
    if executable("firefox")
        "let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
        let s:uri = matchstr(getline("."), '\(http\|https\|ftp\)://[a-zA-Z0-9][a-zA-Z0-9_-]*\(\.[a-zA-Z0-9][a-zA-Z0-9_-]*\)*\(:\d\+\)\?\(/[a-zA-Z0-9_/.\-+%?&=;@$,!''*~]*\)\?\(#[a-zA-Z0-9_/.\-+%#?&=;@$,!''*~]*\)\?')

        echo s:uri
        if s:uri != ""
            "silent exec "!elinks '".s:uri."'"
            silent exec "!firefox '".s:uri."'"
        else
            echo "No URI found in line."
        endif
    endif
endfu
command! OpenUrl call HandleURL()

" ----------------------------------------------------------------------------------------
" :ShowMeUrl
" ----------------------------------------------------------------------------------------
fu! ShowMeUrl()
    %!grep -oE "(http[s]?|ftp|file)://[a-zA-Z0-9][a-zA-Z0-9_-]*(\.[a-zA-Z0-9][a-zA-Z0-9_-]*)*(:\d\+)?(\/[a-zA-Z0-9_/.\-+%?&=;@$,\!''*~-]*)?(\#[a-zA-Z0-9_/.\-+%\#?&=;@$,\!''*~]*)?"
    silent exec "sort u"
    silent exec "%s/'$//g"
endfu
command! ShowMeUrl call ShowMeUrl()

" ----------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" ----------------------------------------------------------------------------
fu! s:root()
    let root = systemlist('git rev-parse --show-toplevel')[0]
    if v:shell_error
        echo 'Not in git repo'
    else
        execute 'lcd' root
        echo 'Changed directory to: '.root
    endif
endfu
command! Root call s:root()

" ----------------------------------------------------------------------------
" autofold
" ----------------------------------------------------------------------------
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

function! JavaAbbrev()
  inoreabbr psvm public static void main(String[] args){<CR>}<esc>k:call getchar()<cr>
  inoreabbr sop System.out.println("%");<esc>F%s<c-o>:call getchar()<cr>
  inoreabbr sep System.err.println("%");<esc>F%s<c-o>:call getchar()<cr>
  inoreabbr try try {<CR>} catch (Exception e) {<CR> e.printStackTrace();<CR>}<esc>3k:call getchar()<cr>
  inoreabbr ctm System.currentTimeMillis()
endfunction

function! CppAbbrev()
  inoreabbr inc #include <><esc>i<c-o>:call getchar()<cr>
  inoreabbr main int main() {}<esc>i<cr><esc>Oreturn 0;<esc>O<esc>k:call getchar()<cr>
  inoreabbr amain int main(int argc, char* argv[]) {}<esc>i<cr><esc>Oreturn 0;<esc>O<esc>k:call getchar()<cr>
endfunction

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
nnoremap <silent> N Nzz
nnoremap <silent> [[ [[zz
nnoremap <silent> [] []zz
nnoremap <silent> ][ ][zz
nnoremap <silent> ]] ]]zz
nnoremap <silent> g; g;zz " go to place of last change
nnoremap <silent> gV `[v`] " highlight last inserted text
nnoremap <silent> gg :norm! ggzz<CR>
nnoremap <silent> g= mmgg=G`m
nnoremap <silent> gQ mmgggqG`m
nnoremap <silent> n nzz
nnoremap <silent> { {zz
nnoremap <silent> } }zz

" Jump to matching pairs easily, with Shift-Tab
nmap <silent> <S-Tab> %
vmap <silent> <S-Tab> %

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

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
"nnoremap <silent> [l :lprev<CR> " Neomake
"nnoremap <silent> ]l :lnext<CR> " Neomake
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
nnoremap <silent> <Leader>bs :ls<CR>:buffer<Space>
nnoremap <silent> <Leader>vbs :ls<CR>:sbuffer<Space>
nnoremap <silent> <bs> <c-^>

" add space after comma
nnoremap <silent> <Leader>, :%s/, */, /g<CR>
vnoremap <silent> <Leader>, :s/, */, /g<CR>

" Explore dir
if exists(":Lexplore") != 1
    nnoremap <silent> <Leader>E :Lexplore<CR>
elseif exists(":Vexplore") != 1
    nnoremap <silent> <Leader>E :Vexplore<CR>
else
    nnoremap <silent> <Leader>E :Explore<CR>
endif

" Completetion
inoremap <silent> ,f <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",:"<CR>
inoremap <silent> ,l <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",="<CR>
inoremap <silent> ,n <C-x><C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",;"<CR>
inoremap <silent> ,o <C-x><C-o><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",,"<CR>

" folding
nnoremap <silent> <Leader>f za<CR>
vnoremap <silent> <Leader>f za<CR>

" Make the dot command work as expected in visual mode (via
" https://www.reddit.com/r/vim/comments/3y2mgt/do_you_have_any_minor_customizationsmappings_that/cya0x04)
vnoremap . :norm.<CR>

" Markdown headings
nnoremap <silent> <Leader>1 m`yypVr=``
nnoremap <silent> <Leader>2 m`yypVr-``
nnoremap <silent> <Leader>3 m`^i### <esc>``4l
nnoremap <silent> <Leader>4 m`^i#### <esc>``5l
nnoremap <silent> <Leader>5 m`^i##### <esc>``6l

" Make check spelling on or off
nnoremap <silent> <Leader>cson   :set spell<CR>
nnoremap <silent> <Leader>csoff :set nospell<CR>

" search and replace
nnoremap <silent> <Leader>sr  :'{,'}s/\<<C-r>=expand('<cword>')<CR>\>/
nnoremap <silent> <Leader>sra :%s/\<<C-r>=expand('<cword>')<CR>\>/

nnoremap <silent> <Leader>rp /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap <silent> <Leader>RP ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN
nnoremap <silent> <Leader>dw /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgn
nnoremap <silent> <Leader>DW ?\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgN

" ----------------------------------------------------------------------------------------
" Surround
" ----------------------------------------------------------------------------------------
nnoremap cs({ m1F(m2%r}`2r{`1
nnoremap cs{( m1F{m2%r)`2r(`1
nnoremap cs([ m1F(m2%r]`2r[`1
nnoremap cs[( m1F[m2%r)`2r(`1
nnoremap cs[{ m1F[m2%r}`2r{`1
nnoremap cs{[ m1F{m2%r]`2r[`1

vnoremap S# "zdi#<C-R>z#<esc>
vnoremap S* "zdi*<C-R>z*<esc>
vnoremap S" "zdi"<C-R>z"<esc>
vnoremap S' "zdi'<C-R>z'<esc>
vnoremap S( "zdi(<C-R>z)<esc>
vnoremap S{ "zdi{<C-R>z}<esc>
vnoremap S[ "zdi[<C-R>z]<esc>

" ----------------------------------------------------------------------------------------
" Search in project
" ----------------------------------------------------------------------------------------
command! -nargs=+ -complete=file_in_path -bar Grep  silent! grep! <args> | redraw!
command! -nargs=+ -complete=file_in_path -bar LGrep silent! lgrep! <args> | redraw!

nnoremap <silent> <Leader>G :Grep <C-r><C-w><CR>
xnoremap <silent> <Leader>G :<C-u>let cmd = "Grep " . visual#GetSelection() <bar>
                        \ call histadd("cmd", cmd) <bar>
                        \ execute cmd<CR>

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("ag")
    set grepprg=ag\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ----------------------------------------------------------------------------------------
" nvim
" ----------------------------------------------------------------------------------------
if has('nvim')
    "command! Term terminal
    "command! VTerm vnew | terminal

    tnoremap <Esc> <C-\><C-n>
    "tnoremap <a-a> <esc>a
    "tnoremap <a-b> <esc>b
    "tnoremap <a-d> <esc>d
    "tnoremap <a-f> <esc>f
endif

""" }}}

""" === plugin config === {{{

" ----------------------------------------------------------------------------------------
" netrw
" ----------------------------------------------------------------------------------------
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
