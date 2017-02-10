" vim:foldmethod=marker:foldlevel=0

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

""" === Load plugins === {{{

silent! if plug#begin('~/.config/nvim/plugged')

" ----------------------------------------------------------------------------------------
" ColorScheme
" ----------------------------------------------------------------------------------------
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'



" ----------------------------------------------------------------------------------------
" latex
" ----------------------------------------------------------------------------------------
if has('nvim')
    Plug 'donRaphaco/neotex', { 'do': function('DoRemote'), 'for': 'tex' }
endif
Plug 'lervag/vimtex', { 'for': 'tex' }



" ----------------------------------------------------------------------------------------
" markdown
" ----------------------------------------------------------------------------------------
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'suan/vim-instant-markdown', { 'for': 'markdown', 'on': 'InstantMarkdownPreview' }



" ----------------------------------------------------------------------------------------
" java
" ----------------------------------------------------------------------------------------
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }



" ----------------------------------------------------------------------------------------
" python
" ----------------------------------------------------------------------------------------
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'klen/python-mode', { 'for': 'python' }



" ----------------------------------------------------------------------------------------
" html
" ----------------------------------------------------------------------------------------
Plug 'mattn/emmet-vim', { 'for': ['html', 'php'] } " emmet support for vim - easily create markdup wth CSS-like syntax



" ----------------------------------------------------------------------------------------
" lint
" ----------------------------------------------------------------------------------------
"Plug 'w0rp/ale', { 'for': ['python', 'php', 'c'] }
Plug 'benekastah/neomake' " neovim replacement for syntastic using neovim's job control functonality



"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
    Plug 'mklabs/split-term.vim'
else
    Plug 'Shougo/neocomplete.vim'
endif
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'chrisbra/Colorizer', { 'on': 'ColorToggle' }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'metakirby5/codi.vim', { 'on': 'Codi!!' }
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yuttie/comfortable-motion.vim'
call plug#end()
endif

""" }}}
