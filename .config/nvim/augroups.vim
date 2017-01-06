" vim:foldmethod=marker:foldlevel=0

""" === augroup === {{{

augroup configgroup
    autocmd!
    autocmd FileType * RainbowParentheses
    autocmd! BufWritePre * %s/\s\+$//e         " Automatically removing all trailing whitespace
    autocmd! BufWritePost * Neomake            " run neomake on the current file on every write
    autocmd! Bufwritepost .vimrc source %
    autocmd! Bufwritepost init.vim source %
augroup END

""" }}}
