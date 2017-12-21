" vim:foldmethod=marker:foldlevel=0

""" === Plugin Config === {{{

" ----------------------------------------------------------------------------------------
" Colorizer
" ----------------------------------------------------------------------------------------
let g:colorizer_syntax   = 1
let g:colorizer_auto_map = 1


" ----------------------------------------------------------------------------------------
" table-mode
" ----------------------------------------------------------------------------------------
let g:table_mode_corner = "|"
"let g:table_mode_corner_corner="+"
"let g:table_mode_header_fillchar="="


" ----------------------------------------------------------------------------------------
" RainbowParentheses
" ----------------------------------------------------------------------------------------
let g:rainbow#max_level = 32
let g:rainbow#pairs     = [['(', ')'], ['[', ']'], ['{','}']]


" ----------------------------------------------------------------------------------------
" rainbow_levels.vim
" ----------------------------------------------------------------------------------------
let g:rainbow_levels = [
    \{'ctermfg': 2, 'guifg': '#a6e22e'},
    \{'ctermfg': 6, 'guifg': '#66d9ef'},
    \{'ctermfg': 4, 'guifg': '#ae81ff'},
    \{'ctermfg': 5, 'guifg': '#f92672'},
    \{'ctermfg': 1, 'guifg': '#fd971f'},
    \{'ctermfg': 3, 'guifg': '#f4bf75'},
    \{'ctermfg': 7, 'guifg': '#f8f8f2'},
    \{'ctermfg': 0, 'guifg': '#75715e'}]


" ----------------------------------------------------------------------------------------
" vimtex
" ----------------------------------------------------------------------------------------
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


" ----------------------------------------------------------------------------------------
" Nerd Commenter
" ----------------------------------------------------------------------------------------
let g:NERDAltDelims_java         = 1      " Set a language to use its alternate delimiters by default
let g:NERDCommentEmptyLines      = 1      " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCompactSexyComs        = 1      " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign           = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDSpaceDelims            = 1      " Add spaces after comment delimiters by default
let g:NERDTrimTrailingWhitespace = 1      " Enable trimming of trailing whitespace when uncommenting


" ----------------------------------------------------------------------------------------
" Gundo.vim
" ----------------------------------------------------------------------------------------
let g:gundo_prefer_python3 = 1


" ----------------------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------------------
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


" ----------------------------------------------------------------------------------------
" netrw
" ----------------------------------------------------------------------------------------
"let g:netrw_altv         = 1 " open splits to the right
"let g:netrw_browse_split = 4 " open in prior window
let g:netrw_banner      = 0 " disable annoying banner
let g:netrw_bufsettings = 'relativenumber'
let g:netrw_hide        = 1 " hide dotfiles by default
let g:netrw_list_hide   = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles
let g:netrw_list_hide   = netrw_gitignore#Hide()
"let g:netrw_liststyle   = 1 " Detail View
let g:netrw_liststyle   = 3 " tree view
let g:netrw_preview     = 1
let g:netrw_sizestyle   = "H" " Human-readable file sizes
let g:netrw_winsize     = 30


" ----------------------------------------------------------------------------------------
" Airline.vim
" ----------------------------------------------------------------------------------------
"let g:airline_theme="luna"
"let g:airline_theme="papercolor"
"let g:airline_theme="onedark"
let g:airline#extensions#tabline#buffer_nr_format = '%s '
let g:airline#extensions#tabline#buffer_nr_show   = 1
let g:airline#extensions#tabline#enabled          = 1
let g:airline#extensions#tabline#fnamecollapse    = 0
let g:airline#extensions#tabline#fnamemod         = ':t'
let g:airline#extensions#tabline#left_alt_sep     = '|'
let g:airline#extensions#tabline#left_sep         = ' '
let g:airline#extensions#tagbar#enabled           = 0
let g:airline_left_sep                            = ''
let g:airline_powerline_fonts                     = 1
let g:airline_right_sep                           = ''
let g:airline_theme                               = "wombat"


" ----------------------------------------------------------------------------------------
" vim-devicons
" ----------------------------------------------------------------------------------------
let g:webdevicons_enable = 1 " loading the plugin
let g:webdevicons_enable_airline_statusline = 1 " adding to vim-airline's statusline
let g:webdevicons_enable_airline_tabline = 1 " adding to vim-airline's tabline
let g:webdevicons_enable_nerdtree = 1 " adding the flags to NERDTree
let g:DevIconsEnableFolderExtensionPatternMatching = 1 " enable file extension pattern matching glyphs on folder/directory
let g:DevIconsEnableFolderPatternMatching = 1 " enable pattern matching glyphs on folder/directory
let g:DevIconsEnableFoldersOpenClose = 1 " enable open and close folder/directory glyph flags
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1 " Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = '' " set a byte character marker (BOM) utf-8 symbol when retrieving file encoding
let g:WebDevIconsUnicodeDecorateFileNodes = 1 " turn on/off file node glyph decorations
let g:WebDevIconsUnicodeDecorateFolderNodes = 1 " enable folder/directory glyph flag
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1 " use double-width(1) or single-width(0) glyphs
let g:webdevicons_conceal_nerdtree_brackets = 0 " whether or not to show the nerdtree brackets around flags


" ----------------------------------------------------------------------------------------
" vimux
" ----------------------------------------------------------------------------------------
let g:VimuxOrientation = "h"
let g:VimuxHeight      = "50"


" ----------------------------------------------------------------------------------------
" indentline
" ----------------------------------------------------------------------------------------
let g:indentLine_char      = '▸'
let g:indentLine_enabled   = 1 "enable by default
let g:indentLine_setColors = 1 "do not overwrite 'conceal' color


" ----------------------------------------------------------------------------------------
" neosnippet.vim
" ----------------------------------------------------------------------------------------
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.config/nvim/plugged/vim-snippets/snippets'


" ----------------------------------------------------------------------------------------
" Ultsnips
" ----------------------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger       = "<TAB>"
let g:UltiSnipsJumpBackwardTrigger = "<C-p>"
let g:UltiSnipsJumpForwardTrigger  = "<C-n>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit = "vertical"


" ----------------------------------------------------------------------------------------
" SuperTab
" ----------------------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<C-n>"


" ----------------------------------------------------------------------------------------
" comfortable-motion
" ----------------------------------------------------------------------------------------
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_friction                = 80.0
let g:comfortable_motion_air_drag                = 2.0


" ----------------------------------------------------------------------------------------
" YouCompleteMe
" ----------------------------------------------------------------------------------------
if empty(glob('~/.config/nvim/.ycm_extra_conf.py'))
  silent !curl -fLo ~/.config/nvim/.ycm_extra_conf.py --create-dirs
    \ https://raw.githubusercontent.com/Valloric/ycmd/master/cpp/ycm/.ycm_extra_conf.py
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


" ----------------------------------------------------------------------------------------
" instant_markdown
" ----------------------------------------------------------------------------------------
let g:instant_markdown_allow_external_content = 1 " allow content like images, stylesheets...
let g:instant_markdown_allow_unsafe_content   = 0 " block scripts
let g:instant_markdown_autostart              = 0 " start markdown preview with :InstantMarkdownPreview
let g:instant_markdown_open_to_the_world      = 0 " listens on localhost
let g:instant_markdown_slow                   = 0 " realtime preview


" ----------------------------------------------------------------------------------------
" tagbar
" ----------------------------------------------------------------------------------------
let g:tagbar_sort = 0


" ----------------------------------------------------------------------------------------
" emmet-vim
" ----------------------------------------------------------------------------------------
"let g:user_emmet_leader_key='<C-H>'
"let g:user_emmet_mode='inv'  "enable all functions, which is equal to
"let g:user_emmet_mode='n'    "only enable normal mode functions.
let g:user_emmet_install_global = 0
let g:user_emmet_mode           = 'a'    "enable all function in all mode.

" ----------------------------------------------------------------------------------------
" Codi.vim
" ----------------------------------------------------------------------------------------
let g:codi#interpreters = {
                   \ 'python': {
                       \ 'bin': 'python3',
                       \ 'prompt': '^\(>>>\|\.\.\.\) ',
                       \ },
                       \ }


" ----------------------------------------------------------------------------------------
" Shougo deoplete/neocomplete
" ----------------------------------------------------------------------------------------
if has('nvim')
    " deoplete
    let g:deoplete#enable_at_startup           = 1
    let g:deoplete#sources#jedi#enable_cache   = 1
    let g:deoplete#sources#jedi#show_docstring = 0
else
    " neocomplete
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    let g:acp_enableAtStartup                           = 0 " Disable AutoComplPop.
    let g:neocomplete#enable_at_startup                 = 1 " Use neocomplete.
    let g:neocomplete#enable_smart_case                 = 1 " Use smartcase.
    let g:neocomplete#sources#syntax#min_keyword_length = 3 " Set minimum syntax keyword length.
    let g:neocomplete#lock_buffer_name_pattern          = '\*ku\*'

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
endif


" ----------------------------------------------------------------------------------------
" Asynchronous Lint Engine
" ----------------------------------------------------------------------------------------
let g:ale_linters = {
\   'php': ['phpcs', 'php', 'phpmd'],
\   'python': ['flake8', 'pep8', 'vulture'],
\}
let g:ale_fixers = {'python': ['remove_trailing_lines', 'trim_whitespace', 'autopep8']}
let g:ale_python_flake8_args   = '--ignore=E221,E265,E266,E501'
let g:ale_python_pep8_args     = '--max-line-length=100 --ignore=E221,E265,E266,E501'


"" ----------------------------------------------------------------------------------------
"" neomake
"" ----------------------------------------------------------------------------------------
"let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
"let g:neomake_warning_sign = {
"    \   'text': '⚠',
"    \   'texthl': 'NeomakeWarningSign',
"    \ }
"let g:neomake_message_sign = {
"     \   'text': '➤',
"     \   'texthl': 'NeomakeMessageSign',
"     \ }
"let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

"" Python2/3
"let g:neomake_python_enabled_makers = ['flake8', 'pep8', 'vulture']
"let g:neomake_python_flake8_maker   = { 'args': ['--ignore E221 E265 E266'], }
"let g:neomake_python_pep8_maker     = { 'args': ['--max-line-length=100', '--ignore=E221,E265,E266'], }

"" php
"let g:neomake_php_enabled_makers = ['phpcs', 'php', 'phpmd']


"" ----------------------------------------------------------------------------------------
"" Pymode
"" ----------------------------------------------------------------------------------------
"" let g:pymode_options_max_line_length = 79 " Setup max line length
"let g:pymode                  = 1            " enable Pymode
"let g:pymode_breakpoint       = 1
"let g:pymode_breakpoint_bind  = '<Leader>pb' " add breakpoint with ' pb'
"let g:pymode_doc              = 1            " read doc :PymodeDoc arg
"let g:pymode_doc_bind         = '<Leader>pd' " press ' pd' to show doc for current word
"let g:pymode_folding          = 0            " disable folding
"let g:pymode_indent           = 1            " pep8 indent style
"let g:pymode_options          = 0            " disable default python options
"let g:pymode_python           = 'python3'
"let g:pymode_rope             = 0            " Disable rope
"let g:pymode_run              = 1
"let g:pymode_run_bind         = '<Leader>pr' " run python code with ,pr
"let g:pymode_trim_whitespaces = 1            " Trim unused white spaces on save
"let g:pymode_virtualenv       = 1            " Enable automatic virtualenv detection

"" rope
"let g:pymode_rope                     = 0
"let g:pymode_rope_auto_project        = 0
"let g:pymode_rope_autoimport_generate = 0
"let g:pymode_rope_complete_on_dot     = 0
"let g:pymode_rope_completion          = 0
"let g:pymode_rope_enable_autoimport   = 0
"let g:pymode_rope_guess_project       = 0

"""" linting code with neomake
"let g:pymode_lint_checkers   = ['pyflakes', 'pep8', 'mccabe']
"let g:pymode_lint_on_fly     = 0
"let g:pymode_lint_on_write   = 0
"let g:pymode_lint_unmodified = 0

