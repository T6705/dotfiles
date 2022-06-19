-- Install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

-- vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup({ function(use)
  use { 'wbthomason/packer.nvim', event = 'VimEnter' }

  --------------------------------------------------------------------------------
  -- Colorscheme
  --------------------------------------------------------------------------------
  use { 'NLKNguyen/papercolor-theme' }
  use { 'morhetz/gruvbox' }
  use { 'tomasr/molokai' }
  use { 'catppuccin/nvim', as = 'catppuccin',
    config = function()
      require("catppuccin").setup {
        transparent_background = true,
        term_colors = true,
        styles = {
          comments = "italic",
          conditionals = "italic",
          loops = "NONE",
          functions = "NONE",
          keywords = "NONE",
          strings = "NONE",
          variables = "NONE",
          numbers = "NONE",
          booleans = "NONE",
          properties = "NONE",
          types = "NONE",
          operators = "NONE",
        },
        integrations = {
          bufferline = true,
          cmp = true,
          gitsigns = true,
          lightspeed = true,
          lsp_trouble = true,
          markdown = true,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          ts_rainbow = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = "italic",
              hints = "italic",
              warnings = "italic",
              information = "italic",
            },
            underlines = {
              errors = "underline",
              hints = "underline",
              warnings = "underline",
              information = "underline",
            },
          },
          nvimtree = {
            enabled = true,
            show_root = true,
            transparent_panel = true,
          },
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          barbar = false,
          dashboard = false,
          fern = false,
          gitgutter = false,
          hop = false,
          lsp_saga = false,
          neogit = false,
          notify = false,
          telekasten = false,
          vim_sneak = false,
          which_key = false,
          neotree = {
            enabled = false,
            show_root = false,
            transparent_panel = false,
          },
        }
      }
    end
  }

  --------------------------------------------------------------------------------
  -- Interface
  --------------------------------------------------------------------------------
  -- use {'ncm2/float-preview.nvim'}
  use {
    'lukas-reineke/indent-blankline.nvim',
    -- event = 'BufRead',
    config = function()
      require('indent_blankline').setup {
        space_char_blankline = ' ',
        show_end_of_line = true,
        strict_tabs = true,
        debug = true,
        max_indent_increase = 1,
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  }

  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("bufferline").setup {
        options = {
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator_icon = '▎',
          buffer_close_icon = '',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 18,
          max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            -- local icon = level:match("error") and " " or " "
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          offsets = {
            { filetype = "NvimTree", text = "NvimTree", text_align = "center" },
            { filetype = "Outline", text = "Outline", text_align = "center" }
          },
          show_buffer_icons = true, -- disable filetype icons for buffers
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_tab_indicators = true,
          persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
          -- can also be a table containing 2 custom separators
          -- [focused and unfocused]. eg: { '|', '|' }
          separator_style = "thin",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          -- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
          --   -- add custom logic
          --   return buffer_a.modified > buffer_b.modified
          -- end
        }

      }
    end,
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
      { 'arkav/lualine-lsp-progress' }
    },
    config = function() require 'config.lualine' end,
  }

  use {
    'SmiteshP/nvim-gps',
    requires = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require("nvim-gps").setup()
    end
  }

  use {
    'kevinhwang91/nvim-hlslens',
    config = function() require 'config.hlslens' end,
  }

  --------------------------------------------------------------------------------
  -- git
  --------------------------------------------------------------------------------
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  use { 'rbong/vim-flog' }
  use { 'rhysd/git-messenger.vim' }

  use {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
      vim.keymap.set('n', '<leader>gd', ':Gvdiff<CR>')
      vim.keymap.set('n', '<leader>gps', ':Git push<CR>')
      vim.keymap.set('n', '<leader>gpu', ':Git pull<CR>')
      vim.keymap.set('n', '<leader>gr', ':GRemove<CR>')
      vim.keymap.set('n', '<leader>gs', ':Git<CR>')
      vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>')
    end
  }

  --------------------------------------------------------------------------------
  -- lsp
  --------------------------------------------------------------------------------

  -- use {
  --   "ray-x/lsp_signature.nvim",
  --   config = function()
  --     require "lsp_signature".setup()
  --   end
  -- }
  -- use {
  --   'smjonas/inc-rename.nvim',
  --   config = function()
  --     require("inc_rename").setup()
  --     vim.keymap.set("n", "<leader>rn", ":IncRename ")
  --   end }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
      'p00f/nvim-ts-rainbow'
    },
    -- event = 'BufRead',
    run = ':TSUpdateSync',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = 'all',
        sync_install = true,
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
          },
        },
        indent = {
          enable = true
        },
        matchup = {
          enable = true
        },
        rainbow = {
          enable = true,
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- automatically jump forward to matching textobj
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner"
            }
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner"
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner"
            }
          }
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
        refactor = {
          highlight_definitions = {
            -- Highlights definition and usages of the current symbol under the cursor.
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
          },
          highlight_current_scope = {
            -- Highlights the block from the current scope where the cursor is.
            enable = false
          },
          smart_rename = {
            --Renames the symbol under the cursor within the current scope (and current file).
            enable = true,
            keymaps = {
              smart_rename = "grr",
            },
          },
        },
      }
    end,
  }

  use {
    'williamboman/nvim-lsp-installer',
    config = function() require 'config.lspinstall' end,
  }

  use {
    'onsails/lspkind-nvim',
    event = 'BufEnter',
    config = function() require('lspkind').init() end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-calc' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-emoji' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-path' },
      { 'lukas-reineke/cmp-rg' },
    },
    config = function() require 'config.nvim-cmp' end,
  }

  use {
    'quangnguyen30192/cmp-nvim-ultisnips',
    config = function()
      require('cmp_nvim_ultisnips').setup {}
    end
  }

  use { 'folke/lsp-colors.nvim' }
  use { 'kosayoda/nvim-lightbulb' }
  use { 'neovim/nvim-lspconfig' }


  --------------------------------------------------------------------------------
  -- snippets
  --------------------------------------------------------------------------------
  use {
    'SirVer/ultisnips',
    requires = { { 'honza/vim-snippets', rtp = '.' } },
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
      vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
      vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
      vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
    end
  }

  --------------------------------------------------------------------------------
  -- debugging
  --------------------------------------------------------------------------------
  use {
    'leoluz/nvim-dap-go',
    config = function()
      require('dap-go').setup()
    end
  }

  use { 'mfussenegger/nvim-dap' }

  use {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has("nvim-0.7"),
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
        }
      })
    end
  }

  use {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup {
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
        filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
        -- experimental features:
        virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      }
    end
  }

  --------------------------------------------------------------------------------
  -- go
  --------------------------------------------------------------------------------
  use { 'buoto/gotests-vim', ft = { 'go' } }
  use { 'fatih/vim-go', ft = { 'go' }, run = ':GoInstallBinaries' }
  use { 'sebdah/vim-delve', ft = { 'go' } }

  --------------------------------------------------------------------------------
  -- python
  --------------------------------------------------------------------------------
  use { 'psf/black', ft = { 'python' } }

  --------------------------------------------------------------------------------
  -- other
  --------------------------------------------------------------------------------
  -- use {'brianrodri/vim-sort-folds'}
  -- use {'cometsong/CommentFrame.vim'}
  -- use {'junegunn/rainbow_parentheses.vim'}
  -- use {'kshenoy/vim-signature'}
  -- use {'liuchengxu/vista.vim'}
  -- use {'ludovicchabant/vim-gutentags'}
  -- use {'majutsushi/tagbar'}
  -- use {'psliwka/vim-smoothie'}
  -- use {'romainl/vim-qf'}
  -- use {'rrethy/vim-hexokinase'}
  -- use {'scrooloose/nerdcommenter'}
  -- use {'sjl/gundo.vim'}
  -- use {'skywind3000/gutentags_plus'}
  -- use {'terryma/vim-multiple-cursors'}
  -- use {'voldikss/vim-floaterm'}
  -- use {'w0rp/ale'}

  -- use {
  -- 'folke/which-key.nvim',
  -- config = function()
  --   require('which-key').setup{
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   }
  -- end
  -- }

  --   -- Exposed highlight groups, useful for themes
  --   vim.cmd('hi ModesCopy guibg=#51AFEF')
  --   vim.cmd('hi ModesDelete guibg=#C678DD')
  --   vim.cmd('hi ModesInsert guibg=#98BE65')
  --   vim.cmd('hi ModesVisual guibg=#FF8800')

  -- use({
  --   'mvllow/modes.nvim',
  --   config = function()
  --     vim.opt.cursorline = true
  --     require('modes').setup({
  --       colors = {
  --         copy = "#51AFEF",
  --         delete = "#C678DD",
  --         insert = "#98BE65",
  --         visual = "#FF8800",
  --       },

  --       -- Cursorline highlight opacity
  --       line_opacity = 0.1,

  --       -- Highlight cursor
  --       set_cursor = true,

  --       -- Enable cursorline initially, and disable cursorline for inactive windows
  --       -- or ignored filetypes
  --       set_cursorline = true,

  --       -- Enable line number highlights to match cursorline
  --       set_number = true,
  --     })
  --   end
  -- })

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'nvim-tree'.setup {
        auto_reload_on_write = true,
        create_in_closed_folder = false,
        disable_netrw = false,
        hijack_cursor = false,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = false,
        open_on_setup = false,
        open_on_setup_file = false,
        open_on_tab = false,
        sort_by = "name",
        update_cwd = true,
        reload_on_bufenter = true,
        respect_buf_cwd = true,
        view = {
          adaptive_size = true,
          width = 35,
          height = 30,
          hide_root_folder = false,
          side = "left",
          preserve_window_proportions = true,
          number = false,
          relativenumber = false,
          signcolumn = "yes",
          mappings = {
            custom_only = false,
            list = {
              -- user mappings go here
            },
          },
        },
        renderer = {
          add_trailing = true,
          group_empty = true,
          highlight_git = true,
          highlight_opened_files = "none",
          root_folder_modifier = ":~",
          indent_markers = {
            enable = true,
            icons = {
              corner = "└ ",
              edge = "│ ",
              none = "  ",
            },
          },
          icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
          special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        },
        hijack_directories = {
          enable = true,
          auto_open = true,
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
        ignore_ft_on_setup = {},
        system_open = {
          cmd = "",
          args = {},
        },
        diagnostics = {
          enable = false,
          show_on_dirs = false,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        filters = {
          dotfiles = false,
          custom = {},
          exclude = {},
        },
        git = {
          enable = true,
          ignore = true,
          timeout = 400,
        },
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          expand_all = {
            max_folder_discovery = 300,
          },
          open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
              enable = true,
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
          remove_file = {
            close_window = true,
          },
        },
        trash = {
          cmd = "trash",
          require_confirm = true,
        },
        live_filter = {
          prefix = "[FILTER]: ",
          always_show_folders = true,
        },
        log = {
          enable = false,
          truncate = false,
          types = {
            all = false,
            config = false,
            copy_paste = false,
            diagnostics = false,
            git = false,
            profile = false,
          },
        },
      }
      vim.keymap.set('n', '<leader>E', ':NvimTreeToggle<CR>')
      vim.keymap.set('n', '<leader>R', ':NvimTreeRefresh<CR>')
      vim.keymap.set('n', '<leader>F', ':NvimTreeFindFile<CR>')
    end,
  }

  use { 'anuvyklack/pretty-fold.nvim',
    requires = 'anuvyklack/nvim-keymap-amend', -- only for preview
    config = function()
      require('pretty-fold').setup {
        keep_indentation = false,
        fill_char = '━',
        sections = {
          left = {
            '━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
          },
          right = {
            '┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━',
          }
        }
      }
      require('pretty-fold.preview').setup()
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require("toggleterm").setup {
        open_mapping = [[<leader>ft]],
        direction = 'float',
        float_opts = {
          border = 'curved'
        }
      }
    end
  }

  use {
    'karb94/neoscroll.nvim',
    config = function() require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {
          '<C-u>',
          '<C-d>',
          '<C-b>',
          '<C-f>',
          '<C-y>',
          '<C-e>',
          'zt',
          'zz',
          'zb'
        },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = false, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end
  }

  use {
    'junegunn/vim-easy-align',
    config = function()
      vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')
      vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
    end
  }

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup {
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
          -- map to {} to remove a mapping, for example:
          -- close = {},
          close = "q", -- close the list
          cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r", -- manually refresh
          jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
          open_split = { "<c-x>" }, -- open buffer in new split
          open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
          open_tab = { "<c-t>" }, -- open buffer in new tab
          jump_close = { "o" }, -- jump to the diagnostic and close the list
          toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
          toggle_preview = "P", -- toggle auto_preview
          hover = "K", -- opens a small popup with the full multiline message
          preview = "p", -- preview the diagnostic location
          close_folds = { "zM", "zm" }, -- close all folds
          open_folds = { "zR", "zr" }, -- open all folds
          toggle_fold = { "zA", "za" }, -- toggle fold of current file
          previous = "k", -- preview item
          next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = true, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
        use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
      }
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
      vim.keymap.set("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>")
      vim.keymap.set("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>")
      vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
      vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
      vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>")
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-media-files.nvim' }
    },
    config = function() require 'config.telescope' end,
  }

  use({
    "ghillb/cybu.nvim",
    branch = "main",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require('cybu').setup({
        style = {
          highlights = {
            current_buffer = "Cursorline",
            adjacent_buffers = "LineNr",
            background = "Normal",
          },
        },
      })
      vim.keymap.set("n", "[b", "<Plug>(CybuPrev)")
      vim.keymap.set("n", "]b", "<Plug>(CybuNext)")
    end,
  })

  use {
    'windwp/nvim-ts-autotag',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        autotag = {
          enable = true,
        }
      }
    end
  }

  use {
    'ggandor/lightspeed.nvim',
    config = function()
      require 'lightspeed'.setup {
        jump_to_unique_chars = { safety_timeout = 400 },
        match_only_the_start_of_same_char_seqs = true,
        limit_ft_matches = 5,
      }
    end
  }

  use { 'yamatsum/nvim-cursorline',
    config = function()
      require('nvim-cursorline').setup {
        cursorline = {
          enable = true,
          timeout = 1000,
          number = true,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        }
      }
    end
  }

  use { 'andymass/vim-matchup', event = 'User ActuallyEditing' }
  use { 'dhruvasagar/vim-table-mode' }
  use { 'dstein64/vim-startuptime' }
  use { 'junegunn/fzf' }
  use { 'junegunn/fzf.vim', setup = [[require('config.fzf')]] }
  use { 'junegunn/vim-peekaboo' }
  use { 'luukvbaal/stabilize.nvim', config = function() require('stabilize').setup() end }
  use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
  use { 'rcarriga/nvim-notify', config = function() vim.notify = require("notify") end }
  use { 'simrat39/symbols-outline.nvim', setup = [[require('config.symbols-outline')]] }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'wellle/targets.vim' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    max_jobs = 8, -- Limit the number of simultaneous jobs. nil means no limit
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    },
    profile = {
      enable = true,
      threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
    },
  } })
