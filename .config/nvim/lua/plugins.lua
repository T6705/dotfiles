-- Install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

-- vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup({ function(use)
  use { 'wbthomason/packer.nvim', event = 'VimEnter' }

  --------------------------------------------------------------------------------
  -- Colorscheme
  --------------------------------------------------------------------------------
  use { 'NLKNguyen/papercolor-theme' }
  use { 'chriskempson/vim-tomorrow-theme' }
  use { 'flazz/vim-colorschemes' }
  use { 'google/vim-colorscheme-primary' }
  use { 'morhetz/gruvbox' }
  use { 'rakr/vim-one' }
  use { 'roosta/vim-srcery' }
  use { 'tomasr/molokai' }

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
    setup = [[require('config.vim-fugitive')]],
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

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
      'p00f/nvim-ts-rainbow'
    },
    -- event = 'BufRead',
    run = ':TSUpdateSync',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = 'all',
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
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
      }
    end,
  }

  use { 'neovim/nvim-lspconfig' }

  use {
    'williamboman/nvim-lsp-installer',
    config = function() require 'config.lspinstall' end,
  }

  use { 'kosayoda/nvim-lightbulb' }

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

  -- Exposed highlight groups, useful for themes
  vim.cmd('hi ModesCopy guibg=#51AFEF')
  vim.cmd('hi ModesDelete guibg=#C678DD')
  vim.cmd('hi ModesInsert guibg=#98BE65')
  vim.cmd('hi ModesVisual guibg=#FF8800')

  use({
    'mvllow/modes.nvim',
    config = function()
      vim.opt.cursorline = true
      require('modes').setup({
        colors = {
          copy = "#51AFEF",
          delete = "#C678DD",
          insert = "#98BE65",
          visual = "#FF8800",
        },

        -- Cursorline highlight opacity
        line_opacity = 0.1,

        -- Highlight cursor
        set_cursor = true,
      })
    end
  })

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require 'nvim-tree'.setup {} end,
    setup = [[require('config.nvim-tree')]]
  }

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
    setup = [[require('config.vim-easy-align')]],
  }

  use { 'folke/lsp-colors.nvim' }
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup {}
    end,
    setup = [[require('config.trouble')]],
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

  use { 'andymass/vim-matchup', event = 'User ActuallyEditing' }
  use { 'dhruvasagar/vim-table-mode' }
  use { 'dstein64/vim-startuptime' }
  use { 'ggandor/lightspeed.nvim' }
  use { 'junegunn/fzf' }
  use { 'junegunn/fzf.vim', setup = [[require('config.fzf')]] }
  use { 'junegunn/vim-peekaboo' }
  use { 'lpinilla/vim-codepainter' }
  use { 'luukvbaal/stabilize.nvim', config = function() require('stabilize').setup() end }
  use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
  use { 'simrat39/symbols-outline.nvim', setup = [[require('config.symbols-outline')]] }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'wellle/targets.vim' }
  use { 'yamatsum/nvim-cursorline' }

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
