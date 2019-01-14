" vim:foldmethod=marker:foldlevel=0

""" === augroup === {{{

augroup configgroup
    au!

    au StdinReadPre * let s:std_in=1
    " Open NERDTree automatically when vim starts up if no files were specified
    "au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " Open NERDTree automatically when vim starts up on opening a directory
    au VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd h |endif

    au BufEnter * call NERDTreeRefresh() "
    au BufRead * call ChangeEncoding()
    au BufRead,BufNewFile *.md setlocal spell "automatically turn on spell-checking for Markdown files
    au BufRead,BufNewFile *.txt setlocal spell "automatically turn on spell-checking for text files
    au BufReadPost quickfix nnoremap <buffer> <Left> :Qolder<CR>
    au BufReadPost quickfix nnoremap <buffer> <Right> :Qnewer<CR>
    au BufWinEnter *.{doc,docx,epub,odp,odt,pdf,rtf} call HandleSpecialFile()
    au BufWritePost .vimrc,.vimrc.local,init.vim source %
    au BufWritePost .vimrc.local source %
    au FileType * RainbowParentheses
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
    au BufRead,BufNewFile *.{notes,todo,txt} nnoremap <silent> <Leader>tu mm:s/\[X\]/\[\ \]<CR>`m:delmarks m<CR>zz
augroup END

augroup html_js_css
    au!
    au BufRead,BufNewFile *.{css,html,js} setlocal formatprg=prettier\ --stdin\ --single-quote\ --trailing-comma
augroup END

" Close vim if the only window left open is a NERDTree or quickfix
augroup finalcountdown
    au!
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) || &buftype == 'quickfix' | q | endif
augroup END

" omnifuncs
augroup omnifuncs
    au!
    au FileType c setlocal omnifunc=ccomplete#Complete
    au FileType css setlocal omnifunc=csscomplete#CompleteCSS
    au FileType go setlocal omnifunc=go#complete#Complete
    au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    au FileType java setlocal omnifunc=javacomplete#Complete
    au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    au FileType php setlocal omnifunc=phpcomplete#CompletePHP
    au FileType python setlocal omnifunc=pythoncomplete#Complete
    au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" close preview on completion complete
augroup completionhide
    au!
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
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

augroup Snippet
    au FileType java call JavaAbbrev()
    au FileType cpp call CppAbbrev()
    au BufRead,BufNewFile *.{tmpl,htm,js} call JavascriptAbbrev()
    au BufRead,BufNewFile *.py call PythonAbbrev()
augroup END

augroup install_missing_plugins
    au VimEnter *
                \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \|   PlugInstall --sync | q
                \| endif
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
"    autocmd TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
"augroup END

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
""" }}}
