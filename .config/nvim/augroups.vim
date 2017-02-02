" vim:foldmethod=marker:foldlevel=0

""" === augroup === {{{

augroup configgroup
    autocmd!

    "" Open NERDTree automatically when vim starts up if no files were specified
    "autocmd StdinReadPre * let s:std_in=1
    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    autocmd FileType * RainbowParentheses
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd InsertLeave * silent! set nopaste
    autocmd! BufWritePre * %s/\s\+$//e         " Automatically removing all trailing whitespace
    autocmd! BufWritePost * Neomake            " run neomake on the current file on every write
    "autocmd! BufWritePost .vimrc source %
    "autocmd! BufWritePost init.vim source %
augroup END

augroup nerd_loader
    autocmd!
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd BufEnter,BufNew *
                \  if isdirectory(expand('<amatch>'))
                \|   call plug#load('nerdtree')
                \|   execute 'autocmd! nerd_loader'
                \| endif
augroup END

""" }}}
