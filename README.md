# dotfile

## Linux requirement

### git repo

- [neovim](https://github.com/neovim/neovim)
- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [powerline-shell](https://github.com/milkbikis/powerline-shell)

### package

- npm
- tmux
- vim
- vim-athena
- vim-gnome
- vim-gtk
- vim-nox
- xclip
- xsel
- zsh

if you are using Ubuntu/Debian, install the packages with:

```terminal
[sudo] apt-get install zsh tmux xclip xsel npm vim vim-athena vim-gnome vim-gtk vim-nox -y
```

## Installation

Run the following command in terminal:

```terminal
sh -c "`curl -fsSL https://raw.githubusercontent.com/T6705/dotfile/master/install.sh`"
```

## Vim Command Shortcuts

### Copy and paste 

Commands | Shortcuts
--- | ---
`"+y` | `YY`
`"+x` | `XX`
`"+gP` | `,p`

### Scrolling

Commands | Shortcuts
--- | ---
`2<Ctrl + e>` | `Ctrl + j`
`2<Ctrl + y>` | `Ctrl + k`

### Window split

Commands | Shortcuts
--- | ---
`:split` | `,h`
`:vsplit` | `,v`

### Buffers

Commands | Shortcuts
--- | ---
`:bp` | `,q / ,z`
`:bn` | `,w / ,x`

### Tabs

Commands | Shortcuts
--- | ---
`:tabnew` | `Shift + t`
`gt` | `Tab`
`gT` | `Shift + Tab`

### [fugitive.vim](https://github.com/tpope/vim-fugitive)

Commands | Shortcuts
--- | ---
`Gwrite` | `gw`
`Gcommit` | `gc`
`Gpush` | `gps`
`Gpull` | `gpl`
`Gstatus` | `gs`
`Gblame` | `gb`
`Gvdiff` | `gd`
`Gremove` | `gr`

### Others

Commands | Shortcuts
--- | ---
`:set hlsearch! hlsearch?` | `,sc`
`:Explore` | `,E`
`za` | `SPACE`
`:NERDTreeFind` | `F2`
`:NERDTreeToggle` | `F3`
`:ColorToggle` | `F4`
`:UndotreeToggle` | `F5`
`:TagbarToggle` | `F6`
`:%!xxd` | `F7`
`:%!xxd -r` | `F8`
