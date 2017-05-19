" vim:foldmethod=marker:foldlevel=0

""" === Functions === {{{

" ----------------------------------------------------------------------------------------
" :Shuffle | Shuffle selected lines
" ----------------------------------------------------------------------------------------
function! s:shuffle() range
ruby << RB
  first, last = %w[a:firstline a:lastline].map { |e| VIM::evaluate(e).to_i }
  (first..last).map { |l| $curbuf[l] }.shuffle.each_with_index do |line, i|
    $curbuf[first + i] = line
  end
RB
endfunction
command! -range Shuffle <line1>,<line2>call s:shuffle()

" ----------------------------------------------------------------------------------------
" :ClearRegisters
" ----------------------------------------------------------------------------------------
function! ClearRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
endfunction
command! ClearRegisters call ClearRegisters()

" ----------------------------------------------------------------------------------------
" :RangerExplorer (vim only)
" ----------------------------------------------------------------------------------------
function RangerExplorer()
    exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
    if filereadable('/tmp/vim_ranger_current_file')
        exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
        call system('rm /tmp/vim_ranger_current_file')
    endif
    redraw!
endfun

" ----------------------------------------------------------------------------
" EX | chmod +x
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
function! WordProcessorMode()
    setlocal textwidth=80
    setlocal smartindent
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfunction
command! WordProcessorMode call WordProcessorMode()

" ----------------------------------------------------------------------------------------
" compile_and_run | <Leader>cr
" ----------------------------------------------------------------------------------------
function! Compile_and_Run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %< && time %:p:r"
    elseif &filetype == 'cpp'
        exec "AsyncRun! g++ -std=c++11 % -o %< && time %:p:r"
    elseif &filetype == 'java'
        exec "cd %:p:h"
        exec "AsyncRun! javac % && time java %<"
    elseif &filetype == 'sh'
        exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
        exec "AsyncRun! time python3 %"
    endif
endfunction

" ----------------------------------------------------------------------------------------
" :ChangeEncoding
" ----------------------------------------------------------------------------------------
function! ChangeEncoding()
    let result = system("file " . escape(escape(escape(expand("%"), ' '), '['), ']'))
    if result =~ "Little-endian UTF-16" && &enc != "utf-16le"
        exec "e ++enc=utf-16le"
    endif
endfunction
command! ChangeEncoding call ChangeEncoding()

" ----------------------------------------------------------------------------------------
" Window movement shortcuts
" ----------------------------------------------------------------------------------------
" move to the window in the direction shown, or create a new window
function! functions#WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

" smart tab completion
function! functions#Smart_TabComplete()
    let line = getline('.')                         " current line

    let substr = strpart(line, -1, col('.')+1)      " from the start of the current
    " line to one character right
    " of the cursor
    let substr = matchstr(substr, '[^ \t]*$')       " word till cursor
    if (strlen(substr)==0)                          " nothing to match on empty string
        return '\<tab>'
    endif
    let has_period = match(substr, '\.') != -1      " position of period, if any
    let has_slash = match(substr, '\/') != -1       " position of slash, if any
    if (!has_period && !has_slash)
        return '\<C-X>\<C-P>'                         " existing text matching
    elseif ( has_slash )
        return '\<C-X>\<C-F>'                         " file matching
    else
        return '\<C-X>\<C-O>'                         " plugin matching
    endif
endfunction

" execute a custom command
function! functions#RunCustomCommand()
    up
    if g:silent_custom_command
        execute 'silent !' . s:customcommand
    else
        execute '!' . s:customcommand
    endif
endfunction

function! functions#SetCustomCommand()
    let s:customcommand = input('Enter Custom Command$ ')
endfunction

function! functions#TrimWhiteSpace()
    %s/\s\+$//e
endfunction

function! functions#HtmlUnEscape()
    silent s/&lt;/</eg
    silent s/&gt;/>/eg
    silent s/&amp;/\&/eg
endfunction

""" }}}
