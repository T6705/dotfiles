" vim:foldmethod=marker:foldlevel=0

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --gocode-completer
  endif
endfunction

" vim-plug automatic installation
if has('nvim')
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

""" === Load plugins === {{{

silent! if plug#begin('~/.config/nvim/plugged')

" ----------------------------------------------------------------------------------------
" ColorScheme
" ----------------------------------------------------------------------------------------
Plug 'AlessandroYorba/Monrovia'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'flazz/vim-colorschemes'
Plug 'google/vim-colorscheme-primary'
Plug 'morhetz/gruvbox'
Plug 'roosta/vim-srcery'
Plug 'tomasr/molokai'


" ----------------------------------------------------------------------------------------
" Interface
" ----------------------------------------------------------------------------------------
Plug 'Yggdroot/indentLine'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


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
" python
" ----------------------------------------------------------------------------------------
Plug 'klen/python-mode', { 'for': 'python' }


" ----------------------------------------------------------------------------------------
" html
" ----------------------------------------------------------------------------------------
Plug 'mattn/emmet-vim', { 'for': ['html', 'php'] } " emmet support for vim - easily create markdup wth CSS-like syntax


" ----------------------------------------------------------------------------------------
" lint & autoformat
" ----------------------------------------------------------------------------------------
"Plug 'google/vim-codefmt', { 'on': ['FormatLines', 'FormatCode']}
"Plug 'google/vim-glaive'
"Plug 'google/vim-maktaba'
"Plug 'w0rp/ale'
Plug 'benekastah/neomake' " neovim replacement for syntastic using neovim's job control functonality
Plug 'metakirby5/codi.vim', { 'on': 'Codi!!' }


" ----------------------------------------------------------------------------------------
" Auto Completion
" ----------------------------------------------------------------------------------------
Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'go', 'php', 'python', 'java'], 'do': function('BuildYCM') }
"Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
"Plug 'davidhalter/jedi-vim', { 'for': 'python' }


" ----------------------------------------------------------------------------------------
" textobj
" ----------------------------------------------------------------------------------------
Plug 'kana/vim-textobj-user'     " Create your own textobj
Plug 'akiyan/vim-textobj-php', { 'for' : 'php' } " aP/iP for a range between the PHP delimiters such as <?php and ?>
Plug 'deris/vim-textobj-ipmac'   " aA/iA for ipv4, ipv6, MAC Address
Plug 'kana/vim-textobj-datetime' " ada/ida and others for date and time such as 2013-03-13, 19:51:45, 2013-03-13T19:51:50
Plug 'kana/vim-textobj-indent'   " ai/ii for a block of similarly indented lines / aI/iI for a block of lines with the same indentation
Plug 'mattn/vim-textobj-url'     " au/iu for a URL


" ----------------------------------------------------------------------------------------
" utilities
" ----------------------------------------------------------------------------------------
"Plug 'ryanoasis/nerd-fonts', { 'do': './install.sh' }
"Plug 'ryanoasis/vim-devicons'
"Plug 'yuttie/comfortable-motion.vim'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
    Plug 'mklabs/split-term.vim'

    "" Ranger integration in neovim
    "Plug 'francoiscabrol/ranger.vim', { 'on': ['Ranger',
    "            \'RangerNewTab',
    "            \'RangerCurrentDirectory',
    "            \'RangerCurrentDirectoryNewTab',
    "            \'RangerWorkingDirectory',
    "            \'RangerWorkingDirectoryNewTab'] }
    "            \| Plug 'rbgrouleff/bclose.vim'
else
    Plug 'Shougo/neocomplete.vim'
endif
"Plug 'chrisbra/csv.vim', { 'for': 'csv' }
"Plug 'jiangmiao/auto-pairs'
Plug 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'SirVer/ultisnips'
Plug 'benmills/vimux'
Plug 'chrisbra/Colorizer', { 'on': 'ColorToggle' }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'easymotion/vim-easymotion', { 'on' : ['<Plug>(easymotion-prefix)',
            \'<Plug>(easymotion-overwin-line)',
            \'<Plug>(easymotion-overwin-f2)',
            \'<Plug>(easymotion-overwin-w)',
            \'<Plug>(easymotion-overwin-f)'] }
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat' " enables repeating other supported plugins with the . command
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
call plug#end()
endif

""" }}}
