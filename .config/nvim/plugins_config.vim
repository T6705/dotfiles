" vim:foldmethod=marker:foldlevel=0

""" === Plugin Config === {{{

" -------------------------------------------------------------------------------
" vim-hexokinase
" -------------------------------------------------------------------------------
"let g:Hexokinase_ftAutoload    = ['']                            " Default is to not auto-enable for any filetype
"let g:Hexokinase_ftAutoload    = ['*']                           " Enable for all filetypes
"let g:Hexokinase_highlighters  = ['sign_column']                 " Default for Vim
"let g:Hexokinase_refreshEvents = ['BufWritePost']                " Default event to trigger and update
"let g:Hexokinase_virtualText   = '██████'                        " This can also be nice
let g:Hexokinase_ftAutoload    = ['css', 'xml']                  " Enable for css and xml
let g:Hexokinase_highlighters  = ['virtual']                     " Default for Neovim
let g:Hexokinase_refreshEvents = ['TextChanged', 'TextChangedI'] " This may cause some lag if there are a lot of colours in the file
let g:Hexokinase_signIcon      = '■'                             " Default sign column icon
let g:Hexokinase_virtualText   = '■'                             " Default virtual text

" -------------------------------------------------------------------------------
" vwm.vim
" -------------------------------------------------------------------------------
let s:py = {
    \    'name': 'py',
    \    'bot':
    \    {
    \      'init': ['call termopen("python3", {"detach": 0})'],
    \      'sz': 12,
    \    }
    \  }

let s:term = {
    \    'name': 'term',
    \    'bot':
    \    {
    \      'init': ['call termopen("zsh", {"detach": 0})'],
    \      'sz': 12,
    \    }
    \  }

let g:vwm#layouts = [s:term, s:py]

nnoremap <Leader>vo :VwmOpen<space>
nnoremap <Leader>vc :VwmClose<space>
command Opy :VwmOpen py
command Cpy :VwmClose py
command Oterm :VwmOpen term
command Cterm :VwmClose term

" -------------------------------------------------------------------------------
" Colorizer
" -------------------------------------------------------------------------------
let g:colorizer_syntax   = 1
let g:colorizer_auto_map = 1

" -------------------------------------------------------------------------------
" table-mode
" -------------------------------------------------------------------------------
let g:table_mode_corner = "|"
"let g:table_mode_corner_corner="+"
"let g:table_mode_header_fillchar="="

nnoremap <silent> <Leader>tm :TableModeToggle<CR>

" -------------------------------------------------------------------------------
" RainbowParentheses
" -------------------------------------------------------------------------------
let g:rainbow#max_level = 32
let g:rainbow#pairs     = [['(', ')'], ['[', ']'], ['{','}']]

" -------------------------------------------------------------------------------
" vimtex
" -------------------------------------------------------------------------------
"let g:vimtex_latexmk_options = '-pdf'
"let g:vimtex_latexmk_options = '-pdfps'
"let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
"let g:vimtex_view_general_options = '--unique @pdf\#src:@tex:@line:@col'
"let g:vimtex_view_general_options_latexmk = '--unique'
"let g:vimtex_view_general_viewer = 'okular'
"let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_latexmk_background  = 1
let g:vimtex_latexmk_continuous  = 1
let g:vimtex_latexmk_options     = '-pdfdvi'
let g:vimtex_view_general_viewer = 'zathura'

" -------------------------------------------------------------------------------
" Nerd Commenter
" -------------------------------------------------------------------------------
let g:NERDAltDelims_java         = 1      " Set a language to use its alternate delimiters by default
let g:NERDCommentEmptyLines      = 1      " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCompactSexyComs        = 1      " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign           = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDSpaceDelims            = 1      " Add spaces after comment delimiters by default
let g:NERDTrimTrailingWhitespace = 1      " Enable trimming of trailing whitespace when uncommenting

" -------------------------------------------------------------------------------
" Gundo.vim
" -------------------------------------------------------------------------------
let g:gundo_prefer_python3 = 1

nnoremap <silent> <Leader>ut :GundoToggle<CR>

" -------------------------------------------------------------------------------
" NERDTree
" -------------------------------------------------------------------------------
"let g:NERDTreeWinPos = "right"
let NERDTreeAutoDeleteBuffer       = 1
let NERDTreeDirArrows              = 1
let NERDTreeHijackNetrw            = 1
let NERDTreeIgnore                 = ['\.pyc$', '__pycache__']
let NERDTreeMinimalUI              = 1
let NERDTreeQuitOnOpen             = 1
let NERDTreeShowHidden             = 1
let g:NERDCustomDelimiters         = { 'racket': { 'left': ';', 'leftAlt': '#|', 'rightAlt': '|#' } }
let g:NERDTreeChDirMode            = 2
let g:NERDTreeIgnore               = ['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeMapOpenInTabSilent   = '<RightMouse>'
let g:NERDTreeShowBookmarks        = 1
let g:NERDTreeSortOrder            = ['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeWinSize              = 35
let g:nerdtree_tabs_focus_on_files = 1
let g:NERDTreeIndicatorMapCustom   = {
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

nnoremap <silent> <Leader>E :NERDTreeToggle<CR>
nnoremap <silent> <Leader>EF :NERDTreeFind<CR>

" -------------------------------------------------------------------------------
" netrw
" -------------------------------------------------------------------------------
"let g:netrw_altv         = 1 " open splits to the right
"let g:netrw_browse_split = 4 " open in prior window
"let g:netrw_liststyle    = 1 " Detail View
let g:netrw_banner      = 0                      " disable annoying banner
let g:netrw_bufsettings = 'relativenumber'
let g:netrw_hide        = 1                      " hide dotfiles by default
let g:netrw_list_hide   = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles
let g:netrw_list_hide   = netrw_gitignore#Hide()
let g:netrw_liststyle   = 3                      " tree view
let g:netrw_preview     = 1
let g:netrw_sizestyle   = "H"                    " Human-readable file sizes
let g:netrw_winsize     = 30

" -------------------------------------------------------------------------------
" Airline.vim
" -------------------------------------------------------------------------------
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"let g:airline_theme="luna"
"let g:airline_theme="onedark"
"let g:airline_theme="papercolor"
let g:airline#extensions#ale#enabled          = 1
let g:airline#extensions#branch#enabled       = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#gutentags#enabled    = 1
let g:airline#extensions#tabline#enabled      = 1
let g:airline#extensions#tagbar#enabled       = 1
let g:airline#extensions#virtualenv#enabled   = 1
let g:airline#extensions#whitespace#enabled   = 1
let g:airline#extensions#wordcount#enabled    = 1
let g:airline#extensions#ycm#enabled          = 1

let g:airline#extensions#tabline#buffer_nr_format = '%s '
let g:airline#extensions#tabline#buffer_nr_show   = 1
let g:airline#extensions#tabline#fnamecollapse    = 0
let g:airline#extensions#tabline#fnamemod         = ':t'
let g:airline#extensions#tabline#left_alt_sep     = '|'
let g:airline#extensions#tabline#left_sep         = ' '

let g:airline_left_sep            = ''
let g:airline_powerline_fonts     = 1
let g:airline_right_sep           = ''
let g:airline_skip_empty_sections = 1

let g:airline_theme = "wombat"


" -------------------------------------------------------------------------------
" vim-devicons
" -------------------------------------------------------------------------------
let g:webdevicons_enable                             = 1   " loading the plugin
let g:webdevicons_enable_airline_statusline          = 1   " adding to vim-airline's statusline
let g:webdevicons_enable_airline_tabline             = 1   " adding to vim-airline's tabline
let g:webdevicons_enable_nerdtree                    = 1   " adding the flags to NERDTree
let g:webdevicons_conceal_nerdtree_brackets          = 1   " whether or not to show the nerdtree brackets around flags
let g:DevIconsEnableFolderExtensionPatternMatching   = 1   " enable file extension pattern matching glyphs on folder/directory
let g:DevIconsEnableFolderPatternMatching            = 1   " enable pattern matching glyphs on folder/directory
let g:DevIconsEnableFoldersOpenClose                 = 1   " enable open and close folder/directory glyph flags
let g:WebDevIconsNerdTreeGitPluginForceVAlign        = 1   " Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = '' " set a byte character marker (BOM) utf-8 symbol when retrieving file encoding
let g:WebDevIconsUnicodeDecorateFileNodes            = 1   " turn on/off file node glyph decorations
let g:WebDevIconsUnicodeDecorateFolderNodes          = 1   " enable folder/directory glyph flag
let g:WebDevIconsUnicodeGlyphDoubleWidth             = 1   " use double-width(1) or single-width(0) glyphs
let g:webdevicons_conceal_nerdtree_brackets          = 0   " whether or not to show the nerdtree brackets around flags

"" -------------------------------------------------------------------------------
"" vimux
"" -------------------------------------------------------------------------------
"let g:VimuxOrientation = "h"
"let g:VimuxHeight      = "50"
"" Inspect runner pane
"nnoremap <silent> <Leader>vi :VimuxInspectRunner<CR>
"
"" Run last command executed by VimuxRunCommand
"nnoremap <silent> <Leader>vl :VimuxRunLastCommand<CR>
"
"" Prompt for a command to run
"nnoremap <silent> <Leader>vp :VimuxPromptCommand<CR>
"
"" Close vim tmux runner opened by VimuxRunCommand
"nnoremap <silent> <Leader>vq :VimuxCloseRunner<CR>
"
"" Interrupt any command running in the runner pane
"nnoremap <silent> <Leader>vx :VimuxInterruptRunner<CR>
"
"" Zoom the runner pane (use <bind-key> z to restore runner pane)
"nnoremap <silent> <Leader>vz :call VimuxZoomRunner()<CR>
"
"" compile and run
"noremap <silent> <Leader>tcr :TmuxCompileandRun<CR>
"
"" compile pdf
"nnoremap <silent> <Leader>pdf :w<CR> :VimtexCompile<CR>:NeoTexOn<CR>

" -------------------------------------------------------------------------------
" indentline
" -------------------------------------------------------------------------------
let g:indentLine_char      = '▸'
let g:indentLine_enabled   = 1 "enable by default
let g:indentLine_setColors = 1 "overwrite 'conceal' color

"" -------------------------------------------------------------------------------
"" easymotion
"" -------------------------------------------------------------------------------
"" Extend hjkl
"map ;h <Plug>(easymotion-linebackward)
"map ;j <Plug>(easymotion-j)
"map ;k <Plug>(easymotion-k)
"map ;l <Plug>(easymotion-lineforward)
"
"" Extened word motion
"map  ;w  <Plug>(easymotion-bd-wl)
"map  ;e  <Plug>(easymotion-bd-el)
"omap ;b  <Plug>(easymotion-bl)
""omap ;ge <Plug>(easymotion-gel)
"map ;ge <Plug>(easymotion-gel)
"
"" Move to line
"map <Leader>L <Plug>(easymotion-bd-jk)
"nmap <Leader>L <Plug>(easymotion-overwin-line)
"
"" Move to word
"map  <Leader>W <Plug>(easymotion-bd-w)
"nmap <Leader>W <Plug>(easymotion-overwin-w)

" -------------------------------------------------------------------------------
" neosnippet.vim
" -------------------------------------------------------------------------------
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.config/nvim/plugged/vim-snippets/snippets'

" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" -------------------------------------------------------------------------------
" Ultsnips
" -------------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger       = "<TAB>"
let g:UltiSnipsJumpBackwardTrigger = "<C-p>"
let g:UltiSnipsJumpForwardTrigger  = "<C-n>"
let g:UltiSnipsEditSplit           = "vertical" " If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsSnippetsDir         = "~/.vim/UltiSnips"

" -------------------------------------------------------------------------------
" SuperTab
" -------------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<C-n>"

" -------------------------------------------------------------------------------
" YouCompleteMe
" -------------------------------------------------------------------------------
if empty(glob('~/.config/nvim/.ycm_extra_conf.py'))
  silent !curl -fLo ~/.config/nvim/.ycm_extra_conf.py --create-dirs
    \ https://raw.githubusercontent.com/Valloric/ycmd/master/examples/.ycm_extra_conf.py
endif
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files       = 1 " Let YCM read tags from Ctags file
let g:ycm_complete_in_comments                      = 1 " Completion in comments
let g:ycm_complete_in_strings                       = 1 " Completion in string
let g:ycm_confirm_extra_conf                        = 0
let g:ycm_echo_current_diagnostic                   = 1
let g:ycm_enable_diagnostic_highlighting            = 1
let g:ycm_enable_diagnostic_signs                   = 1
let g:ycm_error_symbol                              = '>>'
let g:ycm_global_ycm_extra_conf                     = '~/.config/nvim/.ycm_extra_conf.py'
let g:ycm_key_list_previous_completion              = ['<C-p>', '<Up>']
let g:ycm_key_list_select_completion                = ['<C-n>', '<Down>']
let g:ycm_min_num_of_chars_for_completion           = 2
let g:ycm_python_binary_path                        = '/usr/bin/python3'
let g:ycm_seed_identifiers_with_syntax              = 1 " Completion for programming language's keyword
let g:ycm_show_diagnostics_ui                       = 1
let g:ycm_use_ultisnips_completer                   = 1 " Default 1, just ensure
let g:ycm_warning_symbol                            = '>>'
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }
let g:ycm_filetype_blacklist = {
      \ 'infolog':  1,
      \ 'mail':     1,
      \ 'markdown': 1,
      \ 'notes':    1,
      \ 'pandoc':   1,
      \ 'qf':       1,
      \ 'tagbar':   1,
      \ 'text':     1,
      \ 'unite':    1,
      \ 'vimwiki':  1
      \}

" -------------------------------------------------------------------------------
" instant_markdown
" -------------------------------------------------------------------------------
let g:instant_markdown_allow_external_content = 1 " allow content like images, stylesheets...
let g:instant_markdown_allow_unsafe_content   = 0 " block scripts
let g:instant_markdown_autostart              = 0 " start markdown preview with :InstantMarkdownPreview
let g:instant_markdown_open_to_the_world      = 0 " listens on localhost
let g:instant_markdown_slow                   = 0 " realtime preview

" -------------------------------------------------------------------------------
" tagbar
" -------------------------------------------------------------------------------
if v:version >= 703
    let g:tagbar_sort      = 0
    let g:tagbar_autofocus = 1
    nnoremap <silent> <Leader>tb :TagbarToggle<CR>
endif

"" -------------------------------------------------------------------------------
"" vim-gutentags
"" -------------------------------------------------------------------------------
let gutentags_dir = expand('~/.cache/tags')
if !isdirectory(gutentags_dir)
    call mkdir(gutentags_dir, "", 0700)
endif

let g:gutentags_modules               = ['ctags', 'gtags_cscope'] " enable gtags module
let g:gutentags_project_root          = ['.root']                 " config project root markers.
let g:gutentags_cache_dir             = expand('~/.cache/tags')   " generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_auto_add_gtags_cscope = 0                         " forbid gutentags adding gtags databases

" -------------------------------------------------------------------------------
" emmet-vim
" -------------------------------------------------------------------------------
"let g:user_emmet_leader_key='<C-H>'
"let g:user_emmet_mode='inv'  "enable all functions, which is equal to
"let g:user_emmet_mode='n'    "only enable normal mode functions.
let g:user_emmet_install_global = 0
let g:user_emmet_mode           = 'a'    "enable all function in all mode.

" -------------------------------------------------------------------------------
" Codi.vim
" -------------------------------------------------------------------------------
let g:codi#interpreters = {
                   \ 'python': {
                       \ 'bin': 'python3',
                       \ 'prompt': '^\(>>>\|\.\.\.\) ',
                       \ },
                       \ }

inoremap <silent> <F5> <Esc>:Codi!!<CR>
nnoremap <silent> <F5> :Codi!!<CR>

if has('python3')
    " -------------------------------------------------------------------------------
    " Shougo deoplete/neocomplete
    " -------------------------------------------------------------------------------
    let g:deoplete#enable_at_startup = 1
    "call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer', 'member']})
    call deoplete#custom#var('around', {
    \   'range_above': 15,
    \   'range_below': 15,
    \   'mark_above': '[↑]',
    \   'mark_below': '[↓]',
    \   'mark_changes': '[*]',
    \})

    " ---------------------------------------
    " https://github.com/zchee/deoplete-clang
    " ---------------------------------------
    let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
    let g:deoplete#sources#clang#clang_header  = '/usr/lib/clang'

    " ------------------------------------
    " https://github.com/zchee/deoplete-go
    " ------------------------------------
    let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
    let g:deoplete#sources#go#package_dot   = 1
    let g:deoplete#sources#go#pointer       = 1
    let g:deoplete#sources#go#sort_class    = ['package', 'func', 'type', 'var', 'const']

    " --------------------------------------
    " https://github.com/zchee/deoplete-jedi
    " --------------------------------------
    let g:deoplete#sources#jedi#show_docstring = 1

    " -------------------------------------------
    " https://github.com/carlitux/deoplete-ternjs
    " -------------------------------------------
    " Set bin if you have many instalations
    let g:deoplete#sources#ternjs#tern_bin = '/usr/bin/tern'
    let g:deoplete#sources#ternjs#timeout = 1

    " Whether to include the types of the completions in the result data. Default: 0
    let g:deoplete#sources#ternjs#types = 1

    " Whether to include the distance (in scopes for variables, in prototypes for
    " properties) between the completions and the origin position in the result
    " data. Default: 0
    let g:deoplete#sources#ternjs#depths = 1

    " Whether to include documentation strings (if found) in the result data.
    " Default: 0
    let g:deoplete#sources#ternjs#docs = 1

    " When on, only completions that match the current word at the given point will
    " be returned. Turn this off to get all results, so that you can filter on the
    " client side. Default: 1
    let g:deoplete#sources#ternjs#filter = 0

    " Whether to use a case-insensitive compare between the current word and
    " potential completions. Default 0
    let g:deoplete#sources#ternjs#case_insensitive = 1

    " When completing a property and no completions are found, Tern will use some
    " heuristics to try and return some properties anyway. Set this to 0 to
    " turn that off. Default: 1
    let g:deoplete#sources#ternjs#guess = 0

    " Determines whether the result set will be sorted. Default: 1
    let g:deoplete#sources#ternjs#sort = 0

    " When disabled, only the text before the given position is considered part of
    " the word. When enabled (the default), the whole variable name that the cursor
    " is on will be included. Default: 1
    let g:deoplete#sources#ternjs#expand_word_forward = 0

    " Whether to ignore the properties of Object.prototype unless they have been
    " spelled out by at least two characters. Default: 1
    let g:deoplete#sources#ternjs#omit_object_prototype = 0

    " Whether to include JavaScript keywords when completing something that is not
    " a property. Default: 0
    let g:deoplete#sources#ternjs#include_keywords = 1

    " If completions should be returned when inside a literal. Default: 1
    let g:deoplete#sources#ternjs#in_literal = 0


    "Add extra filetypes
    let g:deoplete#sources#ternjs#filetypes = [
                    \ 'jsx',
                    \ 'javascript.jsx',
                    \ 'vue',
                    \ '...'
                    \ ]

    " Use tern_for_vim.
    let g:tern#command = ["tern"]
    let g:tern#arguments = ["--persistent"]

    " -------------------------------------------------
    " https://github.com/autozimu/LanguageClient-neovim
    " -------------------------------------------------
    let g:LanguageClient_serverCommands = {}
    let g:LanguageClient_serverCommands['go'] = ['$HOME/go/bin/gopls']
endif

" -------------------------------------------------------------------------------
" vimade
" -------------------------------------------------------------------------------
let g:vimade = {
  \ "normalid": '',
  \ "normalncid": '',
  \ "basefg": '',
  \ "basebg": '',
  \ "fadelevel": 0.4,
  \ "colbufsize": 15,
  \ "rowbufsize": 15,
  \ "checkinterval": 100,
  \ "usecursorhold": 0,
  \ "detecttermcolors": 1,
  \ "enablesigns": 1,
  \ "signsretentionperiod": 4000,
  \}

" -------------------------------------------------------------------------------
" Black
" -------------------------------------------------------------------------------
let g:black_fast                      = 0   " (defaults to 0)
let g:black_linelength                = 88  " (defaults to 88)
let g:black_skip_string_normalization = 0   " (defaults to 0)
"let g:black_virtualenv               = ~/.vim/black " (defaults to ~/.vim/black)

" -------------------------------------------------------------------------------
" Asynchronous Lint Engine
" -------------------------------------------------------------------------------
let g:ale_fixers                               = {}
let g:ale_fixers['c']                          = ['clang-format', 'remove_trailing_lines', 'trim_whitespace', 'uncrustify']
let g:ale_fixers['cpp']                        = ['clang-format', 'remove_trailing_lines', 'trim_whitespace', 'uncrustify']
let g:ale_fixers['css']                        = ['prettier']
let g:ale_fixers['dart']                       = ['dartfmt', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers['java']                       = ['google_java_format', 'uncrustify', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers['javascript']                 = ['prettier']
let g:ale_fixers['json']                       = ['prettier']
let g:ale_fixers['perl']                       = ['perltidy', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers['php']                        = ['php_cs_fixer', 'phpcbf', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers['python']                     = ['add_blank_lines_for_python_control_statements', 'autopep8', 'black', 'isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers['ruby']                       = ['rubocop', 'rufo', 'standardrb', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers['typescript']                 = ['prettier', 'tslint']

let g:ale_linters                              = {}
let g:ale_linters['javascript']                = ['eslint', 'tsserver']
let g:ale_linters['php']                       = ['phpcs', 'php', 'phpmd']
let g:ale_linters['python']                    = ['flake8', 'mypy', 'pep8', 'vulture']

let g:ale_fix_on_save                          = 0
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_python_flake8_executable             = 'python3'
let g:ale_python_flake8_options                = '-m flake8 --ignore=E221,E265,E266,E501'
let g:ale_python_pep8_options                  = '--max-line-length=100 --ignore=E221,E265,E266,E501'
let g:ale_set_loclist                          = 1
let g:ale_set_quickfix                         = 0

nnoremap <silent> <Leader>alfx :ALEFix<CR>

" -------------------------------------------------------------------------------
" vim-go
" -------------------------------------------------------------------------------
if executable("go")
    let g:go_fmt_options = {
                \ 'goimports': '-local do/',
                \ }
    "
    let g:go_debug_windows = {
                \ 'vars':  'leftabove 35vnew',
                \ 'stack': 'botright 10new',
                \ }

    let g:go_addtags_transform          = "snakecase"  " Set whether the JSON tags should be snakecase or camelcase.
    let g:go_auto_sameids               = 1
    let g:go_auto_type_info             = 1
    let g:go_autodetect_gopath          = 1
    let g:go_def_mode                   = "guru"
    let g:go_echo_command_info          = 1            " Show the progress when running :GoCoverage
    let g:go_fmt_command                = "goimports"  " Run goimports when running gofmt
    let g:go_fmt_fail_silently          = 0
    let g:go_fold_enable                = []
    let g:go_gocode_autobuild           = 1
    let g:go_gocode_unimported_packages = 1
    let g:go_info_mode                  = "guru"
    let g:go_list_type                  = "quickfix"   " Fix for location list when vim-go is used together with Syntastic
    let g:go_modifytags_transform       = 'snakecase'
    let g:go_sameid_search_enabled      = 1
    let g:go_snippet_engine             = "automatic"  " Automatically detect a snippet engine.
    let g:go_test_show_name             = 1            " Add the failing test name to the output of :GoTest

    " Enable syntax highlighting
    let g:go_highlight_array_whitespace_error    = 1
    let g:go_highlight_build_constraints         = 1
    let g:go_highlight_extra_types               = 1
    let g:go_highlight_fields                    = 1
    let g:go_highlight_format_strings            = 1
    let g:go_highlight_function_calls            = 1
    let g:go_highlight_functions                 = 1
    let g:go_highlight_generate_tags             = 1
    let g:go_highlight_methods                   = 1
    let g:go_highlight_operators                 = 1
    let g:go_highlight_space_tab_error           = 1
    let g:go_highlight_structs                   = 1
    let g:go_highlight_trailing_whitespace_error = 1
    let g:go_highlight_types                     = 1

    augroup go
        au!
        au FileType go imap <silent> <C-g> <Esc>:<C-u>GoDecls<CR>
        au FileType go nmap <silent> <C-g> :GoDecls<CR>
        au FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)
        au FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)
        au FileType go nmap <silent> <Leader>db <Plug>(go-doc-browser)
        au FileType go nmap <silent> <Leader>i <Plug>(go-info)
        au FileType go nmap <silent> <Leader>ml <Plug>(go-metalinter)
        au FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
        au FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
        au FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)
        au FileType go nmap <silent> <Leader>b <Plug>(go-build)
        au FileType go nmap <silent> <Leader>in  <Plug>(go-install)
        au FileType go nmap <silent> <Leader>r  <Plug>(go-run)
        au FileType go nmap <silent> <Leader>rb :<C-u>call <SID>build_go_files()<CR>
        au FileType go nmap <silent> <Leader>t  <Plug>(go-test)
        au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
        au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
        au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
        au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
        au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')

        " run :GoBuild or :GoTestCompile based on the go file
        fu! s:build_go_files()
            let l:file = expand('%')
            if l:file =~# '^\f\+_test\.go$'
                call go#test#Test(0, 1)
            elseif l:file =~# '^\f\+\.go$'
                call go#cmd#Build(0)
            endif
        endfu

    augroup END
endif

" -------------------------------------------------------------------------------
" dart-vim-plugin
" -------------------------------------------------------------------------------
if executable("dart")
    let dart_html_in_string=v:true
    let dart_corelib_highlight=v:true
    let dart_style_guide = 2
    let dart_format_on_save = 1
endif

" -------------------------------------------------------------------------------
" jedi-vim
" -------------------------------------------------------------------------------
let g:jedi#auto_initialization      = 1
let g:jedi#auto_vim_configuration   = 1
let g:jedi#completions_command      = "<C-Space>"
let g:jedi#completions_enabled      = 1
let g:jedi#documentation_command    = "K"
let g:jedi#goto_assignments_command = "<Leader>g"
let g:jedi#goto_command             = "<Leader>d"
let g:jedi#goto_definitions_command = "<TAB>"
let g:jedi#popup_on_dot             = 1
let g:jedi#popup_select_first       = 1
let g:jedi#rename_command           = "<Leader>r"
let g:jedi#show_call_signatures     = "1"
let g:jedi#usages_command           = "<Leader>n"
let g:jedi#use_splits_not_buffers   = "right"
let g:jedi#use_tabs_not_buffers     = 0

" -------------------------------------------------------------------------------
" fzf
" -------------------------------------------------------------------------------
if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

let g:fzf_buffers_jump        = 1                                                                        " [Buffers] Jump to the existing window if possible
let g:fzf_commands_expect     = 'alt-enter,ctrl-x'                                                       " [Commands] --expect expression for directly executing the command
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"' " [[B]Commits] Customize the options used by 'git log':
let g:fzf_tags_command        = 'ctags -R'                                                               " [Tags] Command to generate tags file

" File preview using Highlight (http://www.andre-simon.de/doku/highlight/en/highlight.php)
let g:fzf_files_options =
\ '--preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {} || highlight -O ansi -l {} || coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Command for git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

    ":Rg  - Start fzf with hidden preview window that can be enabled with "?" key
    nnoremap <silent> <Leader>rg :Rg<CR>
    ":Rg! - Start fzf in fullscreen and display the preview window above
    nnoremap <silent> <Leader>RG :Rg!<CR>
elseif executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

    au VimEnter * command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

    ":Ag  - Start fzf with hidden preview window that can be enabled with "?" key
    nnoremap <silent> <Leader>ag :Ag<CR>
    ":Ag! - Start fzf in fullscreen and display the preview window above
    nnoremap <silent> <Leader>AG :Ag!<CR>
endif


if isdirectory(".git")
    " if in a git project, use :GFiles
    nnoremap <silent> <Leader>e :GFiles<CR>
else
    " otherwise, use :FZF
    nnoremap <silent> <Leader>e :FZF<CR>
endif

nmap <Leader><TAB> <plug>(fzf-maps-n)
xmap <Leader><TAB> <plug>(fzf-maps-x)
omap <Leader><TAB> <plug>(fzf-maps-o)

" Windows
nnoremap <silent> <Leader>ws :Windows<CR>

" Marks
nnoremap <silent> <Leader>ms :Marks<CR>

" Tags
nnoremap <silent> <Leader>ts :Tags<CR>

" Insert mode completion
imap ,a <plug>(fzf-complete-file-ag)
imap ,p <plug>(fzf-complete-path)
imap ,fl <plug>(fzf-complete-line)
imap ,fw <plug>(fzf-complete-word)

" Buffers
nnoremap <silent> <Leader>bs :Buffers<CR>
nnoremap <silent> <Leader>bls :Lines<CR>

" -------------------------------------------------------------------------------
" vim-easy-align
" -------------------------------------------------------------------------------
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '\': { 'pattern': '\\' },
\ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
\ ']': {
\     'pattern':       '\]\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       ')\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ 'f': {
\     'pattern': ' \(\S\+(\)\@=',
\     'left_margin': 0,
\     'right_margin': 0
\   },
\ 'd': {
\     'pattern': ' \ze\S\+\s*[;=]',
\     'left_margin': 0,
\     'right_margin': 0
\   }
\ }

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)
nmap gaa ga_

" xmap <Leader><Enter>   <Plug>(LiveEasyAlign)
" nmap <Leader><Leader>a <Plug>(LiveEasyAlign)

" inoremap <silent> => =><Esc>mzvip:EasyAlign/=>/<CR>`z$a<Space>

" -------------------------------------------------------------------------------
" vim-slash
" -------------------------------------------------------------------------------
if has('timers') && !has('nvim')
  noremap <expr> <plug>(slash-after) slash#blink(2, 50)
endif

" -------------------------------------------------------------------------------
" peekaboo
" -------------------------------------------------------------------------------
let g:peekaboo_compact = 0                         " Compact display; do not display the names of the register groups
let g:peekaboo_delay   = 0                         " Delay opening of peekaboo window (in ms. default: 0)
let g:peekaboo_window  = 'vertical botright 30new' " Default peekaboo window

""" }}}
