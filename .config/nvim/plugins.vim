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

" === Auto Completion === {{{
"if has('python3')
"    if has('nvim')
"        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"    elseif v:version >= 800
"        Plug 'Shougo/deoplete.nvim' " Dark powered asynchronous completion framework for neovim/Vim8
"        Plug 'roxma/nvim-yarp'      " Yet Another Remote Plugin Framework for Neovim
"        Plug 'roxma/vim-hug-neovim-rpc'
"    endif
"    "Plug 'zchee/deoplete-jedi', { 'for' : 'python' }
"    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' } " Language Server Protocol for vim and neovim
"    Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript', 'do': 'npm install -g tern' }
"    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
"    Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
"    Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
"    Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp'] }
"    Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make'}
"endif

"if executable("tmux")
"    Plug 'prabirshrestha/async.vim'
"    Plug 'prabirshrestha/asyncomplete.vim'
"    Plug 'wellle/tmux-complete.vim' " Vim plugin for insert mode completion of words in adjacent tmux panes
"endif
" }}}

" === textobj === {{{
"Plug 'kana/vim-textobj-user'                    " Create your own textobj
"Plug 'akiyan/vim-textobj-php', { 'for': 'php' } " aP/iP for a range between the PHP delimiters such as <?php and ?>
"Plug 'deris/vim-textobj-ipmac'                  " aA/iA for ipv4, ipv6, MAC Address
"Plug 'kana/vim-textobj-datetime'                " ada/ida and others for date and time such as 2013-03-13, 19:51:45, 2013-03-13T19:51:50
"Plug 'kana/vim-textobj-indent'                  " ai/ii for a block of similarly indented lines / aI/iI for a block of lines with the same indentation
"Plug 'mattn/vim-textobj-url'                    " au/iu for a URL
" }}}

" === javascript / typescript === {{{
" Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
"Plug 'burnettk/vim-angular', { 'for': '*js' }                                                " AngularJS with Vim
"Plug 'leafgarland/typescript-vim', { 'for': ['*ts', '*tsx'] }                                " Typescript syntax files for Vim
"Plug 'moll/vim-node', { 'for': '*js' }                                                       " Tools and environment to make Vim superb for developing with Node.js
"Plug 'mxw/vim-jsx', { 'for': ['*js', '*jsx'] }                                               " React JSX syntax highlighting and indenting for vim.
"Plug 'othree/yajs.vim', { 'for': ['*js', '*jsx', '*html'] }                                  " Yet Another JavaScript Syntax for Vim
"Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' } " Tern plugin for Vim
" }}}

" === latex === {{{
"Plug 'donRaphaco/neotex', Cond(has('nvim'), { 'do': function('DoRemote'), 'for': 'tex' })
"Plug 'lervag/vimtex', { 'for': 'tex' }
" }}}

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
if has('nvim')
    Plug 'ncm2/float-preview.nvim'    " Less annoying completion preview window based on neovim's floating window
endif
Plug 'Yggdroot/indentLine'            " A vim plugin to display the indention levels with thin vertical lines
Plug 'vim-airline/vim-airline'        " lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes' " A collection of themes for vim-airline
" }}}

