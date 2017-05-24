" vim:foldmethod=marker:foldlevel=0

""" === Mappings === {{{

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" :J json prettify
command J :%!python -mjson.tool

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
nnoremap Y y$

nnoremap <silent> <leader>p "+gP
nnoremap <silent> <leader>x "+x
nnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>x "+x
vnoremap <silent> <leader>y "+y

nnoremap <Leader>a :%y+<cr> " place whole file on the system clipboard

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
cnoremap <c-h>  <left>
cnoremap <c-j>  <down>
cnoremap <c-k>  <up>
cnoremap <c-l>  <right>

" Map arrow keys to window resize commands.
nnoremap <Right> 5<C-W>>
nnoremap <Left> 5<C-W><
nnoremap <Up> 5<C-W>+
nnoremap <Down> 5<C-W>-

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

"inoremap <silent> <F2> <esc>:NERDTreeFind<CR>
"inoremap <silent> <F3> <esc>:NERDTreeToggle<CR>
"inoremap <silent> <F6> <esc>:TagbarToggle<CR>
"nnoremap <silent> <F2> :NERDTreeFind<CR>
"nnoremap <silent> <F3> :NERDTreeToggle<CR>
"nnoremap <silent> <F6> :TagbarToggle<CR>
inoremap <silent> <F4> <esc>:GundoToggle<CR>
inoremap <silent> <F5> <esc>:Codi!!<CR>
nnoremap <silent> <F4> :GundoToggle<CR>
nnoremap <silent> <F5> :Codi!!<CR>

" hexedit
inoremap <silent> <F7> <esc>:%!xxd<CR>
inoremap <silent> <F8> <esc>:%!xxd -r<CR>
noremap <silent> <F7> :%!xxd<CR>
noremap <silent> <F8> :%!xxd -r<CR>

" qq to record, Q to replay (recursive noremap due to peekaboo)
nnoremap Q @q

" Switch to the directory of opened buffer
nnoremap <silent> <leader>cd :lcd %:p:h<CR>

" clear highlighted search
nnoremap <silent> <leader>sc :set hlsearch! hlsearch?<CR>

" Change current word to uppercase
nnoremap <leader>u gUiw

" Change current word to lowercase
nnoremap <leader>l guiw

" search for word under the cursor
nnoremap <leader>/ "fyiw :/<c-r>f<CR>

" window navigation
nnoremap <silent> <leader>wh :call functions#WinMove('h')<CR>
nnoremap <silent> <leader>wj :call functions#WinMove('j')<CR>
nnoremap <silent> <leader>wk :call functions#WinMove('k')<CR>
nnoremap <silent> <leader>wl :call functions#WinMove('l')<CR>
nnoremap <silent> <leader>wx <C-W>x
nnoremap <silent> <leader>wH <C-W>H
nnoremap <silent> <leader>wJ <C-W>J
nnoremap <silent> <leader>wK <C-W>K
nnoremap <silent> <leader>wL <C-W>L

" Quickly edit your macros
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Git
nnoremap <silent> <leader>gb  :Gblame<CR>
nnoremap <silent> <leader>gc  :Gcommit<CR>
nnoremap <silent> <leader>gd  :Gvdiff<CR>
nnoremap <silent> <leader>gps :Gpush<CR>
nnoremap <silent> <leader>gpu :Gpull<CR>
nnoremap <silent> <leader>gr  :Gremove<CR>
nnoremap <silent> <leader>gs  :Gstatus<CR>
nnoremap <silent> <leader>gw  :Gwrite<CR>

" YouCompleteMe
noremap <leader>d :YcmCompleter GoTo<CR>

" quickfix
nnoremap <silent> <leader>lo :lopen<CR>
nnoremap <silent> <leader>lc :lclose<CR>
nnoremap <silent> [l :lprevious<CR> " Neomake
nnoremap <silent> ]l :lnext<CR>     " Neomake
nnoremap <silent> ]q :cnext<cr>zz
nnoremap <silent> [q :cprev<cr>zz
"nmap <silent> [l <Plug>(ale_previous_wrap) " Asynchronous Lint Engine
"nmap <silent> ]l <Plug>(ale_next_wrap      " Asynchronous Lint Engine

" Tabs
nnoremap ]t gt
nnoremap [t gT
nnoremap <silent> <leader>nt :tabnew<CR>

" Buffer nav
nnoremap <silent> [b :bp<CR>
nnoremap <silent> ]b :bn<CR>
nnoremap <silent> <leader>q :bd!<CR>
nnoremap <silent> <leader>nb :enew<CR>
nnoremap <silent> <leader>bs :Buffers<CR>
nnoremap <silent> <leader>bls :Lines<CR>
"noremap <silent> <leader>b :CtrlPBuffer<CR>
"nnoremap <leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>

" add space after comma
nnoremap <leader>, :%s/, */, /g<CR>
vnoremap <leader>, :s/, */, /g<CR>

" Explore dir
"nnoremap <silent> <leader>E :Lexplore<CR>
nnoremap <silent> <leader>E :NERDTreeToggle<CR>
nnoremap <silent> <leader>EF :NERDTreeFind<CR>

if has('nvim')
    "nnoremap <silent> <leader>rg :Ranger<CR>
else
    " RangerExploer(vim only)
    nnoremap <silent> <leader>rg :call RangerExplorer()<CR>
endif

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

if isdirectory(".git")
    " if in a git project, use :GFiles
    nnoremap <silent> <leader>e :GFiles<CR>
else
    " otherwise, use :FZF
    nnoremap <silent> <leader>e :FZF<CR>
endif

nnoremap <silent> <leader>ag :Ag<CR>
nnoremap <silent> <leader>AG :Ag!<CR>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Windows
nnoremap <silent> <leader>ws :Windows<CR>

" Marks
nnoremap <silent> <leader>ms :Marks<CR>

" Tags
nnoremap <silent> <leader>ts :Tags<CR>

" tagbar
nnoremap <silent> <leader>tb :TagbarToggle<CR>

" Insert mode completion
imap <c-x>w <plug>(fzf-complete-word)
imap <c-x>p <plug>(fzf-complete-path)
imap <c-x>a <plug>(fzf-complete-file-ag)
imap <c-x>l <plug>(fzf-complete-line)

" File preview using Highlight (http://www.andre-simon.de/doku/highlight/en/highlight.php)
let g:fzf_files_options =
\ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"   * Preview script requires Ruby
"   * Install Highlight or CodeRay to enable syntax highlighting
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
autocmd VimEnter * command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" folding
nnoremap <leader>f za<CR>
vnoremap <leader>f za<CR>

" vim-table-mode
nnoremap <silent> <leader>tm :TableModeToggle<CR>

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
  nnoremap <leader>a= :Tabularize /=<CR>
  vnoremap <leader>a= :Tabularize /=<CR>
  nnoremap <leader>a: :Tabularize /:<CR>
  vnoremap <leader>a: :Tabularize /:<CR>
  "nnoremap <leader>a: :Tabularize /:\zs<CR>
  "vnoremap <leader>a: :Tabularize /:\zs<CR>
endif

" compile and run
noremap <silent> <leader>ccr :w<CR> :!gcc % -o %< && time %:p:r<CR>
noremap <silent> <leader>jcr :w<CR> :cd %:p:h<CR> :!javac % && time java %<<CR>
noremap <silent> <leader>cr :call Compile_and_Run()<CR>

" Markdown headings
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

"nnoremap <leader>pdf :w<CR> :NeoTex<CR>
nnoremap <leader>apdf :w<CR> :!pandoc % --latex-engine=pdflatex -o %<.pdf<CR>
nnoremap <leader>pdf :w<CR> :VimtexCompile<CR>:NeoTexOn<CR>

" Make check spelling on or off
nnoremap <leader>cson   :set spell<CR>
nnoremap <leader>csoff :set nospell<CR>

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
" <leader>` Surround a word with "backticks"
nmap     <leader>` ysiw`
vnoremap <leader>` c`<C-R>"`<ESC>

" <leader>" Surround a word with "quotes"
nmap     <leader>" ysiw"
vnoremap <leader>" c"<C-R>""<ESC>

" <leader>' Surround a word with 'single quotes'
nmap     <leader>' ysiw'
vnoremap <leader>' c'<C-R>"'<ESC>

" <leader>( Surround a word with ( brackets )
" <leader>) Surround a word with (brackets)
nmap     <leader>( ysiw(
nmap     <leader>) ysiw)
vnoremap <leader>( c( <C-R>" )<ESC>
vnoremap <leader>) c(<C-R>")<ESC>

" <leader>[ Surround a word with [ brackets ]
" <leader>] Surround a word with [brackets]
nmap     <leader>] ysiw]
nmap     <leader>[ ysiw[
vnoremap <leader>[ c[ <C-R>" ]<ESC>
vnoremap <leader>] c[<C-R>"]<ESC>

" <leader>{ Surround a word with { braces }
" <leader>{ Surround a word with {braces}
nmap     <leader>} ysiw}
nmap     <leader>{ ysiw{
vnoremap <leader>} c{ <C-R>" }<ESC>
vnoremap <leader>{ c{<C-R>"}<ESC>

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
