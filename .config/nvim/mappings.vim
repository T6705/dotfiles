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

" Make `Y` behave like `C` and `D`
"nnoremap Y y$
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

nnoremap <silent> <Leader>p "+gP
nnoremap <silent> <Leader>x "+x
nnoremap <silent> <Leader>y "+y
vnoremap <silent> <Leader>x "+x
vnoremap <silent> <Leader>y "+y

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
nnoremap <silent> j gj
nnoremap <silent> k gk
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
nnoremap <silent> n nzz
nnoremap <silent> { {zz
nnoremap <silent> } }zz

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

" Switch to the directory of opened buffer
nnoremap <silent> <Leader>cd :lcd %:p:h<CR>:pwd<CR>


" Change current word to uppercase
nnoremap <Leader>u gUiw

" Change current word to lowercase
nnoremap <Leader>l guiw

" clear highlighted search
nnoremap <silent> <Leader>sc :set hlsearch! hlsearch?<CR>

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
nnoremap <Leader>/ "fyiw :/<C-r>f<CR>

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
nnoremap <Leader>m  :<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><left>

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
"noremap <leader>g :YcmCompleter GoTo<CR>
"noremap <leader>d :YcmCompleter GoToDefinition<CR>

" quickfix
nnoremap <silent> <Leader>lo :lopen<CR>
nnoremap <silent> <Leader>lc :lclose<CR>
nnoremap <silent> [l :lprevious<CR> " Neomake
nnoremap <silent> ]l :lnext<CR>     " Neomake
nnoremap <silent> ]q :cnext<CR>zz
nnoremap <silent> [q :cprev<CR>zz
"nmap <silent> [l <Plug>(ale_previous_wrap) " Asynchronous Lint Engine
"nmap <silent> ]l <Plug>(ale_next_wrap      " Asynchronous Lint Engine

" Tabs
nnoremap ]t gt
nnoremap [t gT
nnoremap <silent> <Leader>nt :tabnew<CR>

" Buffer nav
nnoremap <silent> [b :bp<CR>
nnoremap <silent> ]b :bn<CR>
nnoremap <silent> <Leader>q :bd!<CR>
nnoremap <silent> <Leader>nb :enew<CR>
nnoremap <silent> <Leader>bs :Buffers<CR>
nnoremap <silent> <Leader>bls :Lines<CR>
"noremap <silent> <Leader>b :CtrlPBuffer<CR>
"nnoremap <Leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>

" add space after comma
nnoremap <Leader>, :%s/, */, /g<CR>
vnoremap <Leader>, :s/, */, /g<CR>

" Explore dir
"nnoremap <silent> <Leader>E :Lexplore<CR>
nnoremap <silent> <Leader>E :NERDTreeToggle<CR>
nnoremap <silent> <Leader>EF :NERDTreeFind<CR>

"Gundo
nnoremap <silent> <Leader>ut :GundoToggle<CR>

if has('nvim')
    "nnoremap <silent> <Leader>rg :Ranger<CR>
else
    " RangerExploer(vim only)
    nnoremap <silent> <Leader>rgr :call RangerExplorer()<CR>
endif

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" File preview using Highlight (http://www.andre-simon.de/doku/highlight/en/highlight.php)
let g:fzf_files_options =
\ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Command for git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

    ":Rg  - Start fzf with hidden preview window that can be enabled with "?" key
    nnoremap <silent> <Leader>rg :Rg<CR>
    ":Rg! - Start fzf in fullscreen and display the preview window above
    nnoremap <silent> <Leader>RG :Rg!<CR>
endif

if executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

    autocmd VimEnter * command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

    ":Ag  - Start fzf with hidden preview window that can be enabled with "?" key
    nnoremap <silent> <Leader>ag :Ag<CR>
    ":Ag! - Start fzf in fullscreen and display the preview window above
    nnoremap <silent> <Leader>AG :Ag!<CR>
endif

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



" folding
nnoremap <Leader>f za<CR>
vnoremap <Leader>f za<CR>

" vim-table-mode
nnoremap <silent> <Leader>tm :TableModeToggle<CR>

" Make the dot command work as expected in visual mode (via
" https://www.reddit.com/r/vim/comments/3y2mgt/do_you_have_any_minor_customizationsmappings_that/cya0x04)
vnoremap . :norm.<CR>

" ----------------------------------------------------------------------------------------
" easymotion
" ----------------------------------------------------------------------------------------
" <Leader>f{char} to move to {char}
map  <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map  <Leader><Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader><Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

" ----------------------------------------------------------------------------------------
" Tabular
" ----------------------------------------------------------------------------------------
if exists(":Tabularize")
  nnoremap <Leader>a= :Tabularize /=<CR>
  vnoremap <Leader>a= :Tabularize /=<CR>
  nnoremap <Leader>a: :Tabularize /:<CR>
  vnoremap <Leader>a: :Tabularize /:<CR>
  "nnoremap <Leader>a: :Tabularize /:\zs<CR>
  "vnoremap <Leader>a: :Tabularize /:\zs<CR>
endif

" compile and run
"noremap <silent> <Leader>ccr :w<CR> :!gcc % -o %< && time %:p:r<CR>
"noremap <silent> <Leader>jcr :w<CR> :cd %:p:h<CR> :!javac % && time java %<<CR>
noremap <silent> <Leader>cr :CompileandRun<CR>

" Markdown headings
nnoremap <Leader>1 m`yypVr=``
nnoremap <Leader>2 m`yypVr-``
nnoremap <Leader>3 m`^i### <esc>``4l
nnoremap <Leader>4 m`^i#### <esc>``5l
nnoremap <Leader>5 m`^i##### <esc>``6l

"nnoremap <Leader>apdf :w<CR> :!pandoc % --latex-engine=pdflatex -o %<.pdf<CR>
"nnoremap <Leader>pdf :w<CR> :NeoTex<CR>
nnoremap <Leader>pdf :w<CR> :VimtexCompile<CR>:NeoTexOn<CR>

" Make check spelling on or off
nnoremap <Leader>cson   :set spell<CR>
nnoremap <Leader>csoff :set nospell<CR>

" ----------------------------------------------------------------------------------------
" vimux
" ----------------------------------------------------------------------------------------
" Inspect runner pane
nnoremap <Leader>vi :VimuxInspectRunner<CR>

" Run last command executed by VimuxRunCommand
nnoremap <Leader>vl :VimuxRunLastCommand<CR>

" Prompt for a command to run
nnoremap <Leader>vp :VimuxPromptCommand<CR>

" Close vim tmux runner opened by VimuxRunCommand
nnoremap <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
nnoremap <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
nnoremap <Leader>vz :call VimuxZoomRunner()<CR>

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
nmap     <Leader>` ysiw`
vnoremap <Leader>` c`<C-R>"`<ESC>

" <Leader>" Surround a word with "quotes"
nmap     <Leader>" ysiw"
vnoremap <Leader>" c"<C-R>""<ESC>

" <Leader>' Surround a word with 'single quotes'
nmap     <Leader>' ysiw'
vnoremap <Leader>' c'<C-R>"'<ESC>

" <Leader>( Surround a word with ( brackets )
" <Leader>) Surround a word with (brackets)
nmap     <Leader>( ysiw(
nmap     <Leader>) ysiw)
vnoremap <Leader>( c( <C-R>" )<ESC>
vnoremap <Leader>) c(<C-R>")<ESC>

" <Leader>[ Surround a word with [ brackets ]
" <Leader>] Surround a word with [brackets]
nmap     <Leader>] ysiw]
nmap     <Leader>[ ysiw[
vnoremap <Leader>[ c[ <C-R>" ]<ESC>
vnoremap <Leader>] c[<C-R>"]<ESC>

" <Leader>{ Surround a word with { braces }
" <Leader>{ Surround a word with {braces}
nmap     <Leader>} ysiw}
nmap     <Leader>{ ysiw{
vnoremap <Leader>} c{ <C-R>" }<ESC>
vnoremap <Leader>{ c{<C-R>"}<ESC>

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
