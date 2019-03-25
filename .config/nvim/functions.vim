" vim:foldmethod=marker:foldlevel=0

""" === Functions === {{{
" -------------------------------------------------------------------------------
" :LightTheme (PaperColor)
" -------------------------------------------------------------------------------
fu! LightTheme()
    "let g:transparent_background = 1
    let g:allow_bold=1
    let g:allow_italic=1
    set background=light
    colorscheme PaperColor
    AirlineTheme papercolor
    if has('nvim') && has('termguicolors')
      set termguicolors
    endif
endfu
command! LightTheme call LightTheme()

" -------------------------------------------------------------------------------
" :DarkTheme (Molokai)
" -------------------------------------------------------------------------------
fu! DarkTheme()
    set background=dark
    colorscheme molokai
    AirlineTheme wombat
    if has('nvim') && has('termguicolors')
      set termguicolors
    endif
endfu
command! DarkTheme call DarkTheme()

" -------------------------------------------------------------------------------
" :OneLight
" -------------------------------------------------------------------------------
fu! OneLight()
    set background=light
    colorscheme one
    AirlineTheme one
    if has('nvim') && has('termguicolors')
      set termguicolors
    endif
endfu
command! OneLight call OneLight()

" -------------------------------------------------------------------------------
" :GruvboxLight
" -------------------------------------------------------------------------------
fu! GruvboxLight()
    let g:gruvbox_italic=1
    let g:gruvbox_contrast_light="hard"
    set background=light
    colorscheme gruvbox
    AirlineTheme gruvbox
    if has('nvim') && has('termguicolors')
      set termguicolors
    endif
endfu
command! GruvboxLight call GruvboxLight()

" -------------------------------------------------------------------------------
" :GruvboxDark
" -------------------------------------------------------------------------------
fu! GruvboxDark()
    let g:gruvbox_italic=1
    let g:gruvbox_contrast_dark="soft"
    set background=dark
    colorscheme gruvbox
    AirlineTheme gruvbox
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
" tmux_compile_and_run | <Leader>tcr
" -------------------------------------------------------------------------------
fu! Tmux_Compile_and_Run()
    exe 'w'
    if &filetype == 'c'
        call VimuxRunCommand('time gcc -O3 -Wall -Wextra '.expand('%').' -o '.expand('%<').' && time '.expand('%:p:r'))
    elseif &filetype == 'cpp'
        call VimuxRunCommand('time g++ -O3 -Wall -Wextra -std=c++11 '.expand('%').' -o '.expand('%<').' && time '.expand('%:p:r'))
    elseif &filetype == 'java'
        exe 'cd %:p:h'
        call VimuxRunCommand('time javac '.expand('%').' && time java '.expand('%<'))
    elseif &filetype == 'sh'
        call VimuxRunCommand('time bash '.expand('%'))
    elseif &filetype == 'php'
        call VimuxRunCommand('time php '.expand('%'))
    elseif &filetype == 'python'
        call VimuxRunCommand('time python3 '.expand('%'))
    elseif &filetype == 'go'
        call VimuxRunCommand('time go run '.expand('%'))
    endif
endfu
command! TmuxCompileandRun call Tmux_Compile_and_Run()

" -------------------------------------------------------------------------------
" compile_and_run | <Leader>tcr
" -------------------------------------------------------------------------------
fu! Compile_and_Run()
    exe 'w'

    if &filetype == 'c'
        echo 'compiling'
        exe "!time gcc -O3 -Wall -Wextra % -o %<"
        let l:cmd="time ".expand('%:p:r')
    elseif &filetype == 'cpp'
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
    endif

    exe 'sp'
    exe 'term '.l:cmd
    exe 'wincmd k'
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
" :NERDTreeRefresh
" -------------------------------------------------------------------------------
fu! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfu
command! NERDTreeRefresh call NERDTreeRefresh()

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

" -------------------------------------------------------------------------------
" Window movement shortcuts
" -------------------------------------------------------------------------------
" move to the window in the direction shown, or create a new window
fu! functions#WinMove(key)
    let t:curwin = winnr()
    exe "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exe "wincmd ".a:key
    endif
endfu

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
        nnoremap <Leader>fxa :bufdo 0,$!yapf -p<CR>
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

"" smart tab completion
"fu! functions#Smart_TabComplete()
"    let line = getline('.')                    " current line

"    let substr = strpart(line, -1, col('.')+1) " from the start of the current
"                                               " line to one character right
"                                               " of the cursor
"    let substr = matchstr(substr, '[^ \t]*$')  " word till cursor
"    if (strlen(substr)==0)                     " nothing to match on empty string
"        return '\<TAB>'
"    endif
"    let has_period = match(substr, '\.') != -1 " position of period, if any
"    let has_slash = match(substr, '\/') != -1  " position of slash, if any
"    if (!has_period && !has_slash)
"        return '\<C-X>\<C-P>'                  " existing text matching
"    elseif ( has_slash )
"        return '\<C-X>\<C-F>'                  " file matching
"    else
"        return '\<C-X>\<C-O>'                  " plugin matching
"    endif
"endfu

"" exe a custom command
"fu! functions#RunCustomCommand()
"    up
"    if g:silent_custom_command
"        exe 'silent !' . s:customcommand
"    else
"        exe '!' . s:customcommand
"    endif
"endfu

"fu! functions#SetCustomCommand()
"    let s:customcommand = input('Enter Custom Command$ ')
"endfu

"fu! functions#TrimWhiteSpace()
"    %s/\s\+$//e
"endfu

"fu! functions#HtmlUnEscape()
"    silent s/&lt;/</eg
"    silent s/&gt;/>/eg
"    silent s/&amp;/\&/eg
"endfu

""" }}}
