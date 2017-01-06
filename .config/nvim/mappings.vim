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
nnoremap B ^
nnoremap E $

" highlight last inserted text
nnoremap gV `[v`]

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

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" add space after comma
nmap <leader>, :%s/, */, /g<CR>
vmap <leader>, :'<,'>s/, */, /g<CR>

" Explore dir
nnoremap <silent> <leader>E :Explore<CR>

" Buffer nav
noremap <silent> <leader>z :bp<CR>
noremap <silent> <leader>q :bd!<CR>
noremap <silent> <leader>x :bn<CR>
noremap <silent> <leader>w :enew<CR>

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

noremap <silent> <F4> :GundoToggle<CR>
noremap <silent> <F5> :Codi!!<CR>
inoremap <silent> <F6> <esc>:TagbarToggle<cr>
nnoremap <silent> <F6> :TagbarToggle<cr>

" hexedit
noremap <silent> <F7> :%!xxd<CR>
noremap <silent> <F8> :%!xxd -r<CR>

noremap <silent> <F9> :w<CR> :!gcc % -o %< && ./%<<CR>

" Markdown headings
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

"nnoremap <leader>pdf :w<CR> :NeoTex<CR>
nnoremap <leader>apdf :w<CR> :!pandoc % --latex-engine=pdflatex -o %<.pdf<CR>
nnoremap <leader>pdf :w<CR> :VimtexCompile<CR>:NeoTexOn<CR>

" qq to record, Q to replay (recursive map due to peekaboo)
nmap Q @q

" nvim
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    "tnoremap <a-a> <esc>a
    "tnoremap <a-b> <esc>b
    "tnoremap <a-d> <esc>d
    "tnoremap <a-f> <esc>f
endif

""" }}}
