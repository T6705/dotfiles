" vim:foldmethod=marker:foldlevel=0

""" === Basic Setting === {{{

let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = '/usr/bin/python3.5'

let mapleader=','

" Encoding {{{
set binary
set bomb
set encoding=utf-8 " Set utf8 as standard encoding and en_US as the standard language
set fileencoding=utf-8
set fileencodings=utf-8
" }}}

" Fix backspace indent
set backspace=indent,eol,start " make backspace behave in a sane manner

" Tabs {{{
set expandtab     " Use spaces instead of tabs
set softtabstop=0
" 1 tab == 4 spaces
set shiftwidth=4  " number of spaces to use for indent and unindent
set tabstop=4     " the visible width of tabs

" Tab control
" set noexpandtab   " insert tabs rather than spaces for <Tab>
" set smarttab      " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
" set softtabstop=4 " edit as if the tabs are 4 characters wide
" set shiftround    " round indent to a multiple of 'shiftwidth'
" set completeopt+=longest
" }}}

" toggle invisible characters {{{
set invlist
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
highlight SpecialKey ctermbg=none " make the highlighting of tabs less annoying
set showbreak=↪
nmap <leader>l :set list!<cr>
" }}}

" UI {{{
colorscheme molokai
set background=dark
set cursorline
set hidden                " current buffer can be put into background
set lazyredraw            " Don't redraw while executing macros (good performance config)
set number
set ruler                 " Always show current position
set scrolloff=3
set showcmd               " show incomplete commands
set so=7                  " Set 7 lines to the cursor - when moving vertically using j/k
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
set t_Co=256              " Explicitly tell vim that the terminal supports 256 colors
set title
set titleold="Terminal"
set titlestring=%F
set ttyfast               " faster redrawing
set wildmenu              " Turn on the WiLd menu
set wildmode=list:longest " complete files like a shell
"set wildmode=full
syntax on                 " switch syntax highlighting on
" }}}

" Searching {{{
set hlsearch
set ignorecase " Ignore case when searching
set incsearch  " Makes search act like search in modern browsers
set magic      " For regular expressions turn magic on
set showmatch  " Show matching brackets when text indicator is over them
set smartcase  " When searching try to be smart about cases
" }}}

" error bells {{{
set noerrorbells
set t_vb=
set tm=500
set visualbell
" }}}

" Directories for swp files {{{
set nobackup
set noswapfile
" }}}

" Disable the vlinking cursor {{{
set gcr=a:blinkon0
set scrolloff=3
" }}}

" Status bar
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

set autoread                 " detect when a file is changed
set fileformats=unix,dos,mac
set gfn=Monospace\ 10
set guioptions=egmrti
set history=1000             " change history to 1000
set nocompatible             " not compatible with vi
set shell=/bin/zsh
""" }}}

""" === augroup === {{{
augroup configgroup

    autocmd!
    autocmd FileType * RainbowParentheses
    autocmd! BufWritePost * Neomake
    autocmd! bufwritepost .vimrc source %
    autocmd! bufwritepost init.vim source %

augroup END

""" }}}

