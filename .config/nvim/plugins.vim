" vim:foldmethod=marker:foldlevel=0

fu! DoRemote(arg)
    UpdateRemotePlugins
endfu

fu! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --gocode-completer
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
            execute "q!"
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
            execute "q!"
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

" ----------------------------------------------------------------------------------------
" ColorScheme
" ----------------------------------------------------------------------------------------
Plug 'NLKNguyen/papercolor-theme'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'flazz/vim-colorschemes'
Plug 'google/vim-colorscheme-primary'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'roosta/vim-srcery'
Plug 'tomasr/molokai'


" ----------------------------------------------------------------------------------------
" Interface
" ----------------------------------------------------------------------------------------
Plug 'Yggdroot/indentLine'            " A vim plugin to display the indention levels with thin vertical lines
Plug 'vim-airline/vim-airline'        " lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes' " A collection of themes for vim-airline


"" ----------------------------------------------------------------------------------------
"" latex
"" ----------------------------------------------------------------------------------------
"Plug 'donRaphaco/neotex', Cond(has('nvim'), { 'do': function('DoRemote'), 'for': 'tex' })
"Plug 'lervag/vimtex', { 'for': 'tex' }


" ----------------------------------------------------------------------------------------
" markdown
" ----------------------------------------------------------------------------------------
"Plug 'plasticboy/vim-markdown', { 'for': 'markdown', 'on': [] }
Plug 'suan/vim-instant-markdown', { 'for': 'markdown', 'on': 'InstantMarkdownPreview' }


" ----------------------------------------------------------------------------------------
" golang
" ----------------------------------------------------------------------------------------
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }


"" ----------------------------------------------------------------------------------------
"" html
"" ----------------------------------------------------------------------------------------
"Plug 'mattn/emmet-vim', { 'for': ['html', 'php'] } " emmet support for vim - easily create markdup wth CSS-like syntax


" ----------------------------------------------------------------------------------------
" lint & autoformat
" ----------------------------------------------------------------------------------------
"Plug 'google/vim-codefmt', { 'on': ['FormatLines', 'FormatCode']}
"Plug 'google/vim-glaive'
"Plug 'google/vim-maktaba'
Plug 'metakirby5/codi.vim', { 'on': 'Codi!!' } " The interactive scratchpad for hackers.
Plug 'w0rp/ale' " Asynchronous Lint Engine


" ----------------------------------------------------------------------------------------
" Auto Completion
" ----------------------------------------------------------------------------------------
"Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'go', 'php', 'python', 'java'], 'do': function('BuildYCM') }
"Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': function('DoRemote') })
Plug 'Shougo/neocomplete.vim', Cond(!has('nvim'))
Plug 'davidhalter/jedi-vim', { 'for': 'python', 'on': [] }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php', 'on': [] }
Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make'}


" ----------------------------------------------------------------------------------------
" Snippet
" ----------------------------------------------------------------------------------------
Plug 'Shougo/neosnippet'          " snippets support
Plug 'Shougo/neosnippet-snippets' " The standard snippets repository for neosnippet
if v:version >= 704
    Plug 'SirVer/ultisnips'           " The ultimate snippet solution for Vim.
endif
Plug 'honza/vim-snippets'         " vim-snipmate default snippets


" ----------------------------------------------------------------------------------------
" textobj
" ----------------------------------------------------------------------------------------
Plug 'kana/vim-textobj-user'                    " Create your own textobj
Plug 'akiyan/vim-textobj-php', { 'for': 'php' } " aP/iP for a range between the PHP delimiters such as <?php and ?>
Plug 'deris/vim-textobj-ipmac'                  " aA/iA for ipv4, ipv6, MAC Address
Plug 'kana/vim-textobj-datetime'                " ada/ida and others for date and time such as 2013-03-13, 19:51:45, 2013-03-13T19:51:50
Plug 'kana/vim-textobj-indent'                  " ai/ii for a block of similarly indented lines / aI/iI for a block of lines with the same indentation
Plug 'mattn/vim-textobj-url'                    " au/iu for a URL


" ----------------------------------------------------------------------------------------
" utilities
" ----------------------------------------------------------------------------------------
"Plug 'ryanoasis/nerd-fonts', { 'do': './install.sh' }
Plug 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }             " perform diffs on blocks of code
Plug 'Shougo/vimproc.vim', { 'do': 'make' }                       " Interactive command execution in Vim.
Plug 'VincentCordobes/vim-translate', { 'on': 'Translate' }       "  A tiny translate-shell wrapper for Vim.
Plug 'andymass/matchup.vim'                                       " vim match-up: matchit replacement and more
Plug 'benmills/vimux'                                             " vim plugin to interact with tmux
Plug 'chrisbra/Colorizer', { 'on': 'ColorToggle' }                " A Vim plugin to colorize all text in the form #rrggbb or #rgb.
Plug 'chrisbra/vim-diff-enhanced'                                 " Better Diff options for Vim
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }    " VIM Table Mode for instant table creation.
Plug 'ervandew/supertab'                                          " Perform all your vim insert mode completions with Tab
Plug 'itchyny/vim-cursorword'                                     " Underlines the word under the cursor
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " A command-line fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " A Vim alignment plugin
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'                              " Enhancing in-buffer search experience
Plug 'kana/vim-operator-user'                          " Vim plugin: Define your own operator easily
Plug 'kshenoy/vim-signature'                           " Plugin to toggle, display and navigate marks
Plug 'ludovicchabant/vim-gutentags'                    " A Vim plugin that manages your tag files
if v:version >= 703
    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' } " Vim plugin that displays tags in a window, ordered by scope
    Plug 'mhinz/vim-signify'                           " Show a diff using Vim its sign column.
endif
Plug 'mechatroner/rainbow_csv', { 'for': 'csv' }       " highlighting columns in csv/tsv files and executing SELECT and UPDATE queries in SQL-like language
Plug 'ryanoasis/vim-devicons'                          " Adds file type glyphs/icons to popular Vim plugins
Plug 'scrooloose/nerdcommenter'                        " Vim plugin for intensely orgasmic commenting
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }          " Visualize your undo tree.
Plug 'terryma/vim-multiple-cursors'                    " True Sublime Text style multiple selections for Vim
Plug 'Xuyuanp/nerdtree-git-plugin'                     " git status
Plug 'scrooloose/nerdtree'                             " file tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'         " Extra syntax and highlight for nerdtree files
Plug 'skywind3000/gutentags_plus'                      " The right way to use gtags with gutentags
Plug 'tpope/vim-fugitive'                              " fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-repeat'                                " enables repeating other supported plugins with the . command
Plug 'tpope/vim-surround', { 'on': [] }                " surround.vim: quoting/parenthesizing made simple
Plug 'wellle/targets.vim', { 'on': [] }                " Vim plugin that provides additional text objects
call plug#end()
endif

""" }}}
