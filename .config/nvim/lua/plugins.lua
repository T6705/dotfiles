local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.o.termguicolors = true -- enable 24-bit RGB colors
vim.g.mapleader = " "      -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  --------------------------------------------------------------------------------
  -- Colorscheme
  --------------------------------------------------------------------------------
  -- use { 'morhetz/gruvbox' }
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require("catppuccin").setup {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
          -- :h background
          light = "latte",
          dark = "mocha",
        },
        compile = {
          enabled = true,
          path = vim.fn.stdpath "cache" .. "/catppuccin",
          suffix = "_compiled"
        },
        dim_inactive = {
          enabled = true,              -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15,           -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,             -- Force no italic
        no_bold = false,               -- Force no bold
        no_underline = false,          -- Force no underline
        term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = true,     -- show the '~' characters after the end of buffers
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        default_integrations = true,
        integrations = {
          dropbar = {
            enabled = true,
            color_mode = true, -- enable color for kind's texts, not just kind's icons
          },
          gitsigns = true,
          lsp_trouble = true,
          mason = true,
          -- notify = true,
          nvim_surround = true,
          symbols_outline = true,
          treesitter = true,
          treesitter_context = true,
          ufo = true,
          snacks = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          --indent_blankline = {
          --  enabled = true,
          --  colored_indent_levels = false,
          --},
        }
      }
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
      vim.cmd.colorscheme "catppuccin"
    end
  },

  --------------------------------------------------------------------------------
  -- Interface
  --------------------------------------------------------------------------------
  {
    'akinsho/bufferline.nvim',
    version = "*",
    event = "VeryLazy",
    after = "catppuccin",
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
      { "catppuccin" },
    },
    config = function()
      vim.diagnostic.config { update_in_insert = true }
      require("bufferline").setup {
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
        options = {
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            icon = '▎',
            style = 'icon',
          },
          max_name_length = 18,
          max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          offsets = {
            { filetype = "NvimTree", text = "NvimTree", text_align = "center" },
            { filetype = "Outline",  text = "Outline",  text_align = "center" }
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
  },

  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
      { 'arkav/lualine-lsp-progress' }
    },
  },

  {
    "sphamba/smear-cursor.nvim",
    opts = {
      -- Faster smear
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,

      -- FIRE HAZARD
      -- cursor_color = "#ff8800",
      -- stiffness = 0.3,
      -- trailing_stiffness = 0.1,
      -- trailing_exponent = 5,
      -- hide_target_hack = true,
      -- gamma = 1,
    },
  },


  --------------------------------------------------------------------------------
  -- git
  --------------------------------------------------------------------------------
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim", lazy = true },
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
          map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
          map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
          map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
          map({ "n", "v" }, "<leader>sh", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>rh", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          --map("n", "<leader>sb", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ush", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>rb", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ph", gs.preview_hunk, "Preview Hunk")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
      })
    end
  },

  {
    'sindrets/diffview.nvim',
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
    dependencies = { "nvim-lua/plenary.nvim", lazy = true },
    keys = { { "<leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "DiffView" } },
  },

  --------------------------------------------------------------------------------
  -- lsp
  --------------------------------------------------------------------------------
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },                                            -- Required
      { 'williamboman/mason.nvim',                  build = ":MasonUpdate" }, -- Optional
      { 'williamboman/mason-lspconfig.nvim' },                                -- Optional
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },                        -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },                    -- Required
      { 'hrsh7th/cmp-nvim-lsp' },                -- Required
      { 'hrsh7th/cmp-buffer' },                  -- Optional
      { 'hrsh7th/cmp-cmdline' },                 --Optional
      { 'hrsh7th/cmp-nvim-lsp-signature-help' }, --Optional
      { 'hrsh7th/cmp-nvim-lua' },                -- Optional
      { 'hrsh7th/cmp-path' },                    -- Optional
      { 'saadparwaiz1/cmp_luasnip' },            -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip',                         build = "make install_jsregexp", enabled = vim.fn.executable("make") == 1, opts = { history = true, delete_check_events = "TextChanged" } }, -- Required
      { 'rafamadriz/friendly-snippets' },                                                                                                                                                        -- Optional
      { 'saadparwaiz1/cmp_luasnip' },
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre", config = true },
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdateSync',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "bash",
          "c",
          "diff",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            -- init_selection = '<CR>',
            -- scope_incremental = '<CR>',
            node_incremental = "v",
            node_decremental = "V",
          },
        },
        indent = {
          enable = true
        },
        matchup = {
          enable = true
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
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
            goto_next = {
              ["]d"] = "@conditional.outer",
            },
            goto_previous = {
              ["[d"] = "@conditional.outer",
            }
          },
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
      }
    end,
  },

  { 'b0o/SchemaStore.nvim', event = "VeryLazy" },
  { 'onsails/lspkind-nvim', event = 'BufEnter', config = function() require('lspkind').init() end },

  --------------------------------------------------------------------------------
  -- flutter
  --------------------------------------------------------------------------------
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      { "nvim-lua/plenary.nvim",  lazy = true },
      { 'stevearc/dressing.nvim', lazy = true }, -- optional for vim.ui.select
    },
    config = true,
  },

  --------------------------------------------------------------------------------
  -- go
  --------------------------------------------------------------------------------
  -- use { 'buoto/gotests-vim', ft = { 'go' } }
  -- use { 'fatih/vim-go', ft = { 'go' }, build = ':GoInstallBinaries' }
  -- use { 'sebdah/vim-delve', ft = { 'go' } }
  -- {
  --   'ray-x/go.nvim',
  --   ft = { "go", 'gomod' },
  --   event = { "CmdlineEnter" },
  --   build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  --   dependencies = {
  --     { 'ray-x/guihua.lua', build = 'cd lua/fzy && make', enabled = vim.fn.executable("make") == 1, },
  --     'folke/trouble.nvim',
  --     'L3MON4D3/LuaSnip',
  --   },
  --   config = function()
  --     require('go').setup({
  --       lsp_cfg = false,
  --       lsp_gofumpt = true,
  --       trouble = true,
  --       luasnip = true,
  --     })
  --     -- autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
  --     -- vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.go', command = "GoFmt" })
  --     -- vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.go', command = "GoImport" })
  --     vim.api.nvim_create_autocmd('BufWritePre',
  --       { pattern = '*.go', command = "silent! lua require('go.format').goimport()" })
  --     vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'BufEnter' },
  --       { pattern = '*.go', command = "setlocal noexpandtab tabstop=4 shiftwidth=4" })
  --   end
  -- },

  --------------------------------------------------------------------------------
  -- python
  --------------------------------------------------------------------------------
  {
    'psf/black',
    ft = { 'python' },
    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*.py", command = "Black" })
    end
  },

  --------------------------------------------------------------------------------
  -- other
  --------------------------------------------------------------------------------
  {
    'kevinhwang91/nvim-ufo',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      require('ufo').setup({
        open_fold_hl_timeout = 150,
        close_fold_kinds_for_ft = {
          default = { 'imports', 'comment' },
          json = { 'array' },
          c = { 'comment', 'region' }
        },
        preview = {
          win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
            winblend = 0
          },
          mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            jumpTop = '[',
            jumpBot = ']'
          }
        },
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      })
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
      vim.keymap.set('n', '<leader>pv', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end)
    end
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = {
                    "trouble_open",
                    mode = { "n", "i" },
                  },
                },
              },
            },
          },
        })
      end,
    },
    opts = {
      modes = {
        test = {
          mode = "diagnostics",
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
        },
      },
    },
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>",              desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xl", "<Cmd>Trouble loclist toggle<CR>",                  desc = "Location List (Trouble)" },
      { "<leader>xq", "<Cmd>Trouble quickfix toggle<CR>",                 desc = "Quickfix List (Trouble)" },
      { "gR",         "<Cmd>Trouble lsp_references toggle<CR>" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
  {
    "aznhe21/actions-preview.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>ca", "<Cmd>lua require('actions-preview').code_actions()<CR>", desc = "preview LSP code actions" },
    },
    config = function()
      require("actions-preview").setup {
        telescope = {
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = "top",
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        },
      }
    end
  },
  {
    "ghillb/cybu.nvim",
    event = "VeryLazy",
    branch = "main",
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
      "nvim-lua/plenary.nvim",
    },
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
      vim.keymap.set("n", "<S-Tab>", "<Plug>(CybuPrev)")
      vim.keymap.set("n", "<Tab>", "<Plug>(CybuNext)")
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
    keys = {
      { '<leader>`', '<Cmd>normal ysiw`<CR>' },
      { '<leader>"', '<Cmd>normal ysiw"<CR>' },
      { "<leader>'", "<Cmd>normal ysiw'<CR>" },
      { '<leader>(', '<Cmd>normal ysiw(<CR>' },
      { '<leader>)', '<Cmd>normal ysiw)<CR>' },
      { '<leader>]', '<Cmd>normal ysiw]<CR>' },
      { '<leader>[', '<Cmd>normal ysiw[<CR>' },
      { '<leader>}', '<Cmd>normal ysiw}<CR>' },
      { '<leader>{', '<Cmd>normal ysiw{<CR>' },
    },
  },
  {
    'dhruvasagar/vim-table-mode',
    -- ft = { 'markdown' },
    cmd = { "TableModeToggle" },
    keys = { { "<leader>tm", "<Cmd>TableModeToggle<CR>", desc = "TableModeToggle" } },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    ft = { 'markdown' },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("markview").setup();
    end
  },
  {
    'dstein64/vim-startuptime',
    cmd = { "StartupTime" },
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    'junegunn/fzf.vim',
    dependencies = 'junegunn/fzf',
    cmd = { "Lines", "Maps" },
    --keys = { { "<leader>bls", "<Cmd>Lines<CR>" } },
    config = function()
      vim.g.fzf_buffers_jump        = 1                                        -- [Buffers] Jump to the existing window if possible
      vim.g.fzf_commands_expect     =
      'alt-enter,ctrl-x'                                                       -- [Commands] --expect expression for directly executing the command
      vim.g.fzf_commits_log_options =
      '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"' -- [[B]Commits] Customize the options used by 'git log':
      vim.g.fzf_preview_window      = { 'right:50%', 'ctrl-/' }
      vim.g.fzf_tags_command        =
      'ctags -R --exclude=@.gitignore --exclude=.mypy_cache' -- [Tags] Command to generate tags file
    end
  },
  {
    'nacro90/numb.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    config = function()
      require('numb').setup {
        show_numbers = true,         -- Enable 'number' for the window while peeking
        show_cursorline = true,      -- Enable 'cursorline' for the window while peeking
        hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
        number_only = false,         -- Peek only when the command is only a number instead of when it starts with a number
        centered_peeking = true,     -- Peeked line will be centered relative to window
      }
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        view_options = {
          show_hidden = true,
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
        },
      })
    end
  },
  {
    "ptdewey/yankbank-nvim",
    config = function()
      require('yankbank').setup()
    end,
    keys = { { "<leader>Y", "<Cmd>YankBank<CR>" } },
  },
  {
    "bassamsdata/namu.nvim",
    config = function()
      require("namu").setup({
        -- Enable the modules you want
        namu_symbols = {
          enable = true,
          options = {}, -- here you can configure namu
        },
        -- Optional: Enable other modules if needed
        ui_select = { enable = false }, -- vim.ui.select() wrapper
        colorscheme = {
          enable = false,
          options = {
            -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
            persist = true,      -- very efficient mechanism to Remember selected colorscheme
            write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
          },
        },
      })
      -- === Suggested Keymaps: ===
      vim.keymap.set("n", "<leader>ss", ":Namu symbols<cr>", {
        desc = "Jump to LSP symbol",
        silent = true,
      })
      vim.keymap.set("n", "<leader>th", ":Namu colorscheme<cr>", {
        desc = "Colorscheme Picker",
        silent = true,
      })
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      explorer     = { enabled = true },
      gitbrowse    = { enabled = true },
      indent       = { enabled = true },
      input        = { enabled = true },
      lazygit      = { enabled = true },
      notifier     = { enabled = true, timeout = 3000 },
      notify       = { enabled = true },
      picker       = { enabled = true },
      quickfile    = { enabled = true },
      rename       = { enabled = true },
      scope        = { enabled = true },
      scroll       = { enabled = false },
      statuscolumn = { enabled = true },
      words        = { enabled = true },
    },
    keys = {
      { "<leader>gB",  function() Snacks.gitbrowse() end,                                      desc = "Git Browse" },
      { "<leader>gf",  function() Snacks.lazygit.log_file() end,                               desc = "Lazygit Current File History" },
      { "<leader>gg",  function() Snacks.lazygit() end,                                        desc = "Lazygit" },
      { "<leader>lgl", function() Snacks.lazygit.log() end,                                    desc = "Lazygit Log (cwd)" },
      { "<leader>un",  function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
      { "<leader>rf",  function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
      { "]]",          function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",              mode = { "n", "t" } },
      { "[[",          function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",              mode = { "n", "t" } },
      { "<leader>,",   function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      --{ "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>:",   function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>e",   function() Snacks.picker.files() end,                                   desc = "Find Files" },
      { "<leader>E",   function() Snacks.picker.explorer() end,                                desc = "File Explorer" },
      ---- find
      { "<leader>fb",  function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>fc",  function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff",  function() Snacks.picker.files() end,                                   desc = "Find Files" },
      { "<leader>fg",  function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
      { "<leader>fr",  function() Snacks.picker.recent() end,                                  desc = "Recent" },
      ---- git
      { "<leader>gl",  function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
      { "<leader>gs",  function() Snacks.picker.git_status() end,                              desc = "Git Status" },
      ---- Grep
      { "<leader>sb",  function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sB",  function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
      { "<leader>sg",  function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>sw",  function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",    mode = { "n", "x" } },
      ---- search
      --{ '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
      --{ "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
      --{ "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
      --{ "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
      { "<leader>sd",  function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
      --{ "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
      --{ "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
      --{ "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
      { "<leader>sk",  function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      --{ "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
      --{ "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
      { "<leader>sm",  function() Snacks.picker.marks() end,                                   desc = "Marks" },
      --{ "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
      --{ "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
      --{ "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
      --{ "<leader>qp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
      ---- LSP
      { "<leader>d",   function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
      { "<leader>r",   function() Snacks.picker.lsp_references() end,                          nowait = true,                        desc = "References" },
      { "<leader>i",   function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
      { "<leader>td",  function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
      { "<leader>so",  function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
    }
  },
})
