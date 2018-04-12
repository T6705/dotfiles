" vim:foldmethod=marker:foldlevel=0

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --gocode-completer
  endif
endfunction

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
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
"Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }           " Distraction-free writing in Vim
"Plug 'junegunn/limelight.vim', { 'on': 'Limelight' } " All the world's indeed a stage and we are merely players
Plug 'Yggdroot/indentLine'                           " A vim plugin to display the indention levels with thin vertical lines
Plug 'vim-airline/vim-airline'                       " lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes'                " A collection of themes for vim-airline


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
" python
" ----------------------------------------------------------------------------------------
"Plug 'klen/python-mode', { 'for': 'python' }
"Plug 'ehamberg/vim-cute-python', { 'branch': 'moresymbols', 'for': 'python' }


"" ----------------------------------------------------------------------------------------
"" html
"" ----------------------------------------------------------------------------------------
"Plug 'mattn/emmet-vim', { 'for': ['html', 'php'] } " emmet support for vim - easily create markdup wth CSS-like syntax


" ----------------------------------------------------------------------------------------
" lint & autoformat
" ----------------------------------------------------------------------------------------
"Plug 'benekastah/neomake', { 'on': [] }       " Asynchronous linting and make framework for Neovim/Vim
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
"Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': function('DoRemote') })
Plug 'Shougo/neocomplete.vim', Cond(!has('nvim'))
Plug 'davidhalter/jedi-vim', { 'for': 'python', 'on': [] }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php', 'on': [] }


" ----------------------------------------------------------------------------------------
" Snippet
" ----------------------------------------------------------------------------------------
Plug 'Shougo/neosnippet'          " snippets support
Plug 'Shougo/neosnippet-snippets' " The standard snippets repository for neosnippet
Plug 'SirVer/ultisnips'           " The ultimate snippet solution for Vim.
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
"Plug 'AndrewRadev/splitjoin.vim', { 'on': ['SplitjoinJoin', 'SplitjoinSplit'] }          " simplifies the transition between multiline and single-line code
"Plug 'chrisbra/csv.vim', { 'for': 'csv' }
"Plug 'easymotion/vim-easymotion', { 'on': ['<Plug>(easymotion-prefix)',
"            \'<Plug>(easymotion-overwin-line)',
"            \'<Plug>(easymotion-overwin-f2)',
"            \'<Plug>(easymotion-overwin-w)',
"            \'<Plug>(easymotion-overwin-f)'] }                                           " Vim motions on speed!
"Plug 'godlygeek/tabular', { 'on': 'Tabularize' }                                         " text filtering and alignment
"Plug 'haya14busa/vim-operator-flashy'                                                    " Highlight yanked area
"Plug 'jiangmiao/auto-pairs'
"Plug 'johngrib/vim-game-code-break', { 'on': 'VimGameCodeBreak' }                        " Block-breaking game in vim 8.0
"Plug 'mklabs/split-term.vim', Cond(has('nvim'))
"Plug 'raghur/vim-ghost', Cond(has('nvim'), {'do': ':GhostInstall', 'on': 'GhostStart' }) " Nvim client for GhostText
"Plug 'ryanoasis/nerd-fonts', { 'do': './install.sh' }
"Plug 'sheerun/vim-polyglot'                                                              " A collection of language packs for Vim.
"Plug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }                                    " Run Async Shell Commands in Vim 8.0 / NeoVim and Output to Quickfix Window
"Plug 'thiagoalessio/rainbow_levels.vim', { 'on': 'RainbowLevelsToggle' }                 " code highlighting
"Plug 'yuttie/comfortable-motion.vim'
Plug 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }             " perform diffs on blocks of code
Plug 'Shougo/vimproc.vim', { 'do': 'make' }                       " Interactive command execution in Vim.
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
if v:version >= 703
    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' } " Vim plugin that displays tags in a window, ordered by scope
    Plug 'mhinz/vim-signify'                           " Show a diff using Vim its sign column.
endif
Plug 'mechatroner/rainbow_csv', { 'for': 'csv' }       " highlighting columns in csv/tsv files and executing SELECT and UPDATE queries in SQL-like language
Plug 'ryanoasis/vim-devicons'                          " Adds file type glyphs/icons to popular Vim plugins
Plug 'scrooloose/nerdcommenter'                        " Vim plugin for intensely orgasmic commenting
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }          " Visualize your undo tree.
Plug 'terryma/vim-multiple-cursors'                    " True Sublime Text style multiple selections for Vim
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }             " git status
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }                     " file tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } " Extra syntax and highlight for nerdtree files
Plug 'tpope/vim-fugitive'                             " fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-repeat'                               " enables repeating other supported plugins with the . command
Plug 'tpope/vim-surround', { 'on': [] }               " surround.vim: quoting/parenthesizing made simple
Plug 'wellle/targets.vim', { 'on': [] }               " Vim plugin that provides additional text objects
call plug#end()
endif

""" }}}