""" === Plugin Config === {{{

" Colorizer {{{
let g:colorizer_syntax = 1
let g:colorizer_auto_map = 1
" }}}

" table-mode {{{
let g:table_mode_corner="|"
"let g:table_mode_corner_corner="+"
"let g:table_mode_header_fillchar="="
" }}}

" RainbowParentheses{{{
" junegunn/rainbow_parentheses.vim
"autocmd FileType * RainbowParentheses
let g:rainbow#max_level = 32
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{','}']]

"kien/rainbow_parentheses.vim
"let g:rbpt_colorpairs = [
"    \ ['brown',       'RoyalBlue3'],
"    \ ['Darkblue',    'SeaGreen3'],
"    \ ['darkgray',    'DarkOrchid3'],
"    \ ['darkgreen',   'firebrick3'],
"    \ ['darkcyan',    'RoyalBlue3'],
"    \ ['darkred',     'SeaGreen3'],
"    \ ['darkmagenta', 'DarkOrchid3'],
"    \ ['brown',       'firebrick3'],
"    \ ['gray',        'RoyalBlue3'],
"    \ ['darkmagenta', 'DarkOrchid3'],
"    \ ['Darkblue',    'firebrick3'],
"    \ ['darkgreen',   'RoyalBlue3'],
"    \ ['darkcyan',    'SeaGreen3'],
"    \ ['darkred',     'DarkOrchid3'],
"    \ ['red',         'firebrick3'],
"    \ ]
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
"au Syntax * RainbowParenthesesLoadChevrons
" }}}

" syntastic {{{
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
"let g:syntastic_loc_list_height = 5

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
"let g:syntastic_error_symbol = '❌'
"let g:syntastic_style_error_symbol = '⁉️'
"let g:syntastic_warning_symbol = '⚠️'
"let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

noremap <silent> <leader>s :SyntasticReset<CR>
" }}}

" NERDTree {{{
let NERDCompactSexyComs=1
let NERDSpaceDelims=1
let NERDTreeShowHidden=1
let g:NERDCustomDelimiters = { 'racket': { 'left': ';', 'leftAlt': '#|', 'rightAlt': '|#' } }
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeShowBookmarks=1
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeWinSize = 50
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeIndicatorMapCustom = {
\ "Modified"  : "✹",
\ "Staged"    : "✚",
\ "Untracked" : "✭",
\ "Renamed"   : "➜",
\ "Unmerged"  : "═",
\ "Deleted"   : "✖",
\ "Dirty"     : "✗",
\ "Clean"     : "✔︎",
\ "Unknown"   : "?"
\ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <silent> <F3> :NERDTreeToggle<CR>
" }}}

" Airline.vim {{{
let g:airline_powerline_fonts = 1
"let g:airline_theme="luna"
"let g:airline_theme="papercolor"
let g:airline_theme="wombat"
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s '
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}

" indentline {{{
let g:indentLine_char = '▸'
" }}}

" Ultsnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"}}}

" YouCompleteMe {{{
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1             " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1        " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1                " Completion in comments
let g:ycm_complete_in_strings = 1                 " Completion in string

let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']

let g:ycm_python_binary_path = '/usr/bin/python3'

" Goto definition with F3
noremap <leader>d :YcmCompleter GoTo<CR>
"}}}

" instant_markdown {{{
let g:instant_markdown_autostart = 0
"}}}

" Codi.vim {{{
let g:codi#interpreters = {
                   \ 'python': {
                       \ 'bin': 'python3',
                       \ 'prompt': '^\(>>>\|\.\.\.\) ',
                       \ },
                       \ }
" }}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#sources#jedi#show_docstring = 0
" }}}


function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" neomake {{{
let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {
    \   'text': '⚠',
    \   'texthl': 'NeomakeWarningSign',
    \ }
let g:neomake_message_sign = {
     \   'text': '➤',
     \   'texthl': 'NeomakeMessageSign',
     \ }
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

" Python2/3 {{{
    " $ sudo pip2/pip3 install -U flake8 pep8 vulture
    "let g:neomake_python_enabled_makers = ['pylint', 'flake8', 'pep8', 'vulture']
    let g:neomake_python_enabled_makers = ['flake8', 'pep8', 'vulture']
    " E501 is line length of 80 characters
    let g:neomake_python_flake8_maker = { 'args': ['--ignore=E115,E266,E501,E302'], }
    let g:neomake_python_pep8_maker = { 'args': ['--max-line-length=100', '--ignore=E115,E266,E302'], }
" }}}

" php {{{
    let g:neomake_php_enabled_makers = ['phpcs', 'php', 'phpmd']
" }}}

" run neomake on the current file on every write:
"autocmd! BufWritePost * Neomake
" }}}

" Pymode{{{
"let g:pymode_options = 1　　                                " Setup default python options
"let g:pymode_options_max_line_length = 79                   " Setup max line length
let g:pymode = 1                            " enable Pymode
let g:pymode_breakpoint_bind = '<leader>pb' " add breakpoint with ,pb
let g:pymode_doc = 1                        " read doc :PymodeDoc arg
let g:pymode_doc_bind = 'K'                 " press K to show doc for current word
let g:pymode_folding = 0                    " disable folding
let g:pymode_indent = 1                     " pep8 indent style
let g:pymode_python = 'python3'
let g:pymode_rope = 0                       " Disable rope
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>pr'        " run python code with ,pr
let g:pymode_trim_whitespaces = 1           " Trim unused white spaces on save
let g:pymode_virtualenv = 1                 " Enable automatic virtualenv detection

""" linting code with neomake
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_on_fly = 0
let g:pymode_lint_on_write = 0
let g:pymode_lint_unmodified = 0
" }}}

" vim-slash {{{
function! s:blink(times, delay)
  let s:blink = { 'ticks': 2 * a:times, 'delay': a:delay }

  function! s:blink.tick(_)
    let self.ticks -= 1
    let active = self == s:blink && self.ticks > 0

    if !self.clear() && active && &hlsearch
      let [line, col] = [line('.'), col('.')]
      let w:blink_id = matchadd('IncSearch',
            \ printf('\%%%dl\%%>%dc\%%<%dc', line, max([0, col-2]), col+2))
    endif
    if active
      call timer_start(self.delay, self.tick)
    endif
  endfunction

  function! s:blink.clear()
    if exists('w:blink_id')
      call matchdelete(w:blink_id)
      unlet w:blink_id
      return 1
    endif
  endfunction

  call s:blink.clear()
  call s:blink.tick(0)
  return ''
endfunction

if has('timers')
  "if has_key(g:plugs, 'vim-slash')
  "  noremap <expr> <plug>(slash-after) <sid>blink(2, 50)
  "else
  "  noremap <expr> n 'n'.<sid>blink(2, 50)
  "  noremap <expr> N 'N'.<sid>blink(2, 50)
  "  cnoremap <expr> <cr> (stridx('/?', getcmdtype()) < 0 ? '' : <sid>blink(2, 50))."\<cr>"
  "endif
  "noremap <expr> <plug>(slash-after) <sid>blink(2, 50)
  noremap <expr> n 'n'.<sid>blink(2, 50)
  noremap <expr> N 'N'.<sid>blink(2, 50)
  cnoremap <expr> <cr> (stridx('/?', getcmdtype()) < 0 ? '' : <sid>blink(2, 50))."\<cr>"
