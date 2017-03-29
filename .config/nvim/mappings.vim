" vim:foldmethod=marker:foldlevel=0

""" === Mappings === {{{

" Copy and Paste
"nnoremap Y y$ " Make `Y` behave like `C` and `D`
nnoremap YY "+y<CR>
nnoremap <silent> <leader>p "+gP<CR>
nnoremap XX "+x<CR>

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

" Switch to the directory of opened buffer
nnoremap <silent> <leader>cd :lcd %:p:h<cr>

" highlight last inserted text
nnoremap gV `[v`]

" go to place of last change
nnoremap g; g;zz

" clear highlighted search
nnoremap <silent> <leader>sc :set hlsearch! hlsearch?<cr>

" search for word under the cursor
nnoremap <leader>/ "fyiw :/<c-r>f<cr>

nnoremap G :norm! Gzz<CR>
nnoremap N Nzz
nnoremap n nzz
nnoremap { {zz
nnoremap } }zz

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" window navigation
"nnoremap <silent> <leader>wh <C-W>h
"nnoremap <silent> <leader>wj <C-W>j
"nnoremap <silent> <leader>wk <C-W>k
"nnoremap <silent> <leader>wl <C-W>l
nnoremap <silent> <leader>wh :call functions#WinMove('h')<cr>
nnoremap <silent> <leader>wj :call functions#WinMove('j')<cr>
nnoremap <silent> <leader>wk :call functions#WinMove('k')<cr>
nnoremap <silent> <leader>wl :call functions#WinMove('l')<cr>

"" Split
"nnoremap <silent> <leader>h :<C-u>split<CR>
"nnoremap <silent> <leader>v :<C-u>vsplit<CR>

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
noremap <silent> <leader>lo :lopen<CR>
noremap <silent> <leader>lc :lclose<CR>
noremap <silent> [q :lprevious<CR> " Neomake
noremap <silent> ]q :lnext<CR>     " Neomake
"nmap <silent> [q <Plug>(ale_previous_wrap) " Asynchronous Lint Engine
"nmap <silent> ]q <Plug>(ale_next_wrap      " Asynchronous Lint Engine

" Tabs
nnoremap ]t gt
nnoremap [t gT
nnoremap <silent> <leader>nt :tabnew<CR>

" add space after comma
nnoremap <leader>, :%s/, */, /g<CR>
vnoremap <leader>, :s/, */, /g<CR>

" Explore dir
"nnoremap <silent> <leader>E :Lexplore<CR>
nnoremap <silent> <leader>E :NERDTreeToggle<CR>

" Buffer nav
nnoremap <silent> [b :bp<CR>
nnoremap <silent> ]b :bn<CR>
nnoremap <silent> <leader>q :bd!<CR>
nnoremap <silent> <leader>nb :enew<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <leader>bs :Lines<CR>
"noremap <silent> <leader>b :CtrlPBuffer<CR>
"nnoremap <leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

if isdirectory(".git")
    " if in a git project, use :GFiles
    nnoremap <silent> <leader>e :GFiles<cr>
else
    " otherwise, use :FZF
    nnoremap <silent> <leader>e :FZF<cr>
endif

nnoremap <silent> <leader>ag :Ag<cr>
nnoremap <silent> <leader>AG :Ag!<cr>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Marks
nnoremap <silent> <leader>` :Marks<CR>

" Tags
nnoremap <silent> <leader>t :Tags<CR>

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

"" Switching windows
"" noremap <C-j> <C-w>j
"" noremap <C-k> <C-w>k
"" noremap <C-l> <C-w>l
"" noremap <C-h> <C-w>h

" Vmap for maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" folding
nnoremap <leader>f za<CR>
vnoremap <leader>f za<CR>

" vim-table-mode
nnoremap <silent> <leader>tm :TableModeToggle<CR>

" easymotion
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

" Tabular
if exists(":Tabularize")
  nnoremap <leader>a= :Tabularize /=<CR>
  vnoremap <leader>a= :Tabularize /=<CR>
  nnoremap <leader>a: :Tabularize /:<CR>
  vnoremap <leader>a: :Tabularize /:<CR>
  "nnoremap <leader>a: :Tabularize /:\zs<CR>
  "vnoremap <leader>a: :Tabularize /:\zs<CR>
endif

" Scrolling
nnoremap <silent> <C-d> :call comfortable_motion#flick(400)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-400)<CR>
nnoremap <silent> <C-j> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-k> :call comfortable_motion#flick(-100)<CR>
"noremap <C-j> 2<C-e>
"noremap <C-k> 2<C-y>

inoremap <silent> <F2> <esc>:NERDTreeFind<CR>
inoremap <silent> <F3> <esc>:NERDTreeToggle<CR>
inoremap <silent> <F4> <esc>:GundoToggle<CR>
inoremap <silent> <F5> <esc>:Codi!!<CR>
inoremap <silent> <F6> <esc>:TagbarToggle<cr>
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
nnoremap <silent> <F4> :GundoToggle<CR>
nnoremap <silent> <F5> :Codi!!<CR>
nnoremap <silent> <F6> :TagbarToggle<cr>

" hexedit
inoremap <silent> <F7> <esc>:%!xxd<CR>
inoremap <silent> <F8> <esc>:%!xxd -r<CR>
noremap <silent> <F7> :%!xxd<CR>
noremap <silent> <F8> :%!xxd -r<CR>

" compile and run
noremap <silent> <leader>ccr :w<CR> :!gcc % -o %< && time %:p:r<CR>
noremap <silent> <leader>jcr :w<CR> :cd %:p:h<CR> :!javac % && time java %<<CR>

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

" qq to record, Q to replay (recursive noremap due to peekaboo)
nnoremap Q @q

" ----------------------------------------------------------------------------------------
" Surround
" ----------------------------------------------------------------------------------------
" ," Surround a word with "quotes"
nnoremap <leader>" ysiw"
vnoremap <leader>" c"<C-R>""<ESC>
" <leader>' Surround a word with 'single quotes'
nnoremap <leader>' ysiw'
vnoremap <leader>' c'<C-R>"'<ESC>
" <leader>) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
nnoremap <leader>( ysiw(
nnoremap <leader>) ysiw)
vnoremap <leader>( c( <C-R>" )<ESC>
vnoremap <leader>) c(<C-R>")<ESC>
" <leader>[ Surround a word with [brackets]
nnoremap <leader>] ysiw]
nnoremap <leader>[ ysiw[
vnoremap <leader>[ c[ <C-R>" ]<ESC>
vnoremap <leader>] c[<C-R>"]<ESC>
" <leader>{ Surround a word with {braces}
nnoremap <leader>} ysiw}
nnoremap <leader>{ ysiw{
vnoremap <leader>} c{ <C-R>" }<ESC>
vnoremap <leader>{ c{<C-R>"}<ESC>

nnoremap <leader>` ysiw`

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
