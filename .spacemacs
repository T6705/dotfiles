;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; better-defaults
     chinese
     chrome
     djanjo
     emacs-lisp
     emoji
     games
     git
     html
     java
     markdown
     neotree
     org
     pandoc
     php
     search-engine
     shell-scripts
     spell-checking
     spotify
     sql
     themes-megapack
     theming
     tmux
     version-control
     vim-empty-line
     vim-powerline
     vimscript
     xkcd
     ycmd
     (auto-completion :variables
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.1
                      auto-completion-enable-help-tooltip 'manual
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-sort-by-usage t
                      auto-completion-private-snippets-directory nil
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle)
     (colors :variables
             ;colors-colorize-identifiers 'all
             ;colors-enable-nyan-cat-progress-bar t
             colors-enable-nyan-cat-progress-bar ,(display-graphic-p))
     (c-c++ :variables
            c-c++-enable-clang-support t)
     (go :variables
         go-tab-width 4
         go-use-gometalinter t
         gofmt-command "goimports")
     (latex :variables
            latex-build-command "LaTeX"
            latex-enable-auto-fill t
            latex-enable-folding t)
     (python :variables
             python-enable-yapf-format-on-save t
             python-sort-imports-on-save t
             python-test-runner 'pytest)
     (ranger :variables ranger-show-preview t)
     (ruby :variables
           ruby-enable-enh-ruby-mode t
           ruby-test-runner 'rspec
           ruby-version-manager 'rvm)
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-term-shell "usr/bin/zsh")
     (syntax-checking :variables
                      syntax-checking-enable-by-default t
                      syntax-checking-enable-tooltips t
                      syntax-checking-use-original-bitmaps t)
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '()

   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(molokai)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put almost
any user code here.  The exception is org related code, which should be placed
in `dotspacemacs/user-config'."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  (spacemacs/toggle-smartparens-globally-off)
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company-quickhelp 2048-game ac-ispell ace-jump-helm-line ace-link ace-pinyin ace-window adaptive-wrap afternoon-theme aggressive-indent alect-themes alert ample-theme ample-zen-theme anaconda-mode anti-zenburn-theme anzu apropospriate-theme async auctex auto-compile auto-complete auto-dictionary auto-highlight-symbol auto-yasnippet autothemer avy badwolf-theme bind-key bind-map birds-of-paradise-plus-theme bubbleberry-theme bundler busybee-theme cherry-blossom-theme chruby clang-format clean-aindent-mode clues-theme cmake-mode color-identifiers-mode color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow column-enforce-mode company company-anaconda company-auctex company-c-headers company-emacs-eclim company-emoji company-go company-shell company-statistics company-web company-ycmd cyberpunk-theme cython-mode dactyl-mode dakrone-theme darkburn-theme darkmine-theme darkokai-theme darktooth-theme dash dash-functional deferred define-word diff-hl diminish disaster django-theme dracula-theme drupal-mode dumb-jump eclim edit-server elisp-slime-nav emmet-mode emoji-cheat-sheet-plus engine-mode enh-ruby-mode epl esh-help eshell-prompt-extras eshell-z espresso-theme eval-sexp-fu evil evil-anzu evil-args evil-ediff evil-escape evil-exchange evil-iedit-state evil-indent-plus evil-lisp-state evil-magit evil-matchit evil-mc evil-nerd-commenter evil-numbers evil-search-highlight-persist evil-surround evil-tutor evil-unimpaired evil-visual-mark-mode evil-visualstar exec-path-from-shell exotica-theme expand-region eyebrowse f fancy-battery farmhouse-theme fill-column-indicator find-by-pinyin-dired fish-mode flatland-theme flatui-theme flx flx-ido flycheck flycheck-gometalinter flycheck-pos-tip flycheck-ycmd flymd flyspell-correct flyspell-correct-helm fringe-helper fuzzy gandalf-theme gh-md ghub git-commit git-gutter git-gutter+ git-gutter-fringe git-gutter-fringe+ git-link git-messenger git-timemachine gitattributes-mode gitconfig-mode gitignore-mode gmail-message-mode gntp gnuplot go-eldoc go-guru go-mode golden-ratio google-translate gotham-theme goto-chg grandshell-theme gruber-darker-theme gruvbox-theme ham-mode haml-mode hc-zenburn-theme helm helm-ag helm-c-yasnippet helm-company helm-core helm-css-scss helm-descbinds helm-flx helm-gitignore helm-make helm-mode-manager helm-projectile helm-pydoc helm-spotify helm-spotify-plus helm-swoop helm-themes help-fns+ hemisu-theme heroku-theme hide-comnt highlight highlight-indentation highlight-numbers highlight-parentheses hl-todo ht html-to-markdown htmlize hungry-delete hy-mode hydra iedit indent-guide inf-ruby info+ inkpot-theme insert-shebang ir-black-theme jazz-theme jbeans-theme less-css-mode let-alist light-soap-theme link-hint linum-relative live-py-mode log4e lorem-ipsum lush-theme macrostep madhat2r-theme magit magit-gitflow magit-popup majapahit-theme markdown-mode markdown-toc material-theme minimal-theme minitest mmm-mode mmt moe-theme molokai-theme monochrome-theme monokai-theme move-text multi multi-term mustang-theme naquadah-theme neotree noctilux-theme obsidian-theme occidental-theme oldlace-theme omtose-phellack-theme open-junk-file org-bullets org-category-capture org-download org-mime org-plus-contrib org-pomodoro org-present org-projectile organic-green-theme orgit ox-pandoc packed pacmacs pandoc-mode pangu-spacing paradox parent-mode pcre2el persp-mode phoenix-dark-mono-theme phoenix-dark-pink-theme php-auto-yasnippets php-extras php-mode phpcbf phpunit pinyinlib pip-requirements pkg-info planet-theme popup popwin pos-tip powerline professional-theme projectile pug-mode purple-haze-theme py-isort pyenv-mode pyim pyim-basedict pytest pythonic pyvenv railscasts-theme rainbow-delimiters rainbow-identifiers rainbow-mode rake ranger rbenv rebecca-theme request request-deferred restart-emacs reverse-theme robe rspec-mode rubocop ruby-test-mode ruby-tools rvm s sass-mode scss-mode seti-theme shell-pop slim-mode smartparens smeargle smyx-theme soft-charcoal-theme soft-morning-theme soft-stone-theme solarized-theme soothe-theme spacegray-theme spaceline spinner spotify sql-indent subatomic-theme subatomic256-theme sublime-themes sudoku sunny-day-theme tagedit tango-2-theme tango-plus-theme tangotango-theme tao-theme toc-org toxi-theme twilight-anti-bright-theme twilight-bright-theme twilight-theme typit ujelly-theme underwater-theme undo-tree use-package uuidgen vi-tilde-fringe vimrc-mode volatile-highlights web-completion-data web-mode which-key white-sand-theme winum with-editor ws-butler xkcd xterm-color yapfify yasnippet ycmd zen-and-art-theme zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