""" syntax highlight
""let g:pymode_syntax=1
""let g:pymode_syntax_all=1
""let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
""let g:pymode_syntax_builtin_types=g:pymode_syntax_all
""let g:pymode_syntax_docstrings=g:pymode_syntax_all
""let g:pymode_syntax_doctests=g:pymode_syntax_all
""let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
""let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
""let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
""let g:pymode_syntax_highlight_self=g:pymode_syntax_all
""let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
""let g:pymode_syntax_indent_errors=g:pymode_syntax_all
""let g:pymode_syntax_print_as_function=g:pymode_syntax_all
""let g:pymode_syntax_slow_sync=1
""let g:pymode_syntax_space_errors=g:pymode_syntax_all
""let g:pymode_syntax_string_format=g:pymode_syntax_all
""let g:pymode_syntax_string_formatting=g:pymode_syntax_all
""let g:pymode_syntax_string_templates=g:pymode_syntax_all


" ----------------------------------------------------------------------------------------
" jedi-vim
" ----------------------------------------------------------------------------------------
let g:jedi#auto_initialization    = 1
let g:jedi#auto_vim_configuration = 1
let g:jedi#completions_enabled    = 1
let g:jedi#popup_on_dot           = 1
let g:jedi#popup_select_first     = 1
let g:jedi#show_call_signatures   = "1"
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#use_tabs_not_buffers   = 0

let g:jedi#completions_command      = "<C-Space>"
let g:jedi#documentation_command    = "K"
let g:jedi#goto_assignments_command = "<Leader>g"
let g:jedi#goto_command             = "<Leader>d"
let g:jedi#goto_definitions_command = "<TAB>"
let g:jedi#rename_command           = "<Leader>r"
let g:jedi#usages_command           = "<Leader>n"


" ----------------------------------------------------------------------------------------
" vim-easymotion
" ----------------------------------------------------------------------------------------
let g:EasyMotion_smartcase = 1


" ----------------------------------------------------------------------------------------
" vim-easy-align
" ----------------------------------------------------------------------------------------
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


" ----------------------------------------------------------------------------------------
" vim-slash
" ----------------------------------------------------------------------------------------
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
  "  cnoremap <expr> <CR> (stridx('/?', getcmdtype()) < 0 ? '' : <sid>blink(2, 50))."\<CR>"
  "endif
  "noremap <expr> <plug>(slash-after) <sid>blink(2, 50)
  noremap <expr> n 'n'.<sid>blink(2, 50)
  noremap <expr> N 'N'.<sid>blink(2, 50)
  cnoremap <expr> <CR> (stridx('/?', getcmdtype()) < 0 ? '' : <sid>blink(2, 50))."\<CR>"
endif


" ----------------------------------------------------------------------------------------
" peekaboo
" ----------------------------------------------------------------------------------------
let g:peekaboo_compact = 0                         " Compact display; do not display the names of the register groups
let g:peekaboo_delay   = 0                         " Delay opening of peekaboo window (in ms. default: 0)
let g:peekaboo_window  = 'vertical botright 30new' " Default peekaboo window

""" }}}