endif
" }}}

""" }}}

""" === Load plugins === {{{
"call plug#begin('~/.config/nvim/plugged')
silent! if plug#begin('~/.config/nvim/plugged')

"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
"Plug 'kien/rainbow_parentheses.vim'
"Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
"Plug 'scrooloose/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'benekastah/neomake' " neovim replacement for syntastic using neovim's job control functonality
Plug 'chrisbra/Colorizer', { 'on': 'ColorToggle' }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-slash'
Plug 'klen/python-mode', { 'for': 'python' }
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim', { 'for': 'html' } " emmet support for vim - easily create markdup wth CSS-like syntax
Plug 'metakirby5/codi.vim', { 'on': 'Codi!!' }
Plug 'morhetz/gruvbox'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
call plug#end()
endif
""" }}}

""" === Mappings === {{{
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif
noremap YY "+y<CR>
noremap <silent> <leader>p "+gP<CR>
noremap XX "+x<CR>

"" No arrow keys
"no <down> <Nop>
"no <left> <Nop>
"no <right> <Nop>
"no <up> <Nop>

"" jk | Escaping!
"inoremap jk <Esc>
"xnoremap jk <Esc>
"cnoremap jk <C-c>

"" Escaping
cnoremap <C-q> <Esc>
inoremap <C-q> <Esc>
nnoremap <C-q> <Esc>
vnoremap <C-q> <Esc>
xnoremap <C-q> <Esc>

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

" clear highlighted search
noremap <silent> <Leader>sc :set hlsearch! hlsearch?<cr>

" Split
noremap <silent> <Leader>h :<C-u>split<CR>
noremap <silent> <Leader>v :<C-u>vsplit<CR>

" Git
noremap <silent> <Leader>gb  :Gblame<CR>
noremap <silent> <Leader>gc  :Gcommit<CR>
noremap <silent> <Leader>gd  :Gvdiff<CR>
noremap <silent> <Leader>gps :Gpush<CR>
noremap <silent> <Leader>gpu :Gpull<CR>
noremap <silent> <Leader>gr  :Gremove<CR>
noremap <silent> <Leader>gs  :Gstatus<CR>
noremap <silent> <Leader>gw  :Gwrite<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" add space after comma and remove extra whitespace
"nmap <leader><space> :%s/, */, /g<CR>:%s/\s\+$<CR>
nmap <leader><space> :%s/\s\+$<CR>
nmap <leader><space><space> :%s/, */, /g<CR>

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
nnoremap <silent> <Leader>` :Marks<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

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

" Enable folding
"set foldmethod=marker
set foldmethod=indent
set foldlevel=99
set nofoldenable            " don't fold by default<Paste>
nnoremap <SPACE> za<CR>
vnoremap <SPACE> za<CR>

" vim-table-mode
noremap <silent> <Leader>tm :TableModeToggle<CR>

" Tabular
if exists(":Tabularize")
  nnoremap <Leader>a= :Tabularize /=<CR>
  vnoremap <Leader>a= :Tabularize /=<CR>
  nnoremap <Leader>a: :Tabularize /:<CR>
  vnoremap <Leader>a: :Tabularize /:<CR>
  "nnoremap <Leader>a: :Tabularize /:\zs<CR>
  "vnoremap <Leader>a: :Tabularize /:\zs<CR>
endif


" Scrolling
noremap <C-j> 2<C-e>
noremap <C-k> 2<C-y>

noremap <silent> <F4> :GundoToggle<CR>
noremap <silent> <F5> :Codi!!<CR>
noremap <silent> <F6> :TagbarToggle<CR>

" hexedit
noremap <silent> <F7> :%!xxd<CR>
noremap <silent> <F8> :%!xxd -r<CR>

noremap <silent> <F9> :w <CR> :!gcc % -o %< && ./%< <CR>

" ----------------------------------------------------------------------------
" nvim
" ----------------------------------------------------------------------------
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    "tnoremap <a-a> <esc>a
    "tnoremap <a-b> <esc>b
    "tnoremap <a-d> <esc>d
    "tnoremap <a-f> <esc>f
endif

""" }}}

""" === Functions === {{{

" ----------------------------------------------------------------------------
" :Shuffle | Shuffle selected lines
" ----------------------------------------------------------------------------

function! s:shuffle() range
ruby << RB
  first, last = %w[a:firstline a:lastline].map { |e| VIM::evaluate(e).to_i }
  (first..last).map { |l| $curbuf[l] }.shuffle.each_with_index do |line, i|
    $curbuf[first + i] = line
  end
RB
endfunction
command! -range Shuffle <line1>,<line2>call s:shuffle()


""" }}}
