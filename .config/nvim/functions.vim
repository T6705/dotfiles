" vim:foldmethod=marker:foldlevel=0

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
" compile_and_run | <Leader>cr
" ----------------------------------------------------------------------------------------
fu! Compile_and_Run()
    exec 'w'
    if &filetype == 'c'
        call VimuxRunCommand('time gcc -O3 -Wall -Wextra '.expand('%').' -o '.expand('%<').' && time '.expand('%:p:r'))
    elseif &filetype == 'cpp'
        call VimuxRunCommand('time g++ -O3 -Wall -Wextra -std=c++11 '.expand('%').' -o '.expand('%<').' && time '.expand('%:p:r'))
    elseif &filetype == 'java'
        exec 'cd %:p:h'
        call VimuxRunCommand('time javac '.expand('%').' && time java '.expand('%<'))
    elseif &filetype == 'sh'
        call VimuxRunCommand('time bash '.expand('%'))
    elseif &filetype == 'php'
        call VimuxRunCommand('time php '.expand('%'))
    elseif &filetype == 'python'
        call VimuxRunCommand('time python3 '.expand('%'))
    endif
endfu
command! CompileandRun call Compile_and_Run()

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
" :NERDTreeRefresh
" ----------------------------------------------------------------------------------------
fu! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfu
command! NERDTreeRefresh call NERDTreeRefresh()

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
" :Scriptnames <name>
" ----------------------------------------------------------------------------
fu! s:Scratch (command, ...)
    redir => lines
    let saveMore = &more
    set nomore
    execute a:command
    redir END
    let &more = saveMore
    call feedkeys("\<cr>")
    new | setlocal buftype=nofile bufhidden=hide noswapfile
    put=lines
    if a:0 > 0
        execute 'vglobal/'.a:1.'/delete'
    endif
    if a:command == 'scriptnames'
        %substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e
    endif
    silent %substitute/\%^\_s*\n\|\_s*\%$
    let height = line('$') + 3
    execute 'normal! z'.height."\<cr>"
    0
endfu

command! -nargs=? Scriptnames call <sid>Scratch('scriptnames', <f-args>)
command! -nargs=+ Scratch call <sid>Scratch(<f-args>)

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

" ----------------------------------------------------------------------------------------
" Window movement shortcuts
" ----------------------------------------------------------------------------------------
" move to the window in the direction shown, or create a new window
fu! functions#WinMove(key)
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
endfu

" ----------------------------------------------------------------------------------------
" :Goyo
" ----------------------------------------------------------------------------------------
fu! s:goyo_enter()
    "silent !tmux set status off
    "silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    set nonu
    set noshowcmd
    set noshowmode
    set scrolloff=999
    Limelight
endfu

fu! s:goyo_leave()
    "silent !tmux set status on
    "silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    set nu
    set showcmd
    set showmode
    set scrolloff=5
    Limelight!
endfu

au! User GoyoEnter nested call <SID>goyo_enter()
au! User GoyoLeave nested call <SID>goyo_leave()

" ----------------------------------------------------------------------------------------
" :LightTheme (PaperColor)
" ----------------------------------------------------------------------------------------
fu! LightTheme()
    "let g:transparent_background = 1
    let g:allow_bold=1
    let g:allow_italic=1
    set background=light
    colorscheme PaperColor
    AirlineTheme papercolor
endfu
command! LightTheme call LightTheme()

" ----------------------------------------------------------------------------------------
" :DarkTheme (Monokai)
" ----------------------------------------------------------------------------------------
fu! DarkTheme()
    set background=dark
    colorscheme molokai
    AirlineTheme wombat
endfu
command! DarkTheme call DarkTheme()

" ----------------------------------------------------------------------------------------
" :GruvboxLight
" ----------------------------------------------------------------------------------------
fu! GruvboxLight()
    let g:gruvbox_italic=1
    let g:gruvbox_contrast_light="hard"
    set background=light
    colorscheme gruvbox
    AirlineTheme gruvbox
endfu
command! GruvboxLight call GruvboxLight()

" ----------------------------------------------------------------------------------------
" :GruvboxDark
" ----------------------------------------------------------------------------------------
fu! GruvboxDark()
    let g:gruvbox_italic=1
    let g:gruvbox_contrast_dark="soft"
    set background=dark
    colorscheme gruvbox
    AirlineTheme gruvbox
endfu
command! GruvboxDark call GruvboxDark()

" smart tab completion
fu! functions#Smart_TabComplete()
    let line = getline('.')                    " current line

    let substr = strpart(line, -1, col('.')+1) " from the start of the current
                                               " line to one character right
                                               " of the cursor
    let substr = matchstr(substr, '[^ \t]*$')  " word till cursor
    if (strlen(substr)==0)                     " nothing to match on empty string
        return '\<TAB>'
    endif
    let has_period = match(substr, '\.') != -1 " position of period, if any
    let has_slash = match(substr, '\/') != -1  " position of slash, if any
    if (!has_period && !has_slash)
        return '\<C-X>\<C-P>'                  " existing text matching
    elseif ( has_slash )
        return '\<C-X>\<C-F>'                  " file matching
    else
        return '\<C-X>\<C-O>'                  " plugin matching
    endif
endfu

" execute a custom command
fu! functions#RunCustomCommand()
    up
    if g:silent_custom_command
        execute 'silent !' . s:customcommand
    else
        execute '!' . s:customcommand
    endif
endfu

fu! functions#SetCustomCommand()
    let s:customcommand = input('Enter Custom Command$ ')
endfu

fu! functions#TrimWhiteSpace()
    %s/\s\+$//e
endfu

fu! functions#HtmlUnEscape()
    silent s/&lt;/</eg
    silent s/&gt;/>/eg
    silent s/&amp;/\&/eg
endfu

""" }}}
