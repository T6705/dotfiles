" vim:foldmethod=marker:foldlevel=0

""" === Mappings === {{{

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" :J json prettify
command J :%!python -mjson.tool

command Sortw :call setline(line('.'),join(sort(split(getline('.'))), ' '))

command! PU PlugUpdate | PlugUpgrade

" ----------------------------------------------------------------------------------------
" Copy and Paste
" ----------------------------------------------------------------------------------------
"" have x (removes single character) not go into the default registry
"nnoremap x "_x

"" Make X an operator that removes without placing text in the default registry
"nmap X "_d
"nmap XX "_dd
"vmap X "_d
"vmap x "_d

"" when changing text, don't put the replaced text into the default registry
"nnoremap c "_c
"vnoremap c "_c

"" Make `Y` behave like `C` and `D`
"nnoremap Y y$
"map y <Plug>(operator-flashy)
"nmap Y <Plug>(operator-flashy)$

nnoremap <silent> <Leader>p "+gP
nnoremap <silent> <Leader>x "+x
nnoremap <silent> <Leader>y "+y
vnoremap <silent> <Leader>x "+x
vnoremap <silent> <Leader>y "+y

" select the current line without indentation
nnoremap vv ^vg_

" place whole file on the system clipboard
nnoremap <silent> <Leader>a :%y+<CR>

"" Escaping
cnoremap <C-F> <Esc>
inoremap <C-F> <Esc>
nnoremap <C-F> <Esc>
vnoremap <C-F> <Esc>
xnoremap <C-F> <Esc>

"" No arrow keys
"no <down> <Nop>
"no <left> <Nop>
"no <right> <Nop>
"no <up> <Nop>

" No arrow keys in insert mode
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

" Saner command-line history
cnoremap <C-h>  <left>
cnoremap <C-j>  <down>
cnoremap <C-k>  <up>
cnoremap <C-l>  <right>
"" CTRL+A moves to start of line in command mode
"cnoremap <C-a> <home>
"" CTRL+E moves to end of line in command mode
"cnoremap <C-e> <end>

" Map arrow keys to window resize commands.
nnoremap <Right> 2<C-W>>
nnoremap <Left> 2<C-W><
nnoremap <Up> 2<C-W>+
nnoremap <Down> 2<C-W>-

" moving up and down work as you would expect
"nnoremap <silent> j gj
"nnoremap <silent> k gk
"nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
"nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
nnoremap <silent> 0 g0
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" move to beginning/end of line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

nnoremap <silent> G :norm! Gzz<CR>
nnoremap <silent> N Nzz
nnoremap <silent> [[ [[zz
nnoremap <silent> [] []zz
nnoremap <silent> ][ ][zz
nnoremap <silent> ]] ]]zz
nnoremap <silent> g; g;zz " go to place of last change
nnoremap <silent> gV `[v`] " highlight last inserted text
nnoremap <silent> gg :norm! ggzz<CR>
nnoremap <silent> g= mmgg=G`m
nnoremap <silent> gQ mmgggqG`m
nnoremap <silent> n nzz
nnoremap <silent> { {zz
nnoremap <silent> } }zz

" Jump to matching pairs easily, with Shift-Tab
nmap <silent> <S-Tab> %
vmap <silent> <S-Tab> %

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Vmap for maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Scrolling
"nnoremap <silent> <C-d> :call comfortable_motion#flick(400)<CR>
"nnoremap <silent> <C-u> :call comfortable_motion#flick(-400)<CR>
"nnoremap <silent> <C-j> :call comfortable_motion#flick(100)<CR>
"nnoremap <silent> <C-k> :call comfortable_motion#flick(-100)<CR>
noremap <C-j> 2<C-e>
noremap <C-k> 2<C-y>

nnoremap <silent> <Leader>ffo :!firefox %<CR>

"inoremap <silent> <F2> <esc>:NERDTreeFind<CR>
"inoremap <silent> <F3> <esc>:NERDTreeToggle<CR>
"inoremap <silent> <F4> <esc>:GundoToggle<CR>
"inoremap <silent> <F6> <esc>:TagbarToggle<CR>
"nnoremap <silent> <F2> :NERDTreeFind<CR>
"nnoremap <silent> <F3> :NERDTreeToggle<CR>
"nnoremap <silent> <F4> :GundoToggle<CR>
"nnoremap <silent> <F6> :TagbarToggle<CR>
inoremap <silent> <F5> <esc>:Codi!!<CR>
nnoremap <silent> <F5> :Codi!!<CR>

" hexedit
"inoremap <silent> <F7> <esc>:%!xxd<CR>
"inoremap <silent> <F8> <esc>:%!xxd -r<CR>
"noremap <silent> <F7> :%!xxd<CR>
"noremap <silent> <F8> :%!xxd -r<CR>
inoremap <silent> <F8> <esc>:Hexmode<CR>
noremap <silent> <F8> :Hexmode<CR>

" qq to record, Q to replay (recursive noremap due to peekaboo)
nnoremap Q @q
xnoremap Q :'<,'>:normal @q<CR>

" Switch to the directory of opened buffer
nnoremap <silent> <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" Change current word to uppercase
nnoremap <silent> <Leader>u gUiw

" Change current word to lowercase
nnoremap <silent> <Leader>l guiw

" clear highlighted search
nnoremap <silent> <Leader>sc :set hlsearch! hlsearch?<CR>

" vim-slash Places the current match at the center of the window.
noremap <plug>(slash-after) zz

" automatically insert a \v before any search string, so search uses normal regexes
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" search for ipv4
nnoremap /ip4 /\v([0-9]{1,3}\.){3}[0-9]{1,3}<CR>

" search for ipv6
"nnoremap /ip6 /\v(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}\|([0-9a-fA-F]{1,4}:){1,7}:\|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}\|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}\|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}\|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}\|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}\|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})\|:((:[0-9a-fA-F]{1,4}){1,7}\|:)\|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}\|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]\|(2[0-4]\|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]\|(2[0-4]\|1{0,1}[0-9]){0,1}[0-9])\|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]\|(2[0-4]\|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]\|(2[0-4]\|1{0,1}[0-9]){0,1}[0-9]))

" search for url
nnoremap /url /\v(http\|https\|ftp):\/\/[a-zA-Z0-9][a-zA-Z0-9_-]*(\.[a-zA-Z0-9][a-zA-Z0-9_-]*)*(:\d\+)?(\/[a-zA-Z0-9_/.\-+%?&=;@$,!''*~]*)?(#[a-zA-Z0-9_/.\-+%#?&=;@$,!''*~]*)?<CR>

" search for word under the cursor
nnoremap <silent> <Leader>/ "fyiw :/<C-r>f<CR>

" window navigation
nnoremap <silent> <Leader>wh :call functions#WinMove('h')<CR>
nnoremap <silent> <Leader>wj :call functions#WinMove('j')<CR>
nnoremap <silent> <Leader>wk :call functions#WinMove('k')<CR>
nnoremap <silent> <Leader>wl :call functions#WinMove('l')<CR>
nnoremap <silent> <Leader>wx <C-W>x
nnoremap <silent> <Leader>wH <C-W>H
nnoremap <silent> <Leader>wJ <C-W>J
nnoremap <silent> <Leader>wK <C-W>K
nnoremap <silent> <Leader>wL <C-W>L
" Make splits the same width
nnoremap <silent> <Leader>we <C-w>=
nnoremap <silent> <Leader>wz :wincmd _ \|wincmd \| \| normal 0 <CR>

" Quickly edit your macros
nnoremap <silent> <Leader>m  :<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><left>

" Git
nnoremap <silent> <Leader>gb  :Gblame<CR>
nnoremap <silent> <Leader>gc  :Gcommit<CR>
nnoremap <silent> <Leader>gd  :Gvdiff<CR>
nnoremap <silent> <Leader>gps :Gpush<CR>
nnoremap <silent> <Leader>gpu :Gpull<CR>
nnoremap <silent> <Leader>gr  :Gremove<CR>
nnoremap <silent> <Leader>gs  :Gstatus<CR>
nnoremap <silent> <Leader>gw  :Gwrite<CR>

" neosnippet.vim
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"" For conceal markers.
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif

"" YouCompleteMe
"noremap <Leader>g :YcmCompleter GoTo<CR>
"noremap <Leader>d :YcmCompleter GoToDefinition<CR>

" quickfix
let g:quickfix_height = 50
"nmap <silent> [l <Plug>(ale_previous)
"nmap <silent> [l <Plug>(ale_previous_wrap)
"nmap <silent> ]l <Plug>(ale_next)
"nmap <silent> ]l <Plug>(ale_next_wrap)
"nnoremap <silent> [l :lprev<CR> " Neomake
"nnoremap <silent> ]l :lnext<CR> " Neomake
nnoremap <silent> <Leader>lc :lclose<CR>
nnoremap <silent> <Leader>lo :lopen<CR>
nnoremap <silent> <Leader>lw :lwindow<CR>
nnoremap <silent> [L :lfirst<CR>zz
nnoremap <silent> [l :lprev<CR>zz
nnoremap <silent> ]L :llast<CR>zz
nnoremap <silent> ]l :lnext<CR>zz

nnoremap <silent> <Leader>qc :cclose<CR>
nnoremap <silent> <Leader>qo :copen<CR>
nnoremap <silent> <Leader>qw :cwindow<CR>
nnoremap <silent> [Q :cfirst<CR>zz
nnoremap <silent> [q :cprev<CR>zz
nnoremap <silent> ]Q :clast<CR>zz
nnoremap <silent> ]q :cnext<CR>zz

" Tabs
nnoremap ]t gt
nnoremap [t gT
nnoremap <silent> <Leader>tn :tabnew<CR>

" Buffer nav
nnoremap <silent> [b :bp<CR>
nnoremap <silent> ]b :bn<CR>
nnoremap <silent> <Leader>q :bd!<CR>
nnoremap <silent> <Leader>bn :enew<CR>
nnoremap <silent> <Leader>bs :Buffers<CR>
nnoremap <silent> <Leader>bls :Lines<CR>
nnoremap <silent> <bs> <c-^>
"noremap <silent> <Leader>b :CtrlPBuffer<CR>
"nnoremap <silent> <Leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>

" add space after comma
nnoremap <silent> <Leader>, :%s/, */, /g<CR>
vnoremap <silent> <Leader>, :s/, */, /g<CR>

" Explore dir
"if exists(":Lexplore") != 1
"    nnoremap <silent> <Leader>E :Lexplore<CR>
"elseif exists(":Vexplore") != 1
"    nnoremap <silent> <Leader>E :Vexplore<CR>
"else
"    nnoremap <silent> <Leader>E :Explore<CR>
"endif
nnoremap <silent> <Leader>E :NERDTreeToggle<CR>
nnoremap <silent> <Leader>EF :NERDTreeFind<CR>

"Gundo
nnoremap <silent> <Leader>ut :GundoToggle<CR>

nnoremap <silent> <Leader>bp Oimport pdb; pdb.set_trace()  # BREAKPOINT<C-c>

if isdirectory(".git")
    " if in a git project, use :GFiles
    nnoremap <silent> <Leader>e :GFiles<CR>
else
    " otherwise, use :FZF
    nnoremap <silent> <Leader>e :FZF<CR>
endif

nmap <Leader><TAB> <plug>(fzf-maps-n)
xmap <Leader><TAB> <plug>(fzf-maps-x)
omap <Leader><TAB> <plug>(fzf-maps-o)

" Windows
nnoremap <silent> <Leader>ws :Windows<CR>

" Marks
nnoremap <silent> <Leader>ms :Marks<CR>

" Tags
nnoremap <silent> <Leader>ts :Tags<CR>

" tagbar
if v:version >= 703
    nnoremap <silent> <Leader>tb :TagbarToggle<CR>
endif

" Insert mode completion
imap <C-x>w <plug>(fzf-complete-word)
imap <C-x>p <plug>(fzf-complete-path)
imap <C-x>a <plug>(fzf-complete-file-ag)
imap <C-x>l <plug>(fzf-complete-line)

" Completetion
inoremap <silent> ,f <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",:"<CR>
inoremap <silent> ,l <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",="<CR>
inoremap <silent> ,n <C-x><C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",;"<CR>
inoremap <silent> ,o <C-x><C-o><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ",,"<CR>

" folding
nnoremap <silent> <Leader>f za<CR>
vnoremap <silent> <Leader>f za<CR>

" vim-table-mode
nnoremap <silent> <Leader>tm :TableModeToggle<CR>

" Make the dot command work as expected in visual mode (via
" https://www.reddit.com/r/vim/comments/3y2mgt/do_you_have_any_minor_customizationsmappings_that/cya0x04)
vnoremap . :norm.<CR>

"" ----------------------------------------------------------------------------------------
"" easymotion
"" ----------------------------------------------------------------------------------------
"" <Leader>f{char} to move to {char}
"map  <Leader><Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)
"
"" s{char}{char} to move to {char}{char}
"nmap s <Plug>(easymotion-overwin-f2)
"
"" Move to line
"map  <Leader><Leader>L <Plug>(easymotion-bd-jk)
"nmap <Leader><Leader>L <Plug>(easymotion-overwin-line)
"
"" Move to word
"map  <Leader><Leader>w <Plug>(easymotion-bd-w)
"nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

"" ----------------------------------------------------------------------------------------
"" Tabular
"" ----------------------------------------------------------------------------------------
"if exists(":Tabularize")
"  nnoremap <silent> <Leader>a= :Tabularize /=<CR>
"  vnoremap <silent> <Leader>a= :Tabularize /=<CR>
"  nnoremap <silent> <Leader>a: :Tabularize /:<CR>
"  vnoremap <silent> <Leader>a: :Tabularize /:<CR>
"  "nnoremap <silent> <Leader>a: :Tabularize /:\zs<CR>
"  "vnoremap <silent> <Leader>a: :Tabularize /:\zs<CR>
"endif

" compile and run
"noremap <silent> <Leader>ccr :w<CR> :!gcc % -o %< && time %:p:r<CR>
"noremap <silent> <Leader>jcr :w<CR> :cd %:p:h<CR> :!javac % && time java %<<CR>
noremap <silent> <Leader>cr :CompileandRun<CR>

" Markdown headings
nnoremap <silent> <Leader>1 m`yypVr=``
nnoremap <silent> <Leader>2 m`yypVr-``
nnoremap <silent> <Leader>3 m`^i### <esc>``4l
nnoremap <silent> <Leader>4 m`^i#### <esc>``5l
nnoremap <silent> <Leader>5 m`^i##### <esc>``6l

"nnoremap <silent> <Leader>apdf :w<CR> :!pandoc % --latex-engine=pdflatex -o %<.pdf<CR>
"nnoremap <silent> <Leader>pdf :w<CR> :NeoTex<CR>
nnoremap <silent> <Leader>pdf :w<CR> :VimtexCompile<CR>:NeoTexOn<CR>

" Make check spelling on or off
nnoremap <silent> <Leader>cson   :set spell<CR>
nnoremap <silent> <Leader>csoff :set nospell<CR>

" search and replace
nnoremap <silent> <Leader>sr  :'{,'}s/\<<C-r>=expand('<cword>')<CR>\>/
nnoremap <silent> <Leader>sra :%s/\<<C-r>=expand('<cword>')<CR>\>/

nnoremap <silent> <Leader>rp /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap <silent> <Leader>RP ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN
nnoremap <silent> <Leader>dw /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgn
nnoremap <silent> <Leader>DW ?\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgN

" ----------------------------------------------------------------------------------------
" vimux
" ----------------------------------------------------------------------------------------
" Inspect runner pane
nnoremap <silent> <Leader>vi :VimuxInspectRunner<CR>

" Run last command executed by VimuxRunCommand
nnoremap <silent> <Leader>vl :VimuxRunLastCommand<CR>

" Prompt for a command to run
nnoremap <silent> <Leader>vp :VimuxPromptCommand<CR>

" Close vim tmux runner opened by VimuxRunCommand
nnoremap <silent> <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
nnoremap <silent> <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
nnoremap <silent> <Leader>vz :call VimuxZoomRunner()<CR>

" ----------------------------------------------------------------------------------------
" Surround
" ----------------------------------------------------------------------------------------
" Maps ss to surround word
nmap ss ysiw

" Maps sl to surround line
nmap sl yss

"" Surround Visual selection
"vmap s S

" <Leader>` Surround a word with "backticks"
nmap     <silent> <Leader>` ysiw`
vnoremap <silent> <Leader>` c`<C-R>"`<ESC>

" <Leader>" Surround a word with "quotes"
nmap     <silent> <Leader>" ysiw"
vnoremap <silent> <Leader>" c"<C-R>""<ESC>

" <Leader>' Surround a word with 'single quotes'
nmap     <silent> <Leader>' ysiw'
vnoremap <silent> <Leader>' c'<C-R>"'<ESC>

" <Leader>( Surround a word with ( brackets )
" <Leader>) Surround a word with (brackets)
nmap     <silent> <Leader>( ysiw(
nmap     <silent> <Leader>) ysiw)
vnoremap <silent> <Leader>( c( <C-R>" )<ESC>
vnoremap <silent> <Leader>) c(<C-R>")<ESC>

" <Leader>[ Surround a word with [ brackets ]
" <Leader>] Surround a word with [brackets]
nmap     <silent> <Leader>] ysiw]
nmap     <silent> <Leader>[ ysiw[
vnoremap <silent> <Leader>[ c[ <C-R>" ]<ESC>
vnoremap <silent> <Leader>] c[<C-R>"]<ESC>

" <Leader>{ Surround a word with { braces }
" <Leader>} Surround a word with {braces}
nmap     <silent> <Leader>} ysiw}
nmap     <silent> <Leader>{ ysiw{
vnoremap <silent> <Leader>} c{ <C-R>" }<ESC>
vnoremap <silent> <Leader>{ c{<C-R>"}<ESC>

nnoremap cs({ m1F(m2%r}`2r{`1
nnoremap cs{( m1F{m2%r)`2r(`1
nnoremap cs([ m1F(m2%r]`2r[`1
nnoremap cs[( m1F[m2%r)`2r(`1
nnoremap cs[{ m1F[m2%r}`2r{`1
nnoremap cs{[ m1F{m2%r]`2r[`1

vnoremap S# "zdi#<C-R>z#<esc>
vnoremap S* "zdi*<C-R>z*<esc>
vnoremap S" "zdi"<C-R>z"<esc>
vnoremap S' "zdi'<C-R>z'<esc>
vnoremap S( "zdi(<C-R>z)<esc>
vnoremap S{ "zdi{<C-R>z}<esc>
vnoremap S[ "zdi[<C-R>z]<esc>

"" ----------------------------------------------------------------------------------------
"" splitjoin
"" ----------------------------------------------------------------------------------------
"let g:splitjoin_split_mapping = ''
"let g:splitjoin_join_mapping = ''
"
"noremap <silent> <Leader>j :SplitjoinJoin<cr>
"noremap <silent> <Leader>s :SplitjoinSplit<cr>

" ----------------------------------------------------------------------------------------
" Search in project
" ----------------------------------------------------------------------------------------
command! -nargs=+ -complete=file_in_path -bar Grep  silent! grep! <args> | redraw!
command! -nargs=+ -complete=file_in_path -bar LGrep silent! lgrep! <args> | redraw!

nnoremap <silent> <Leader>G :Grep <C-r><C-w><CR>
xnoremap <silent> <Leader>G :<C-u>let cmd = "Grep " . visual#GetSelection() <bar>
                        \ call histadd("cmd", cmd) <bar>
                        \ execute cmd<CR>

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("ag")
    set grepprg=ag\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ----------------------------------------------------------------------------------------
" nvim
" ----------------------------------------------------------------------------------------
if has('nvim')
    "command! Term terminal
    "command! VTerm vnew | terminal

    tnoremap <Esc> <C-\><C-n>
    "tnoremap <a-a> <esc>a
    "tnoremap <a-b> <esc>b
    "tnoremap <a-d> <esc>d
    "tnoremap <a-f> <esc>f
endif

""" }}}
