" vim:foldmethod=marker:foldlevel=0

fu! DoRemote(arg)
    UpdateRemotePlugins
endfu

fu! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --gocode-completer --java-completer
  endif
endfu

fu! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfu

" vim-plug automatic installation
if has('nvim')
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
        if !executable("curl")
            echoerr "You have to install curl or first install vim-plug yourself!"
            exe "q!"
        endif
        echo "Installing Vim-Plug..."
        echo ""
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        au VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
        if !executable("curl")
            echoerr "You have to install curl or first install vim-plug yourself!"
            exe "q!"
        endif
        echo "Installing Vim-Plug..."
        echo ""
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        au VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

""" === Load plugins === {{{
silent! if plug#begin('~/.config/nvim/plugged')

" === ColorScheme === {{{
Plug 'NLKNguyen/papercolor-theme'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'flazz/vim-colorschemes'
Plug 'google/vim-colorscheme-primary'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'roosta/vim-srcery'
Plug 'tomasr/molokai'
" }}}

" === Interface === {{{
Plug 'Yggdroot/indentLine'            " A vim plugin to display the indention levels with thin vertical lines
Plug 'ncm2/float-preview.nvim'        " Less annoying completion preview window based on neovim's floating window
Plug 'vim-airline/vim-airline'        " lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes' " A collection of themes for vim-airline
" }}}

" === markdown === {{{
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
"Plug 'plasticboy/vim-markdown', { 'for': 'markdown', 'on': [] }
Plug 'junegunn/goyo.vim', { 'on' : 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on' : 'Goyo' }
" }}}

" === golang === {{{
if executable("go")
    "Plug 'jodosha/vim-godebug', { 'for': 'go' }                      " Go debugging for Vim
    Plug 'buoto/gotests-vim', { 'for': 'go' }                        " Generate Go tests from your source code.
    Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' } " Go development plugin for Vim
    Plug 'sebdah/vim-delve', { 'for': 'go' }                         " Neovim / Vim integration for Delve
endif
" }}}

" === git === {{{
if executable("git")
    Plug 'airblade/vim-gitgutter'                                    " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
    Plug 'rbong/vim-flog', { 'on': ['Flog', 'Flogsplit', 'Flogit'] } " A lightweight and powerful git branch viewer for vim.
    Plug 'rhysd/git-messenger.vim', { 'on' : 'GitMessenger' }        " Vim plugin to show the last commit message under the cursor
    Plug 'tpope/vim-fugitive', { 'on' : ['Gblame', 'Gcommit', 'Gvdiff', 'Gpush', 'Gpull', 'Gremove', 'Gstatus', 'Gwrite'] }  " fugitive.vim: a Git wrapper so awesome, it should be illegal
endif
" }}}

" === lint & autoformat === {{{
"Plug 'dense-analysis/ale'                                " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'psf/black', { 'branch': 'stable', 'for': 'python'} " The uncompromising Python code formatter
" }}}

if executable('node')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" === Snippet === {{{
if v:version >= 704
    Plug 'SirVer/ultisnips'       " The ultimate snippet solution for Vim.
    Plug 'honza/vim-snippets'         " vim-snipmate default snippets
endif
"Plug 'Shougo/neosnippet'          " snippets support
"Plug 'Shougo/neosnippet-snippets' " The standard snippets repository for neosnippet
" }}}

" === utilities === {{{
"Plug 'AlphaMycelium/pathfinder.vim'                                                                               " Vim plugin which gives suggestions to improve your movements
"Plug 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }                                                             " perform diffs on blocks of code
"Plug 'VincentCordobes/vim-translate', { 'on': 'Translate' }                                                       " A tiny translate-shell wrapper for Vim.
"Plug 'benmills/vimux'                                                                                             " vim plugin to interact with tmux
"Plug 'camspiers/animate.vim'                                                                                      " A Vim Window Animation Library
"Plug 'camspiers/lens.vim'                                                                                         " A Vim Automatic Window Resizing Plugin
"Plug 'chrisbra/vim-diff-enhanced'                                                                                 " Better Diff options for Vim
"Plug 'dbeniamine/cheat.sh-vim'                                                                                    " A vim plugin to access cheat.sh sheets
"Plug 'easymotion/vim-easymotion'                                                                                  " Vim motions on speed!
"Plug 'ekalinin/Dockerfile.vim'                                                                                    " Vim syntax file & snippets for Docker's Dockerfile
"Plug 'itchyny/vim-cursorword'                                                                                     " Underlines the word under the cursor
"Plug 'kana/vim-operator-user'                                                                                     " Vim plugin: Define your own operator easily
"Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }                                                     " Modern performant generic finder and dispatcher for Vim and NeoVim
"Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }                                        " Helps you win at grep
"Plug 'paroxayte/vwm.vim'                                                                                          " A highly extensible window manager for nvim/vim!
"Plug 'ryanoasis/nerd-fonts', { 'do': './install.sh' }
"Plug 'simrat39/symbols-outline.nvim'                                                                              " A tree like view for symbols
"Plug 'thiagoalessio/rainbow_levels.vim', { 'on': ['RainbowLevelsOn', 'RainbowLevelsOff', 'RainbowLevelsToggle'] } " A different approach to code highlighting
"Plug 'unblevable/quick-scope'                                                                                     " Lightning fast left-right movement in Vim
"Plug 'will133/vim-dirdiff', { 'on': 'DirDiff' }                                                                   " Vim plugin to diff two directories
if has('python3')
    Plug 'brianrodri/vim-sort-folds'                   " Sort vim folds based on their first line.
endif
if v:version >= 703
    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' } " Vim plugin that displays tags in a window, ordered by scope
endif
if v:version >= 800
    Plug 'TaDaa/vimade'                                " An eye friendly plugin that fades your inactive buffers and preserves your syntax highlighting!
endif
Plug 'Shougo/vimproc.vim', { 'do': 'make' }                                  " Interactive command execution in Vim.
Plug 'andymass/vim-matchup'                                                  " vim match-up: matchit replacement and more
Plug 'cometsong/CommentFrame.vim'                                            " generate fancy-looking comments/section dividers with centered titles and append them at the current cursor position.
Plug 'danilamihailov/beacon.nvim'                                            " see your cursor jump
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }               " VIM Table Mode for instant table creation.
Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' }                     " A Vim plugin for profiling Vim's startup time
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }                  " A more adventurous wildmenu
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                          " A command-line fuzzy finder
Plug 'junegunn/fzf.vim'                                                      " use fzf on Vim
Plug 'junegunn/rainbow_parentheses.vim'                                      " Simpler Rainbow Parentheses
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " A Vim alignment plugin
Plug 'junegunn/vim-peekaboo'                                                 " show you the contents of the registers
Plug 'junegunn/vim-slash'                                                    " Enhancing in-buffer search experience
Plug 'kshenoy/vim-signature'                                                 " Plugin to toggle, display and navigate marks
Plug 'liuchengxu/vista.vim'                                                  " Viewer & Finder for LSP symbols and tags
Plug 'ludovicchabant/vim-gutentags'                                          " A Vim plugin that manages your tag files
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                  " Nvim Treesitter configurations and abstraction layer
Plug 'psliwka/vim-smoothie'                                                  " Smooth scrolling for Vim done right
Plug 'romainl/vim-qf'                                                        " Tame the quickfix window
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }                    " displaying the colours in the file
Plug 'ryanoasis/vim-devicons'                                                " Adds file type glyphs/icons to popular Vim plugins
Plug 'scrooloose/nerdcommenter'                                              " Vim plugin for intensely orgasmic commenting
Plug 'simrat39/symbols-outline.nvim'                                         " A tree like view for symbols
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }                                " Visualize your undo tree.
Plug 'skywind3000/gutentags_plus'                                            " The right way to use gtags with gutentags
Plug 'terryma/vim-multiple-cursors'                                          " True Sublime Text style multiple selections for Vim
Plug 'tpope/vim-repeat'                                                      " enables repeating other supported plugins with the . command
Plug 'tpope/vim-surround'                                                    " surround.vim: quoting/parenthesizing made simple
Plug 'voldikss/vim-floaterm', Cond(has('nvim'),  { 'on': 'FloatermToggle' }) " Open the terminal in the floating window and toggle it quickly
Plug 'wellle/targets.vim'                                                    " Vim plugin that provides additional text objects
call plug#end()
endif
" }}}

""" }}}