" === markdown === {{{
"Plug 'plasticboy/vim-markdown', { 'for': 'markdown', 'on': [] }
Plug 'junegunn/goyo.vim', { 'on' : 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on' : 'Goyo' }
Plug 'suan/vim-instant-markdown', { 'on': 'InstantMarkdownPreview' }
" }}}

" === golang === {{{
if executable("go")
    "Plug 'jodosha/vim-godebug', { 'for': 'go' }                      " Go debugging for Vim
    Plug 'buoto/gotests-vim', { 'for': 'go' }                        " Generate Go tests from your source code.
    Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' } " Go development plugin for Vim
    Plug 'sebdah/vim-delve', { 'for': 'go' }                         " Neovim / Vim integration for Delve
endif
" }}}

" === dart === {{{
if executable("dart")
    Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
endif
" }}}

" === html === {{{
Plug 'mattn/emmet-vim', { 'for': ['*html', '*css', '*jsx', '*php'] } " emmet support for vim - easily create markdup wth CSS-like syntax
" }}}

" === json === {{{
"Plug 'elzr/vim-json' " A better JSON for Vim
" }}}

" === rust === {{{
Plug 'rust-lang/rust.vim', { 'for': 'rust' } " Vim configuration for Rust.
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
"Plug 'google/vim-codefmt', { 'on': ['FormatLines', 'FormatCode']}
"Plug 'google/vim-glaive'
"Plug 'google/vim-maktaba'
"Plug 'skywind3000/vim-rt-format', { 'do': 'pip3 install autopep8' } " Prettify Current Line on Enter
Plug 'dense-analysis/ale'                                " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'metakirby5/codi.vim', { 'on': 'Codi!!' }           " The interactive scratchpad for hackers.
Plug 'psf/black', { 'branch': 'stable', 'for': 'python'} " The uncompromising Python code formatter
" }}}

if executable('node')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
else
    Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'go', 'java', 'python'], 'do': function('BuildYCM') } " A code-completion engine for Vim
    Plug 'zxqfl/tabnine-vim' " Vim client for TabNine
endif

" === Snippet === {{{
if v:version >= 704
    Plug 'SirVer/ultisnips'       " The ultimate snippet solution for Vim.
    Plug 'honza/vim-snippets'         " vim-snipmate default snippets
endif
"Plug 'Shougo/neosnippet'          " snippets support
"Plug 'Shougo/neosnippet-snippets' " The standard snippets repository for neosnippet
" }}}

" === file explorer === {{{
"Plug 'scrooloose/nerdtree'                     " file tree
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Extra syntax and highlight for nerdtree files
"Plug 'Xuyuanp/nerdtree-git-plugin'             " git status
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' } " The dark powered file explorer implementation
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
else
  Plug 'Shougo/defx.nvim'     " The dark powered file explorer implementation
  Plug 'roxma/nvim-yarp'      " Yet Another Remote Plugin Framework for Neovim
  Plug 'roxma/vim-hug-neovim-rpc'
endif
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
"Plug 'ryanoasis/vim-devicons'                                                                                     " Adds file type glyphs/icons to popular Vim plugins
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
Plug 'chrisbra/Colorizer', { 'on': 'ColorToggle' }                           " A Vim plugin to colorize all text in the form #rrggbb or #rgb.
Plug 'cometsong/CommentFrame.vim'                                            " generate fancy-looking comments/section dividers with centered titles and append them at the current cursor position.
Plug 'danilamihailov/beacon.nvim'                                            " see your cursor jump
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }               " VIM Table Mode for instant table creation.
Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' }                     " A Vim plugin for profiling Vim's startup time
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }            " A command-line fuzzy finder
Plug 'junegunn/fzf.vim'                                                      " use fzf on Vim
Plug 'junegunn/rainbow_parentheses.vim'                                      " Simpler Rainbow Parentheses
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " A Vim alignment plugin
Plug 'junegunn/vim-peekaboo'                                                 " show you the contents of the registers
Plug 'junegunn/vim-slash'                                                    " Enhancing in-buffer search experience
Plug 'kshenoy/vim-signature'                                                 " Plugin to toggle, display and navigate marks
Plug 'liuchengxu/vista.vim'                                                  " Viewer & Finder for LSP symbols and tags
Plug 'ludovicchabant/vim-gutentags'                                          " A Vim plugin that manages your tag files
Plug 'mechatroner/rainbow_csv', { 'for': 'csv' }                             " highlighting columns in csv/tsv files and executing SELECT and UPDATE queries in SQL-like language
Plug 'psliwka/vim-smoothie'                                                  " Smooth scrolling for Vim done right
Plug 'romainl/vim-qf'                                                        " Tame the quickfix window
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }                    " displaying the colours in the file
Plug 'scrooloose/nerdcommenter'                                              " Vim plugin for intensely orgasmic commenting
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
