" vim:foldmethod=marker:foldlevel=0

""" === augroup === {{{

augroup configgroup
    au!

    "" Open NERDTree automatically when vim starts up if no files were specified
    "au StdinReadPre * let s:std_in=1
    "au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    "au FileType text Goyo
    "au FileType text Limelight

    "au InsertEnter,WinLeave * set nocursorline
    "au InsertLeave,WinEnter * set cursorline

    au BufEnter * call NERDTreeRefresh() "
    au BufWinEnter *.{doc,docx,epub,odp,odt,pdf,rtf} call HandleSpecialFile()
    au BufRead * call ChangeEncoding()
    au BufRead,BufNewFile *.md setlocal spell "automatically turn on spell-checking for Markdown files
    au BufRead,BufNewFile *.txt setlocal spell "automatically turn on spell-checking for text files

    " Restore cursor position when opening file
    au BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

    au FileType * RainbowParentheses
    "au FileType html,css EmmetInstall
    "au FileType html,css,php EmmetInstall
    au FileType java setlocal omnifunc=javacomplete#Complete
    au FileType php setlocal omnifunc=phpcomplete#CompletePHP
    au FocusGained *: redraw!     " Redraw screen every time when focus gained
    au FocusLost *: wa            " Set vim to save the file on focus out
    au InsertLeave * silent! set nopaste
    au VimResized * wincmd =
    "au! BufWritePost * Neomake    " run neomake on the current file on every write
    au! BufWritePre * %s/\s\+$//e " Automatically removing all trailing whitespace
augroup END

augroup LoadDuringHold_Targets
    au!
    "au CursorHold,CursorHoldI * call plug#load('vim-markdown') | au! LoadDuringHold_Targets
    "au CursorHold,CursorHoldI * call plug#load('neomake') | au! LoadDuringHold_Targets
    au CursorHold,CursorHoldI * call plug#load('targets.vim') | au! LoadDuringHold_Targets
    au CursorHold,CursorHoldI * call plug#load('vim-surround') | au! LoadDuringHold_Targets
    au CursorHold,CursorHoldI *.py call plug#load('jedi-vim') | au! LoadDuringHold_Targets
    au CursorHold,CursorHoldI *.php call plug#load('phpcomplete.vim') | au! LoadDuringHold_Targets
augroup END

augroup install_missing_plugins
    au VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif
augroup END

augroup auto_mkdir
    au!
    au BufWritePre *
                \ if !isdirectory(expand('<afile>:p:h')) |
                \ call mkdir(expand('<afile>:p:h'), 'p') |
                \ endif
augroup END

augroup vimrc_active_options
    au!
    au WinEnter,BufEnter * setlocal nu
    au WinLeave,BufLeave * setlocal nonu
augroup END

""google/vim-codefmt
"augroup autoformat_settings
"    au FileType bzl AutoFormatBuffer buildifier
"    au FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
"    au FileType dart AutoFormatBuffer dartfmt
"    au FileType go AutoFormatBuffer gofmt
"    au FileType gn AutoFormatBuffer gn
"    au FileType html,css,json AutoFormatBuffer js-beautify
"    au FileType java AutoFormatBuffer google-java-format
"    au FileType python AutoFormatBuffer yapf
"    " Alternative: au FileType python AutoFormatBuffer autopep8
"augroup END

augroup nerd_loader
    au!
    au VimEnter * silent! au! FileExplorer
    au BufEnter,BufNew *
                \  if isdirectory(expand('<amatch>'))
                \|   call plug#load('nerdtree')
                \|   execute 'au! nerd_loader'
                \| endif
augroup END

augroup asyncrun
    au User AsyncRunStart call asyncrun#quickfix_toggle(10, 1)
augroup END

""" }}}
