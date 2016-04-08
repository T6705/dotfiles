colorscheme molokai
let mapleader=','
set background=dark
set backspace=indent,eol,start
set binary
set bomb
set cursorline
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set gcr=a:blinkon0
set gfn=Monospace\ 10
set guioptions=egmrti
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set modeline
set modelines=10
set nobackup
set noswapfile
set number
set ruler
set scrolloff=3
set shell=/bin/zsh
set shiftwidth=4
set showcmd
set smartcase
set softtabstop=0
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
set t_Co=256
set tabstop=4
set title
set titleold="Terminal"
set titlestring=%F
set ttyfast
syntax on

" syntastic {{{
augroup syntastic 
  autocmd!

  let g:syntastic_always_populate_loc_list=1
  let g:syntastic_error_symbol='✗'
  let g:syntastic_warning_symbol='⚠'
  let g:syntastic_style_error_symbol = '✗'
  let g:syntastic_style_warning_symbol = '⚠'
  let g:syntastic_auto_loc_list=1
  let g:syntastic_check_on_open=1
  let g:syntastic_check_on_wq=0
  let g:syntastic_aggregate_errors = 1
augroup END
" }}}

" NERDTree {{{
augroup nerdtree
  autocmd!

  let NERDSpaceDelims=1
  let NERDCompactSexyComs=1
  let g:NERDCustomDelimiters = { 'racket': { 'left': ';', 'leftAlt': '#|', 'rightAlt': '|#' } }
  let g:NERDTreeChDirMode=2
  let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
  let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
  let g:NERDTreeShowBookmarks=1
  let g:nerdtree_tabs_focus_on_files=1
  let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
  let g:NERDTreeWinSize = 50
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
  nnoremap <silent> <F2> :NERDTreeFind<CR>
  noremap <F3> :NERDTreeToggle<CR>
augroup END
" }}}

" Airline.vim {{{
augroup airline_config
  autocmd!
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
augroup END
" }}}

" Load plugins {{{
call plug#begin('~/.config/nvim/plugged')

Plug 'FelikZ/ctrlp-py-matcher'
Plug 'JulesWang/css.vim'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'SirVer/ultisnips'
Plug 'ap/vim-css-color'
Plug 'chrisbra/Colorizer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'elzr/vim-json'
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-clojure-static'
Plug 'honza/vim-snippets'
Plug 'itchyny/calendar.vim'
Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
Plug 'kchmck/vim-coffee-script'
Plug 'kshenoy/vim-signature'
Plug 'lervag/vimtex'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'noprompt/vim-yardoc'
Plug 'pangloss/vim-javascript', { 'branch': 'develop' }
Plug 'rhysd/vim-crystal'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'thoughtbot/vim-rspec'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-leiningen'
Plug 'tpope/vim-markdown',     { 'for': 'markdown' }
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/fish.vim',   { 'for': 'fish' }
Plug 'vim-scripts/jade.vim',   { 'for': 'jade' }
Plug 'wavded/vim-stylus',      { 'for': 'stylus' }
Plug 'wlangstroth/vim-racket'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
call plug#end()
" }}}

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

"" No arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>

ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>gw :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gps :Gpush<CR>
noremap <Leader>gpu :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Explore dir
nnoremap <leader>E :Explore<CR>

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Switching windows
"" noremap <C-j> <C-w>j
"" noremap <C-k> <C-w>k
"" noremap <C-l> <C-w>l
"" noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Enable folding
set foldmethod=indent
set foldlevel=99
noremap <SPACE> za<CR>

"" Scrolling
noremap <C-j> <C-e>
noremap <C-k> <C-y>

"" hexedit
noremap <F7> :%!xxd<CR>
noremap <F8> :%!xxd -r<CR>

noremap <F4> :ColorToggle<CR>
noremap <F5> :UndotreeToggle<CR>
noremap <F6> :TagbarToggle<CR>
