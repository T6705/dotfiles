let mapleader=','

"" Encoding
set binary
set bomb
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs
set expandtab
set shiftwidth=4
set softtabstop=0
set tabstop=4

"" Tab control
" set noexpandtab " insert tabs rather than spaces for <Tab>
" set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
" set tabstop=4 " the visible width of tabs
" set softtabstop=4 " edit as if the tabs are 4 characters wide
" set shiftwidth=4 " number of spaces to use for indent and unindent
" set shiftround " round indent to a multiple of 'shiftwidth'
" set completeopt+=longest

"" toggle invisible characters
set invlist
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
highlight SpecialKey ctermbg=none " make the highlighting of tabs less annoying
set showbreak=↪
nmap <leader>l :set list!<cr>

"" UI
colorscheme molokai
set background=dark
set cursorline
set hidden
set number
set ruler
set scrolloff=3 
set showcmd
set so=7
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
set t_Co=256
set title
set titleold="Terminal"
set titlestring=%F
set ttyfast
set wildmenu
syntax on

"" Searching
set hlsearch
set smartcase
set ignorecase
set incsearch
set magic

"" Directories for swp files
set nobackup
set noswapfile

"" Disable the vlinking cursor
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set autoread
set fileformats=unix,dos,mac
set gfn=Monospace\ 10
set guioptions=egmrti
set shell=/bin/zsh

" syntastic {{{
augroup syntastic 
    autocmd!

    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='⚠'
    let g:syntastic_style_error_symbol = '✗'
    let g:syntastic_style_warning_symbol = '⚠'
    let g:syntastic_auto_loc_list=1
    let g:syntastic_check_on_open=0
    let g:syntastic_check_on_wq=0
    let g:syntastic_aggregate_errors = 1
    noremap <leader>s :SyntasticReset<CR>
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

" Shougo {{{
augroup Shougo_config
    autocmd!

    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
augroup END
" }}}

let g:indentLine_char = '▸'

"let g:deoplete#enable_at_startup = 1
"
"function! DoRemote(arg)
"    UpdateRemotePlugins
"endfunction

" Load plugins {{{
call plug#begin('~/.config/nvim/plugged')

Plug 'FelikZ/ctrlp-py-matcher'
Plug 'JulesWang/css.vim'
Plug 'LaTeX-Box-Team/LaTeX-Box'
"Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color', { 'for': ['css','stylus','scss'] } 
Plug 'chrisbra/Colorizer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'elzr/vim-json'
Plug 'elzr/vim-json', { 'for': 'json' } 
Plug 'fatih/vim-go', { 'for': 'go' } "
Plug 'flazz/vim-colorschemes'
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-clojure-static'
Plug 'honza/vim-snippets'
Plug 'itchyny/calendar.vim'
Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' }
Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' } 
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
Plug 'kchmck/vim-coffee-script'
Plug 'kien/rainbow_parentheses.vim'
Plug 'kshenoy/vim-signature'
Plug 'lervag/vimtex'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mxw/vim-jsx', { 'for': 'jsx' } 
Plug 'nathanaelkane/vim-indent-guides'
Plug 'noprompt/vim-yardoc'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rhysd/vim-crystal'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'suan/vim-instant-markdown'
Plug 'terryma/vim-multiple-cursors'
Plug 'thoughtbot/vim-rspec'
Plug 'tomasr/molokai'
Plug 'toyamarinyon/vim-swift'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-leiningen'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/fish.vim',   { 'for': 'fish' }
Plug 'vim-scripts/jade.vim',   { 'for': 'jade' }
Plug 'vim-scripts/matchit.zip' 
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

if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

"" No arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>

ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> 0 g0
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" clear highlighted search
noremap <Leader>sc :set hlsearch! hlsearch?<cr>

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

"" dragvisuals.vim
runtime plugin/dragvisuals.vim
" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

"" Enable folding
set foldmethod=indent
set foldlevel=99
noremap <SPACE> za<CR>

""RainbowParentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

"" Scrolling
noremap <C-j> 2<C-e>
noremap <C-k> 2<C-y>

"" hexedit
noremap <F7> :%!xxd<CR>
noremap <F8> :%!xxd -r<CR>

noremap <F5> :UndotreeToggle<CR>
noremap <F6> :TagbarToggle<CR>
