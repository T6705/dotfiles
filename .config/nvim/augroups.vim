" vim:foldmethod=marker:foldlevel=0

""" === augroup === {{{

augroup configgroup
    autocmd!

    "" Open NERDTree automatically when vim starts up if no files were specified
    "autocmd StdinReadPre * let s:std_in=1
    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    "autocmd FileType text Goyo
    "autocmd FileType text Limelight

    "autocmd InsertEnter,WinLeave * set nocursorline
    "autocmd InsertLeave,WinEnter * set cursorline

    " Restore cursor position when opening file
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

    autocmd FileType * RainbowParentheses
    autocmd FileType html,css EmmetInstall
    "autocmd FileType html,css,php EmmetInstall
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd FocusGained *: redraw!     " Redraw screen every time when focus gained
    autocmd FocusLost *: wa            " Set vim to save the file on focus out
    autocmd InsertLeave * silent! set nopaste
    autocmd! BufWritePost * Neomake    " run neomake on the current file on every write
    autocmd! BufWritePre * %s/\s\+$//e " Automatically removing all trailing whitespace
augroup END

""google/vim-codefmt
"augroup autoformat_settings
"    autocmd FileType bzl AutoFormatBuffer buildifier
"    autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
"    autocmd FileType dart AutoFormatBuffer dartfmt
"    autocmd FileType go AutoFormatBuffer gofmt
"    autocmd FileType gn AutoFormatBuffer gn
"    autocmd FileType html,css,json AutoFormatBuffer js-beautify
"    autocmd FileType java AutoFormatBuffer google-java-format
"    autocmd FileType python AutoFormatBuffer yapf
"    " Alternative: autocmd FileType python AutoFormatBuffer autopep8
"augroup END

augroup nerd_loader
    autocmd!
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd BufEnter,BufNew *
                \  if isdirectory(expand('<amatch>'))
                \|   call plug#load('nerdtree')
                \|   execute 'autocmd! nerd_loader'
                \| endif
augroup END

augroup asyncrun
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(10, 1)
augroup END

""" }}}
