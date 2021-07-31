" vim:foldmethod=marker:foldlevel=0

""" === Functions === {{{

if has('nvim')
    fu! CreateCenteredFloatingWindow()
        let width = float2nr(&columns * 0.8)
        let height = float2nr(&lines * 0.8)
        let top = ((&lines - height) / 2)
        let left = (&columns - width) / 2
        let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

        let top = "╭" . repeat("─", width - 2) . "╮"
        let mid = "│" . repeat(" ", width - 2) . "│"
        let bot = "╰" . repeat("─", width - 2) . "╯"
        let lines = [top] + repeat([mid], height - 2) + [bot]
        let s:buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
        call nvim_open_win(s:buf, v:true, opts)
        set winhl=Normal:Floating
        let opts.row += 1
        let opts.height -= 2
        let opts.col += 2
        let opts.width -= 4
        call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
        au BufWipeout <buffer> exe 'bw '.s:buf
    endfu

    fu! OpenTerm(cmd)
        call CreateCenteredFloatingWindow()
        call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
    endfu

    if executable('lazygit')
        let s:lazygit_open = 0
        fu! ToggleLazyGit()
            if s:lazygit_open
                bd!
                let s:lazygit_open = 0
            else
                call OpenTerm('lazygit')
                let s:lazygit_open = 1
            endif
        endfu

        fu! OnTermExit(job_id, code, event) dict
            if a:code == 0
                bd!
            endif
        endfu
    endif
endif

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
    let g:gruvbox_contrast_dark="hard"
    set background=dark
    colorscheme gruvbox
    AirlineTheme gruvbox
    if has('nvim') && has('termguicolors')
      set termguicolors
    endif
endfu
command! GruvboxDark call GruvboxDark()

" -------------------------------------------------------------------------------
" :Todo
" -------------------------------------------------------------------------------
fu! Todo()
    if exists("b:current_syntax")
        finish
    endif

    " Custom conceal
    syntax match todoCheckbox "\[\ \]" conceal cchar=
    syntax match todoCheckbox "\[x\]" conceal cchar=

    let b:current_syntax = "todo"

    hi def link todoCheckbox Todo
    hi Conceal guibg=NONE

    setlocal cole=1

    command! Check :s/\(\s*\)\[ \]/\1\[x\]/
    command! Uncheck :s/\(\s*\)\[x\]/\1\[ \]/
endfu
command! Todo call Todo()

" -------------------------------------------------------------------------------
"  goyo
" -------------------------------------------------------------------------------
fu! Goyo_enter()
    set nonu
    Limelight
    if has('gui_running')
        set fullscreen
        set background=light
        set linespace=7
    elseif exists('$TMUX')
        silent !tmux set status off
    endif
endfu

fu! Goyo_leave()
    set nu
    Limelight!
    if has('gui_running')
        set nofullscreen
        set background=dark
        set linespace=0
    elseif exists('$TMUX')
        silent !tmux set status on
    endif
endfu

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

function! CustomFold()
    return printf('   %6d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
endfunction

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

fu! PythonConfig()
    inorea <buffer> ifmain if __name__ == "__main__":<CR>main()<Esc>

    " -------------------------------------------------------------------------------
    " isort
    " -------------------------------------------------------------------------------
    if executable("isort")
        nnoremap <silent> <Leader>is :%!isort -<CR>
        nnoremap <silent> <Leader>isa :bufdo %!isort -<CR>
        command! -range=% Isort :<line1>,<line2>! isort -
    else
        nnoremap <Leader>is :echo "isort is not installed"<CR>
        nnoremap <Leader>isa :echo "isort is not installed"<CR>
    endif

    nnoremap <silent> <Leader>bp Oimport pdb; pdb.set_trace()  # BREAKPOINT<C-c>
endfu

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

""" }}}
