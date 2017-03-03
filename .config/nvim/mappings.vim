" vim:foldmethod=marker:foldlevel=0

""" === Mappings === {{{

noremap YY "+y<CR>
noremap <silent> <leader>p "+gP<CR>
noremap XX "+x<CR>

"" No arrow keys
"no <down> <Nop>
"no <left> <Nop>
"no <right> <Nop>
"no <up> <Nop>

"" Escaping
cnoremap <C-F> <Esc>
inoremap <C-F> <Esc>
nnoremap <C-F> <Esc>
vnoremap <C-F> <Esc>
xnoremap <C-F> <Esc>

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

" highlight last inserted text
nnoremap gV `[v`]

" go to place of last change
nnoremap g; g;zz

" clear highlighted search
noremap <silent> <leader>sc :set hlsearch! hlsearch?<cr>

" window navigation
noremap <silent> <leader>wh <C-W>h
noremap <silent> <leader>wj <C-W>j
noremap <silent> <leader>wk <C-W>k
noremap <silent> <leader>wl <C-W>l

" Split
noremap <silent> <leader>h :<C-u>split<CR>
noremap <silent> <leader>v :<C-u>vsplit<CR>

" Git
noremap <silent> <leader>gb  :Gblame<CR>
noremap <silent> <leader>gc  :Gcommit<CR>
noremap <silent> <leader>gd  :Gvdiff<CR>
noremap <silent> <leader>gps :Gpush<CR>
noremap <silent> <leader>gpu :Gpull<CR>
noremap <silent> <leader>gr  :Gremove<CR>
noremap <silent> <leader>gs  :Gstatus<CR>
noremap <silent> <leader>gw  :Gwrite<CR>

"" Asynchronous Lint Engine
"nmap <silent> [q <Plug>(ale_previous_wrap)
"nmap <silent> ]q <Plug>(ale_next_wrap)

" Neomake
nmap <silent> <leader>lo :lopen<CR>
nmap <silent> <leader>lc :lclose<CR>
nmap <silent> [q :lprevious<CR>
nmap <silent> ]q :lnext<CR>

" Tabs
nnoremap ]t gt
nnoremap [t gT
nnoremap <silent> <leader>nt :tabnew<CR>

" add space after comma
nmap <leader>, :%s/, */, /g<CR>
vmap <leader>, :s/, */, /g<CR>

" Explore dir
"nnoremap <silent> <leader>E :Lexplore<CR>
nnoremap <silent> <leader>E :NERDTreeToggle<CR>

" Buffer nav
noremap <silent> [b :bp<CR>
noremap <silent> ]b :bn<CR>
noremap <silent> <leader>q :bd!<CR>
noremap <silent> <leader>nb :enew<CR>

"noremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>b :Buffers<CR>
"nnoremap <leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>
nnoremap <leader>bs :Lines<CR>

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

if isdirectory(".git")
    " if in a git project, use :GFiles
    nnoremap <silent> <leader>e  :GFiles<cr>
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
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" folding
nnoremap <leader>f za<CR>
vnoremap <leader>f za<CR>

" vim-table-mode
noremap <silent> <leader>tm :TableModeToggle<CR>

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
"
"noremap <C-j> 2<C-e>
nnoremap <silent> <C-j> :call comfortable_motion#flick(100)<CR>
"noremap <C-k> 2<C-y>
nnoremap <silent> <C-k> :call comfortable_motion#flick(-100)<CR>

nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
nnoremap <silent> <F4> :GundoToggle<CR>
nnoremap <silent> <F5> :Codi!!<CR>
inoremap <silent> <F6> <esc>:TagbarToggle<cr>
nnoremap <silent> <F6> :TagbarToggle<cr>

" hexedit
noremap <silent> <F7> :%!xxd<CR>
noremap <silent> <F8> :%!xxd -r<CR>

" compile and run
noremap <silent> <leader>jcr :w<CR> :cd %:p:h<CR> :!javac % && java %<<CR>
noremap <silent> <leader>ccr :w<CR> :!gcc % -o %< && %:p:r<CR>

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
nmap <leader>cson   :set spell<CR>
nmap <leader>csoff :set nospell<CR>

" qq to record, Q to replay (recursive map due to peekaboo)
nmap Q @q

" ," Surround a word with "quotes"
map <leader>" ysiw"
vmap <leader>" c"<C-R>""<ESC>
" <leader>' Surround a word with 'single quotes'
map <leader>' ysiw'
vmap <leader>' c'<C-R>"'<ESC>
" <leader>) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map <leader>( ysiw(
map <leader>) ysiw)
vmap <leader>( c( <C-R>" )<ESC>
vmap <leader>) c(<C-R>")<ESC>
" <leader>[ Surround a word with [brackets]
map <leader>] ysiw]
map <leader>[ ysiw[
vmap <leader>[ c[ <C-R>" ]<ESC>
vmap <leader>] c[<C-R>"]<ESC>
" <leader>{ Surround a word with {braces}
map <leader>} ysiw}
map <leader>{ ysiw{
vmap <leader>} c{ <C-R>" }<ESC>
vmap <leader>{ c{<C-R>"}<ESC>

map <leader>` ysiw`

" nvim
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
