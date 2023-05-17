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
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false, -- Force no italic
        no_bold = false,   -- Force no bold
        term_colors = true,
        transparent_background = true,
        show_end_of_buffer = true, -- show the '~' characters after the end of buffers
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
        integrations = {
          bufferline = true,
          cmp = true,
          gitsigns = true,
          lsp_trouble = true,
          markdown = true,
          notify = true,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          ts_rainbow = true,
          dap = {
            enabled = true,
            enable_ui = true,
          },
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
          nvimtree = {
            enabled = true,
            show_root = true,
            transparent_panel = true,
          },
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          barbar = false,
          dashboard = false,
          fern = false,
          gitgutter = false,
          hop = false,
          lightspeed = false,
          lsp_saga = false,
          neogit = false,
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
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
      vim.cmd.colorscheme "catppuccin"
    end
  },

  --------------------------------------------------------------------------------
  -- Interface
  --------------------------------------------------------------------------------
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = "BufReadPost",
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
  },

  {
    'akinsho/bufferline.nvim',
    version = "v3.*",
    event = "VeryLazy",
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
      { "catppuccin" },
    },
    config = function()
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
          buffer_close_icon = '',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 18,
          max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = true,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            -- local icon = level:match("error") and " " or " "
            local icon = level:match("error") and " " or " "
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
    'kevinhwang91/nvim-hlslens',
    event = "VeryLazy",
    config = function()
      require('hlslens').setup({
        override_lens = function(render, posList, nearest, idx, relIdx)
          local sfw = vim.v.searchforward == 1
          local indicator, text, chunks
          local absRelIdx = math.abs(relIdx)
          if absRelIdx > 1 then
            indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
          elseif absRelIdx == 1 then
            indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
          else
            indicator = ''
          end

          local lnum, col = unpack(posList[idx])
          if nearest then
            local cnt = #posList
            if indicator ~= '' then
              text = ('[%s %d/%d]'):format(indicator, idx, cnt)
            else
              text = ('[%d/%d]'):format(idx, cnt)
            end
            chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
          else
            text = ('[%s %d]'):format(indicator, idx)
            chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
          end
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end
      })

      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zzzv]], opts)
      -- map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zzzv]], opts)
      map('n', 'n', [[<Cmd>lua require('hlslens').nNPeekWithUFO('n')<CR>zzzv]], opts)
      map('n', 'N', [[<Cmd>lua require('hlslens').nNPeekWithUFO('N')<CR>zzzv]], opts)
      map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
      map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
      map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
      map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)
    end
  },

  { "nvim-zh/colorful-winsep.nvim", config = true,      event = "WinNew", },

  {
    "SmiteshP/nvim-navic",
    lazy = true,
    dependencies = "neovim/nvim-lspconfig",
    opts = { separator = " ", highlight = true, depth_limit = 5 },
  },

  {
    "SmiteshP/nvim-navbuddy",
    lazy = true,
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim"
    },
    cmd = { "Navbuddy" },
    keys = { { "<leader>nb", "<Cmd>Navbuddy<CR>", desc = "Navbuddy" } },
    config = function()
      local navbuddy = require("nvim-navbuddy")
      navbuddy.setup {
        window = {
          border = "rounded",
        }
      }
    end
  },

  --------------------------------------------------------------------------------
  -- git
  --------------------------------------------------------------------------------
  -- use { 'rhysd/git-messenger.vim' }
  -- use {
  --   'tpope/vim-fugitive',
  --   config = function()
  --     -- vim.keymap.set('n', '<leader>gd', ':Gvdiff<CR>')
  --     vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')
  --     vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
  --     vim.keymap.set('n', '<leader>gps', ':Git push<CR>')
  --     vim.keymap.set('n', '<leader>gpu', ':Git pull<CR>')
  --     vim.keymap.set('n', '<leader>gr', ':GRemove<CR>')
  --     vim.keymap.set('n', '<leader>gs', ':Git<CR>')
  --     vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>')
  --   end
  -- }
  {
    'lewis6991/gitsigns.nvim',
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", lazy = true },
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 250,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
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
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },                                      -- Required
      { 'williamboman/mason.nvim',            build = ":MasonUpdate" }, -- Optional
      { 'williamboman/mason-lspconfig.nvim' },                          -- Optional

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
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
      { 'saadparwaiz1/cmp_luasnip' },
    }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    event = "BufReadPost",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre",      config = true },
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      { 'nvim-treesitter/playground',              cmd = "TSPlaygroundToggle" },
      'mrjones2014/nvim-ts-rainbow'
    },
    build = ':TSUpdateSync',
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
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
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
            goto_node = '<CR>',
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
  },

  -- use({
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --     -- Disable virtual_text since it's redundant due to lsp_lines.
  --     vim.diagnostic.config({
  --       virtual_text = false,
  --       update_in_insert = true,
  --     })
  --     vim.keymap.set("", "<leader>lt", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
  --   end,
  -- })

  { 'b0o/SchemaStore.nvim',         event = "VeryLazy" },
  { 'onsails/lspkind-nvim',         event = 'BufEnter', config = function() require('lspkind').init() end },

  --------------------------------------------------------------------------------
  -- debugging
  --------------------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        config = function()
          local dap, dapui = require("dap"), require("dapui")
          dapui.setup()
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end
      },
      {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
          require("nvim-dap-virtual-text").setup({
            enabled = true,
            all_references = true,
            all_frames = true,
          })
        end
      },
      {
        'mfussenegger/nvim-dap-python',
        ft = { "python" },
        build =
        "mkdir ~/.virtualenvs && cd ~/.virtualenvs && python3 -m venv debugpy && debugpy/bin/python -m pip install -U debugpy",
        config = function() require('dap-python').setup('~/.virtualenvs/debugpy/bin/python') end
      },
      {
        'leoluz/nvim-dap-go',
        ft = { "go" },
        -- build = "go install github.com/go-delve/delve/cmd/dlv@latest",
        build =
        "git clone https://github.com/go-delve/delve /tmp/delve && cd /tmp/delve && go install github.com/go-delve/delve/cmd/dlv && rm -rf /tmp/delve",
        config = true
      }
    },
    config = function()
      local sign = vim.fn.sign_define

      -- vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
      -- vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
      -- vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

      sign('DapBreakpoint', {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint'
      })
      sign('DapBreakpointCondition', {
        text = 'ﳁ',
        texthl = 'DapBreakpoint',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint'
      })
      sign('DapBreakpointRejected', {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint'
      })
      sign('DapLogPoint', {
        text = '',
        texthl = 'DapLogPoint',
        linehl = 'DapLogPoint',
        numhl = 'DapLogPoint'
      })
      sign('DapStopped', {
        text = '',
        texthl = 'DapStopped',
        linehl = 'DapStopped',
        numhl = 'DapStopped'
      })
    end
  },

  --------------------------------------------------------------------------------
  -- flutter
  --------------------------------------------------------------------------------
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
  },

  --------------------------------------------------------------------------------
  -- go
  --------------------------------------------------------------------------------
  -- use { 'buoto/gotests-vim', ft = { 'go' } }
  -- use { 'fatih/vim-go', ft = { 'go' }, build = ':GoInstallBinaries' }
  -- use { 'sebdah/vim-delve', ft = { 'go' } }
  {
    'ray-x/go.nvim',
    ft = { 'go' },
    dependencies = {
      { 'ray-x/guihua.lua', build = 'cd lua/fzy && make' },
      'folke/trouble.nvim',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      require('go').setup({
        lsp_cfg = false,
        lsp_gofumpt = true,
        trouble = true,
        luasnip = true,
      })
      -- autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
      -- vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.go', command = "GoFmt" })
      -- vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.go', command = "GoImport" })
      vim.api.nvim_create_autocmd('BufWritePre',
        { pattern = '*.go', command = "silent! lua require('go.format').goimport()" })
      vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'BufEnter' },
        { pattern = '*.go', command = "setlocal noexpandtab tabstop=4 shiftwidth=4" })
    end
  },

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
  --use { "anuvyklack/windows.nvim",
  --  dependencies = {
  --    "anuvyklack/middleclass",
  --    "anuvyklack/animation.nvim"
  --  },
  --  config = function()
  --    vim.o.winwidth = 10
  --    vim.o.winminwidth = 10
  --    vim.o.equalalways = false

  --    local function cmd(command)
  --      return table.concat({ '<Cmd>', command, '<CR>' })
  --    end

  --    vim.keymap.set('n', '<leader>wz', cmd 'WindowsMaximize')
  --    vim.keymap.set('n', '<leader>w-', cmd 'WindowsMaximizeVertically')
  --    vim.keymap.set('n', '<leader>w|', cmd 'WindowsMaximizeHorizontally')
  --    vim.keymap.set('n', '<leader>we', cmd 'WindowsEqualize')
  --    require('windows').setup()
  --  end
  --}

  {
    'anuvyklack/hydra.nvim',
    event = "VeryLazy",
    dependencies = 'anuvyklack/keymap-layer.nvim',
    config = function()
      local Hydra = require('hydra')
      local dap = require 'dap'

      local dap_hint = [[
 _n_: step over   _s_: Continue/Start   _b_: Breakpoint     _K_: Eval
 _i_: step into   _x_: Quit             ^ ^                 ^ ^
 _o_: step out    _X_: Stop             ^ ^
 _c_: to cursor   _C_: Close UI
 ^
 ^ ^              _q_: exit
]]

      local dap_hydra = Hydra({
        hint = dap_hint,
        config = {
          color = 'pink',
          invoke_on_body = true,
          hint = {
            position = 'bottom',
            border = 'rounded'
          },
        },
        name = 'dap',
        mode = { 'n', 'x' },
        body = '<leader>db',
        heads = {
          { 'n', dap.step_over,                                                      { silent = true } },
          { 'i', dap.step_into,                                                      { silent = true } },
          { 'o', dap.step_out,                                                       { silent = true } },
          { 'c', dap.run_to_cursor,                                                  { silent = true } },
          { 's', dap.continue,                                                       { silent = true } },
          { 'x', ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>",  { exit = true, silent = true } },
          { 'X', dap.close,                                                          { silent = true } },
          { 'C', ":lua require('dapui').close()<CR>:DapVirtualTextForceRefresh<CR>", { silent = true } },
          { 'b', dap.toggle_breakpoint,                                              { silent = true } },
          { 'K', ":lua require('dap.ui.widgets').hover()<CR>",                       { silent = true } },
          { 'q', nil,                                                                { exit = true, nowait = true } },
        }
      })
    end
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile" },
    keys = {
      { '<leader>E', ':NvimTreeToggle<CR>' },
      { '<leader>R', ':NvimTreeRefresh<CR>' },
      { '<leader>F', ':NvimTreeFindFile<CR>' },
    },
    config = function()
      require 'nvim-tree'.setup {
        reload_on_bufenter = true,
        respect_buf_cwd = true,
        view = {
          adaptive_size = true,
          width = 35,
          preserve_window_proportions = true,
          mappings = {
            list = {
              { key = "e", action = "create" },
              { key = "p", action = "paste" },
              { key = "x", action = "cut" },
              { key = "y", action = "copy" },
              { key = "K", action = "toggle_file_info" },
            },
          },
        },
        renderer = {
          add_trailing = true,
          group_empty = true,
          highlight_git = true,
          indent_markers = {
            enable = true,
          },
        },
        diagnostics = {
          enable = false,
          icons = {
            hint = " ",
            info = " ",
            warning = " ",
            error = " ",
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
      }
    end,
  },

  {
    'kevinhwang91/nvim-ufo',
    event = "BufReadPost",
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      require('ufo').setup({
        open_fold_hl_timeout = 150,
        close_fold_kinds = { 'imports', 'comment' },
        preview = {
          win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
            winblend = 0
          },
          mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>'
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
    'junegunn/vim-easy-align',
    event = "VeryLazy",
    config = function()
      vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')
      vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
    end
  },

  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<Cmd>TroubleToggle<CR>" },
      { "<leader>xw", "<Cmd>Trouble lsp_workspace_diagnostics<CR>" },
      { "<leader>xd", "<Cmd>Trouble lsp_document_diagnostics<CR>" },
      { "<leader>xl", "<Cmd>Trouble loclist<CR>" },
      { "<leader>xq", "<Cmd>Trouble quickfix<CR>" },
      { "gR",         "<Cmd>Trouble lsp_references<CR>" },
    },
    config = function()
      require('trouble').setup {
        position = "bottom",           -- position of the list can be: bottom, top, left, right
        height = 10,                   -- height of the trouble list when position is top or bottom
        width = 50,                    -- width of the list when position is left or right
        icons = true,                  -- use devicons for filenames
        mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "",             -- icon used for open folds
        fold_closed = "",           -- icon used for closed folds
        group = true,                  -- group results by file
        padding = true,                -- add an extra new line on top of the list
        action_keys = {
          -- key mappings for actions in the trouble list
          -- map to {} to remove a mapping, for example:
          -- close = {},
          close = "q",                     -- close the list
          cancel = "<esc>",                -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r",                   -- manually refresh
          jump = { "<CR>", "<tab>" },      -- jump to the diagnostic or open / close folds
          open_split = { "<c-x>" },        -- open buffer in new split
          open_vsplit = { "<c-v>" },       -- open buffer in new vsplit
          open_tab = { "<c-t>" },          -- open buffer in new tab
          jump_close = { "o" },            -- jump to the diagnostic and close the list
          toggle_mode = "m",               -- toggle between "workspace" and "document" diagnostics mode
          toggle_preview = "P",            -- toggle auto_preview
          hover = "K",                     -- opens a small popup with the full multiline message
          preview = "p",                   -- preview the diagnostic location
          close_folds = { "zM", "zm" },    -- close all folds
          open_folds = { "zR", "zr" },     -- open all folds
          toggle_fold = { "zA", "za" },    -- toggle fold of current file
          previous = "k",                  -- preview item
          next = "j"                       -- next item
        },
        indent_lines = true,               -- add an indent guide below the fold icons
        auto_open = false,                 -- automatically open the list when you have diagnostics
        auto_close = true,                 -- automatically close the list when you have no diagnostics
        auto_preview = true,               -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false,                 -- automatically fold a file trouble list at creation
        auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
        use_diagnostic_signs = true        -- enabling this will use the signs defined in your lsp client
      }
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      { "nvim-lua/plenary.nvim",                    lazy = true },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      -- { 'nvim-telescope/telescope-media-files.nvim', lazy = false }
    },
    config = function()
      require('telescope').setup({
        defaults = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--trim'
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          -- media_files = {
          --   -- filetypes whitelist
          --   -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          --   filetypes = { "png", "webp", "jpg", "jpeg" },
          --   find_cmd = "rg" -- find command (defaults to `fd`)
          -- }
        }
      })

      require('telescope').load_extension('fzf')
      -- require('telescope').load_extension('media_files')
    end,
    cmd = { "Telescope" },
    keys = {
      { '<leader>bf', '<Cmd>Telescope buffers<CR>' },
      { '<leader>ms', '<Cmd>Telescope marks<CR>' },
      { '<leader>rg', '<Cmd>Telescope live_grep<CR>' },
      { '<leader>ts', '<Cmd>Telescope tags<CR>' },
      { '<leader>bs', "<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>" },
      { '<leader>e',  "<Cmd>lua require('telescope.builtin').find_files({hidden=true})<CR>" },
      { '<leader>ca', '<Cmd>Telescope lsp_code_actions<CR>' },
      { '<leader>d',  '<Cmd>Telescope lsp_definitions<CR>zzzv' },
      { '<leader>i',  '<Cmd>Telescope lsp_implementations<CR>zzzv' },
      { '<leader>r',  '<Cmd>Telescope lsp_references<CR>zzzv' },
      { '<leader>td', '<Cmd>Telescope lsp_type_definitions<CR>' },
    },
  },

  {
    "ghillb/cybu.nvim",
    event = "VeryLazy",
    branch = "main",
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
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
  },

  {
    'windwp/nvim-ts-autotag',
    ft = {
      'glimmer',
      'handlebars',
      'hbs',
      'html',
      'javascript',
      'javascriptreact',
      'jsx',
      'markdown',
      'php',
      'rescript',
      'svelte',
      'tsx',
      'typescript',
      'typescriptreact',
      'vue',
      'xml',
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require 'nvim-treesitter.configs'.setup {
        autotag = {
          enable = true,
        }
      }
    end
  },

  --use {
  --  'ggandor/lightspeed.nvim',
  --  config = function()
  --    require 'lightspeed'.setup {
  --      jump_to_unique_chars = { safety_timeout = 400 },
  --      match_only_the_start_of_same_char_seqs = true,
  --      limit_ft_matches = 5,
  --    }
  --  end
  --}

  { "kylechui/nvim-surround", event = "VeryLazy", config = true },
  {
    'dhruvasagar/vim-table-mode',
    -- ft = { 'markdown' },
    cmd = { "TableModeToggle" },
    keys = { { "<leader>tm", "<Cmd>TableModeToggle<CR>", desc = "TableModeToggle" } },
  },
  {
    'dstein64/vim-startuptime',
    cmd = { "StartupTime" }
  },
  {
    'junegunn/fzf.vim',
    dependencies = 'junegunn/fzf',
    cmd = { "Lines", "Maps" },
    keys = { { "<leader>bls", "<Cmd>Lines<CR>" } },
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
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({ '*' }, {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true
      })
    end
  },
  {
    'rcarriga/nvim-notify',
    dependencies = "catppuccin",
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        background_colour = "#1E1E2E",
        fps = 60,
        icons = {
          DEBUG = "",
          ERROR = " ",
          INFO = " ",
          TRACE = "✎",
          WARN = " ",
        },
      })
      vim.notify = require("notify")
    end
  },
  {
    'simrat39/symbols-outline.nvim',
    cmd = { "SymbolsOutline" },
    config = true,
    keys = { { "<leader>so", "<Cmd>SymbolsOutline<CR>", desc = "SymbolsOutline" } },
  },
})
