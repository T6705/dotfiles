" vim:foldmethod=marker:foldlevel=0

""" === augroup === {{{

augroup configgroup
    autocmd!
    autocmd FileType * RainbowParentheses
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd! BufWritePre * %s/\s\+$//e         " Automatically removing all trailing whitespace
    autocmd! BufWritePost * Neomake            " run neomake on the current file on every write
    autocmd! BufWritePost .vimrc source %
    autocmd! BufWritePost init.vim source %
augroup END

""" }}}
