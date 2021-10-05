" vim:foldmethod=marker:foldlevel=0

""" === Plugin Config === {{{

if executable("git")
    " === airblade/vim-gitgutter === {{{
    " Use fontawesome icons as signs
    let g:gitgutter_sign_added = ''
    let g:gitgutter_sign_modified = ''
    let g:gitgutter_sign_removed = ''
    let g:gitgutter_sign_removed_first_line = ''
    let g:gitgutter_sign_modified_removed = ''

    let g:gitgutter_override_sign_column_highlight = 1
    let g:gitgutter_preview_win_floating = 1
    "highlight SignColumn guibg=bg
    "highlight SignColumn ctermbg=bg
    highlight GitGutterAdd    guifg=#009900 guibg=#272822
    highlight GitGutterChange guifg=#bbbb00 guibg=#272822
    highlight GitGutterDelete guifg=#ff2222 guibg=#272822

    " Update sign column every quarter second
    set updatetime=250

    " Update sign column every quarter second
    fu! NextHunkAllBuffers()
      let line = line('.')
      GitGutterNextHunk
      if line('.') != line
        return
      endif

      let bufnr = bufnr('')
      while 1
        bnext
        if bufnr('') == bufnr
          return
        endif
        if !empty(GitGutterGetHunks())
          normal! 1G
          GitGutterNextHunk
          return
        endif
      endwhile
    endfu

    fu! PrevHunkAllBuffers()
      let line = line('.')
      GitGutterPrevHunk
      if line('.') != line
        return
      endif

      let bufnr = bufnr('')
      while 1
        bprevious
        if bufnr('') == bufnr
          return
        endif
        if !empty(GitGutterGetHunks())
          normal! G
          GitGutterPrevHunk
          return
        endif
      endwhile
    endfu

    nmap <silent> ]c :call NextHunkAllBuffers()<CR>
    nmap <silent> [c :call PrevHunkAllBuffers()<CR>set updatetime=250
    " }}}

    " === tpope/vim-fugitive === {{{
    nnoremap <silent> <Leader>gb  :Gblame<CR>
    nnoremap <silent> <Leader>gc  :Gcommit<CR>
    nnoremap <silent> <Leader>gd  :Gvdiff<CR>
    nnoremap <silent> <Leader>gps :Gpush<CR>
    nnoremap <silent> <Leader>gpu :Gpull<CR>
    nnoremap <silent> <Leader>gr  :Gremove<CR>
    nnoremap <silent> <Leader>gs  :Gstatus<CR>
    nnoremap <silent> <Leader>gw  :Gwrite<CR>
    " }}}

    " === rhysd/git-messenger.vim === {{{
    nnoremap <silent> <Leader>gm  :GitMessenger<CR>
    " }}}
endif

if executable("go")
    " === fatih/vim-go === {{{
    let g:go_fmt_options = {
                \ 'goimports': '-local do/',
                \ }
    "
    let g:go_debug_windows = {
                \ 'vars':  'leftabove 35vnew',
                \ 'stack': 'botright 10new',
                \ }

    let g:go_addtags_transform          = "snakecase" " Set whether the JSON tags should be snakecase or camelcase.
    let g:go_auto_sameids               = 1           " Highlight variable uses
    let g:go_auto_type_info             = 1           " Show type information
    let g:go_autodetect_gopath          = 1
    let g:go_code_completion_enabled    = 0
    let g:go_debug                      = ['gopls']
    let g:go_def_mode                   = "gopls"
    let g:go_echo_command_info          = 1           " Show the progress when running :GoCoverage
    let g:go_fmt_command                = "goimports" " Run goimports when running gofmt
    let g:go_fmt_fail_silently          = 0
    let g:go_fold_enable                = []
    let g:go_gocode_autobuild           = 1
    let g:go_gocode_unimported_packages = 1
    let g:go_info_mode                  = 'gopls'
    let g:go_list_type                  = "quickfix"  " Fix for location list when vim-go is used together with Syntastic
    let g:go_modifytags_transform       = 'snakecase'
    let g:go_referrers_mode             = 'gopls'
    let g:go_sameid_search_enabled      = 1
    let g:go_snippet_engine             = "automatic" " Automatically detect a snippet engine.
    let g:go_test_show_name             = 1           " Add the failing test name to the output of :GoTest

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
        au FileType go nmap <silent> <Leader>b <Plug>(go-build)
        au FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)
        au FileType go nmap <silent> <Leader>i <Plug>(go-info)
        au FileType go nmap <silent> <Leader>in  <Plug>(go-install)
        au FileType go nmap <silent> <Leader>ml <Plug>(go-metalinter)
        au FileType go nmap <silent> <Leader>r  <Plug>(go-run)
        au FileType go nmap <silent> <Leader>rb :<C-u>call <SID>build_go_files()<CR>
        au FileType go nmap <silent> <Leader>t  <Plug>(go-test)

        " def
        au FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)
        au FileType go nmap <silent> <Leader>ds <Plug>(go-def-split)
        au FileType go nmap <silent> <Leader>dv <Plug>(go-def-vertical)

        " doc
        au FileType go nmap <silent> <Leader>doc <Plug>(go-doc-browser)
        au FileType go nmap <silent> <Leader>docv <Plug>(go-doc-vertical)

        "" vim-go debug
        "au FileType go nmap <silent> <Leader>db :GoDebugStart<CR>
        "au FileType go nmap <silent> <Leader>bp <Plug>(go-debug-breakpoint)
        "au FileType go nmap <silent> \c <Plug>(go-debug-continue)
        "au FileType go nmap <silent> \n <Plug>(go-debug-next)
        "au FileType go nmap <silent> \p <Plug>(go-debug-print)
        "au FileType go nmap <silent> \s <Plug>(go-debug-step)

        "" vim-godebug
        "au FileType go nmap <silent> <Leader>db :call GoDebug()
        "au FileType go nmap <silent> <Leader>bp :call GoToggleBreakpoint()

        " vim-delve
        au FileType go nmap <silent> <Leader>db :DlvDebug<CR>
        au FileType go nmap <silent> <Leader>bp :DlvAddBreakpoint<CR>
        au FileType go nmap <silent> <Leader>tp :DlvAddTracepoint<CR>
        au FileType go nmap <silent> <Leader>dca :DlvClearAll<CR>

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
" }}}
endif

if executable('node')
    " === neoclide/coc.nvim === {{{
    " coc extensions
    let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ 'coc-css',
      \ 'coc-go',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-markdownlint',
      \ 'coc-pyright',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-ultisnips',
    \ ]

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    fu! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfu

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> <Leader>d <Plug>(coc-definition)
    nmap <silent> <Leader>td <Plug>(coc-type-definition)
    nmap <silent> <Leader>i <Plug>(coc-implementation)
    nmap <silent> <Leader>r <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    fu! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfu

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <Leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <Leader>fm  <Plug>(coc-format-selected)
    nmap <Leader>fm  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<Leader>aap` for current paragraph
    xmap <Leader>a  <Plug>(coc-codeaction-selected)
    nmap <Leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <Leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <Leader>qf  <Plug>(coc-fix-current)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add diagnostic info for https://github.com/itchyny/lightline.vim
    let g:lightline = {
          \ 'colorscheme': 'wombat',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
          \ },
          \ 'component_function': {
          \   'cocstatus': 'coc#status'
          \ },
          \ }



    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>cld  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>cle  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>clc  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>clo  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>cls  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>cln  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>clp  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>clr  :<C-u>CocListResume<CR>
    " }}}
endif

" === tpope/vim-surround === {{{
" Maps ss to surround word
nmap ss ysiw

" Maps sl to surround line
nmap sl yss

"" Surround Visual selection
"vmap s S

" <Leader>` Surround a word with "backticks"
nmap     <silent> <Leader>` ysiw`
vnoremap <silent> <Leader>` c`<C-R>"`<Esc>

" <Leader>" Surround a word with "quotes"
nmap     <silent> <Leader>" ysiw"
vnoremap <silent> <Leader>" c"<C-R>""<Esc>

" <Leader>' Surround a word with 'single quotes'
nmap     <silent> <Leader>' ysiw'
vnoremap <silent> <Leader>' c'<C-R>"'<Esc>

" <Leader>( Surround a word with ( brackets )
" <Leader>) Surround a word with (brackets)
nmap     <silent> <Leader>( ysiw(
nmap     <silent> <Leader>) ysiw)
vnoremap <silent> <Leader>( c( <C-R>" )<Esc>
vnoremap <silent> <Leader>) c(<C-R>")<Esc>

" <Leader>[ Surround a word with [ brackets ]
" <Leader>] Surround a word with [brackets]
nmap     <silent> <Leader>] ysiw]
nmap     <silent> <Leader>[ ysiw[
vnoremap <silent> <Leader>[ c[ <C-R>" ]<Esc>
vnoremap <silent> <Leader>] c[<C-R>"]<Esc>

" <Leader>{ Surround a word with { braces }
" <Leader>} Surround a word with {braces}
nmap     <silent> <Leader>} ysiw}
nmap     <silent> <Leader>{ ysiw{
vnoremap <silent> <Leader>} c{ <C-R>" }<Esc>
vnoremap <silent> <Leader>{ c{<C-R>"}<Esc>
" }}}

" === RRethy/vim-hexokinase === {{{
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
" }}}

" === dhruvasagar/vim-table-mode === {{{
let g:table_mode_corner = "|"
"let g:table_mode_corner_corner="+"
"let g:table_mode_header_fillchar="="

nnoremap <silent> <Leader>tm :TableModeToggle<CR>
" }}}

" === scrooloose/nerdcommenter === {{{
let g:NERDAltDelims_java         = 1      " Set a language to use its alternate delimiters by default
let g:NERDCommentEmptyLines      = 1      " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCompactSexyComs        = 1      " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign           = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDSpaceDelims            = 1      " Add spaces after comment delimiters by default
let g:NERDTrimTrailingWhitespace = 1      " Enable trimming of trailing whitespace when uncommenting
" }}}

" === sjl/gundo.vim === {{{
let g:gundo_prefer_python3 = 1

nnoremap <silent> <Leader>ut :GundoToggle<CR>
" }}}

" === netrw === {{{
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
" }}}

" === vim-airline/vim-airline === {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"let g:airline_theme="luna"
"let g:airline_theme="onedark"
"let g:airline_theme="papercolor"
let g:airline#extensions#ale#enabled          = 1
let g:airline#extensions#branch#enabled       = 1
let g:airline#extensions#coc#enabled          = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#gutentags#enabled    = 1
let g:airline#extensions#tabline#enabled      = 1
let g:airline#extensions#tagbar#enabled       = 1
let g:airline#extensions#virtualenv#enabled   = 1
let g:airline#extensions#whitespace#enabled   = 1
let g:airline#extensions#wordcount#enabled    = 1
"let g:airline#extensions#ycm#enabled          = 1

let g:airline#extensions#tabline#buffer_nr_format = '%s '
let g:airline#extensions#tabline#buffer_nr_show   = 1
let g:airline#extensions#tabline#exclude_preview  = 1
let g:airline#extensions#tabline#fnamecollapse    = 1
let g:airline#extensions#tabline#fnamemod         = ':t'
let g:airline#extensions#tabline#formatter        = 'unique_tail_improved'
let g:airline#extensions#tabline#left_alt_sep     = '|'
let g:airline#extensions#tabline#left_sep         = ' '
let g:airline#extensions#tabline#show_splits      = 1
let g:airline#extensions#tabline#show_tab_count   = 1
let g:airline#extensions#tabline#show_tabs        = 1

let g:airline_left_sep            = ''
let g:airline_powerline_fonts     = 1
let g:airline_right_sep           = ''
let g:airline_skip_empty_sections = 1

let g:airline_theme = "wombat"
" }}}

" === ryanoasis/vim-devicons === {{{
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
" }}}

" === Yggdroot/indentLine === {{{
let g:indentLine_char      = '▸'
let g:indentLine_enabled   = 1 "enable by default
let g:indentLine_setColors = 1 "overwrite 'conceal' color
" }}}

" === Shougo/neosnippet.vim === {{{
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.config/nvim/plugged/vim-snippets/snippets'

" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" }}}

" === SirVer/ultisnips === {{{
let g:UltiSnipsExpandTrigger       = "<TAB>"
let g:UltiSnipsJumpBackwardTrigger = "<C-p>"
let g:UltiSnipsJumpForwardTrigger  = "<C-n>"
let g:UltiSnipsEditSplit           = "vertical" " If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsSnippetsDir         = "~/.vim/UltiSnips"
" }}}

" === majutsushi/tagbar === {{{
if v:version >= 703
    let g:tagbar_sort      = 0
    let g:tagbar_autofocus = 1
    nnoremap <silent> <Leader>tb :TagbarToggle<CR>
endif
" }}}

" === liuchengxu/vista.vim === {{{
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1
" }}}

" === ludovicchabant/vim-gutentags === {{{
let gutentags_dir = expand('~/.cache/tags')
if !isdirectory(gutentags_dir)
    call mkdir(gutentags_dir, "p", 0700)
endif

command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')
let g:gutentags_add_default_project_roots = 0
let g:gutentags_auto_add_gtags_cscope     = 0                         " forbid gutentags adding gtags databases
let g:gutentags_cache_dir                 = expand('~/.cache/tags')   " generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_generate_on_empty_buffer  = 0
let g:gutentags_generate_on_missing       = 1
let g:gutentags_generate_on_new           = 1
let g:gutentags_generate_on_write         = 1
"let g:gutentags_modules                   = ['ctags', 'gtags_cscope'] " enable gtags module
let g:gutentags_modules                   = ['ctags'] " enable gtags module
let g:gutentags_project_root              = ['package.json', '.git']  " config project root markers.
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude    = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]
" }}}

" === TaDaa/vimade === {{{
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
" }}}

" === psf/black === {{{
let g:black_fast                      = 0   " (defaults to 0)
let g:black_linelength                = 88  " (defaults to 88)
let g:black_skip_string_normalization = 0   " (defaults to 0)
"let g:black_virtualenv               = ~/.vim/black " (defaults to ~/.vim/black)
" }}}

" === junegunn/fzf === {{{
if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --height=50% --info=inline --border --margin=1 --padding=1 --bind up:preview-up,down:preview-down'
endif

let g:fzf_buffers_jump        = 1                                                                        " [Buffers] Jump to the existing window if possible
let g:fzf_commands_expect     = 'alt-enter,ctrl-x'                                                       " [Commands] --expect expression for directly executing the command
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"' " [[B]Commits] Customize the options used by 'git log':
let g:fzf_preview_window      = ['right:50%', 'ctrl-/']
let g:fzf_tags_command        = 'ctags -R --exclude=@.gitignore --exclude=.mypy_cache'                   " [Tags] Command to generate tags file

if has('nvim')
    let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
endif

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
    " otherwise, use :Files
    nnoremap <silent> <Leader>e :Files<CR>
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
" }}}

" === junegunn/vim-easy-align === {{{
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
" }}}

" === junegunn/vim-slash === {{{
if has('timers') && !has('nvim')
  noremap <expr> <plug>(slash-after) slash#blink(2, 50)
endif
" }}}

" === junegunn/peekaboo === {{{
let g:peekaboo_compact = 0                         " Compact display; do not display the names of the register groups
let g:peekaboo_delay   = 0                         " Delay opening of peekaboo window (in ms. default: 0)
let g:peekaboo_window  = 'vertical botright 30new' " Default peekaboo window
" }}}

" === junegunn/rainbow_parentheses.vim === {{{
let g:rainbow#max_level = 32
let g:rainbow#pairs     = [['(', ')'], ['[', ']'], ['{','}']]
" }}}
"
" === voldikss/vim-floaterm === {{{
let g:floaterm_position = "center" " Available: 'auto', 'topleft', 'topright', 'bottomleft', 'bottomright', 'center'
let g:floaterm_width = winwidth(0) * 8 / 10
let g:floaterm_height = winheight(0) * 8 / 10
let g:floaterm_winblend = 50

noremap  <silent> <Leader>ft :FloatermToggle<CR>
noremap! <silent> <Leader>ft <Esc>:FloatermToggle<CR>
tnoremap <silent> <Leader>ft <C-\><C-n>:FloatermToggle<CR>
" }}}

" === nvim-treesitter/nvim-treesitter === {{{
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = {
        enable = true
    },
    matchup = {
        enable = true
    },
}
EOF
" }}}

" === symbols-outline.nvim === {{{
let g:symbols_outline = {
    \ "highlight_hovered_item": v:true,
    \ "show_guides": v:true,
    \ "position": 'right',
    \ "keymaps": {
        \ "close": "<Esc>",
        \ "goto_location": "<Cr>",
        \ "focus_location": "o",
        \ "hover_symbol": "<C-space>",
        \ "rename_symbol": "r",
        \ "code_actions": "a",
    \ },
    \ "lsp_blacklist": [],
\ }
" }}}

" === gelguy/wilder.nvim === {{{
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<C-N>',
      \ 'previous_key': '<C-P>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
      \ })

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      "\       'file_command': ['find', '.', '-type', 'f', '-printf', '%P\n'],
      "\       'file_command': ['fd', '-tf'],
      \       'file_command': ['rg', '--files'],
      \       'dir_command': ['fd', '-td'],
      "\       'dir_command': ['find', '.', '-type', 'd', '-printf', '%P\n'],
      \       'filters': ['fuzzy_filter', 'difflib_sorter'],
      \     }),
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'set_pcre2_pattern': has('nvim'),
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': 'fuzzy',
      \     }),
      \   ),
      \ ])

let s:highlighters = [
        \ wilder#pcre2_highlighter(),
        \ wilder#basic_highlighter(),
        \ ]

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer({
      \   'highlighter': s:highlighters,
      \ 'left': [
      \   wilder#popupmenu_devicons(),
      \ ],
      \ }),
      \ '/': wilder#wildmenu_renderer({
      \   'highlighter': s:highlighters,
      \ 'left': [
      \   wilder#popupmenu_devicons(),
      \ ],
      \ }),
      \ }))
" }}}

""" }}}
