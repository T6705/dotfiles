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
  use { 'morhetz/gruvbox' }
  use { 'catppuccin/nvim', as = 'catppuccin', run = ":CatppuccinCompile",
    config = function()
      require("catppuccin").setup {
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
        term_colors = true,
        transparent_background = true,
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
          lightspeed = true,
          lsp_trouble = true,
          markdown = true,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          ts_rainbow = true,
          notify = true,
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
            colored_indent_levels = true,
          },
          barbar = false,
          dashboard = false,
          fern = false,
          gitgutter = false,
          hop = false,
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
    end
  }

  --------------------------------------------------------------------------------
  -- Interface
  --------------------------------------------------------------------------------
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
    tag = "v2.*",
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("bufferline").setup {
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
    'kevinhwang91/nvim-hlslens',
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
      map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zzzv]], opts)
      map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zzzv]], opts)
      map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
      map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
      map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
      map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)
    end
  }

  --------------------------------------------------------------------------------
  -- git
  --------------------------------------------------------------------------------
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
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
  }

  use { 'rhysd/git-messenger.vim' }
  use { 'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<CR>')
    end
  }

  use {
    'tpope/vim-fugitive',
    config = function()
      -- vim.keymap.set('n', '<leader>gd', ':Gvdiff<CR>')
      vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
      vim.keymap.set('n', '<leader>gps', ':Git push<CR>')
      vim.keymap.set('n', '<leader>gpu', ':Git pull<CR>')
      vim.keymap.set('n', '<leader>gr', ':GRemove<CR>')
      vim.keymap.set('n', '<leader>gs', ':Git<CR>')
      vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>')
    end
  }

  --------------------------------------------------------------------------------
  -- completions
  --------------------------------------------------------------------------------
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      -- { 'hrsh7th/cmp-calc' },
      -- { 'hrsh7th/cmp-emoji' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-path' },
      { 'lukas-reineke/cmp-rg' },
    },
    config = function() require 'config.nvim-cmp' end,
  }

  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'rafamadriz/friendly-snippets' }

  --use {
  --  'quangnguyen30192/cmp-nvim-ultisnips',
  --  config = function()
  --    require('cmp_nvim_ultisnips').setup {}
  --  end
  --}
  --use {
  --  'SirVer/ultisnips',
  --  requires = { { 'honza/vim-snippets', rtp = '.' } },
  --  config = function()
  --    vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
  --    vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
  --    vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
  --    vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
  --    vim.g.UltiSnipsRemoveSelectModeMappings = 0
  --  end
  --}

  --------------------------------------------------------------------------------
  -- lsp
  --------------------------------------------------------------------------------
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
  }

  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      -- Disable virtual_text since it's redundant due to lsp_lines.
      vim.diagnostic.config({
        virtual_text = false,
        update_in_insert = true,
      })
      vim.keymap.set("", "<leader>lt", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
    end,
  })

  use { 'b0o/SchemaStore.nvim' }
  use { 'onsails/lspkind-nvim', event = 'BufEnter', config = function() require('lspkind').init() end }
  use { 'neovim/nvim-lspconfig', config = function() require 'config.lspinstall' end }
  use { "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            fpackage_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end }
  use { "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "dockerls",
          "gopls",
          "jsonls",
          "pyright",
          "sumneko_lua",
          "tsserver",
          "yamlls",
        },
        automatic_installation = true,
      })
    end }


  --------------------------------------------------------------------------------
  -- debugging
  --------------------------------------------------------------------------------
  use { "mfussenegger/nvim-dap",
    requires = {
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
        run = "mkdir ~/.virtualenvs && cd ~/.virtualenvs && python3 -m venv debugpy && debugpy/bin/python -m pip install -U debugpy",
        config = function() require('dap-python').setup('~/.virtualenvs/debugpy/bin/python') end
      },
      {
        'leoluz/nvim-dap-go',
        -- run = "go install github.com/go-delve/delve/cmd/dlv@latest",
        run = "git clone https://github.com/go-delve/delve /tmp/delve && cd /tmp/delve && go install github.com/go-delve/delve/cmd/dlv && rm -rf /tmp/delve",
        config = function() require('dap-go').setup() end
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
  }

  --------------------------------------------------------------------------------
  -- go
  --------------------------------------------------------------------------------
  -- use { 'buoto/gotests-vim', ft = { 'go' } }
  -- use { 'fatih/vim-go', ft = { 'go' }, run = ':GoInstallBinaries' }
  -- use { 'sebdah/vim-delve', ft = { 'go' } }
  use { 'ray-x/go.nvim',
    ft = { 'go' },
    requires = 'ray-x/guihua.lua',
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

  }

  --------------------------------------------------------------------------------
  -- python
  --------------------------------------------------------------------------------
  use { 'psf/black',
    ft = { 'python' },
    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*.py", command = "Black" })
    end
  }

  --------------------------------------------------------------------------------
  -- other
  --------------------------------------------------------------------------------
  use { 'anuvyklack/hydra.nvim',
    requires = 'anuvyklack/keymap-layer.nvim',
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
          { 'n', dap.step_over, { silent = true } },
          { 'i', dap.step_into, { silent = true } },
          { 'o', dap.step_out, { silent = true } },
          { 'c', dap.run_to_cursor, { silent = true } },
          { 's', dap.continue, { silent = true } },
          { 'x', ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>", { exit = true, silent = true } },
          { 'X', dap.close, { silent = true } },
          { 'C', ":lua require('dapui').close()<CR>:DapVirtualTextForceRefresh<CR>", { silent = true } },
          { 'b', dap.toggle_breakpoint, { silent = true } },
          { 'K', ":lua require('dap.ui.widgets').hover()<CR>", { silent = true } },
          { 'q', nil, { exit = true, nowait = true } },
        }
      })
    end
  }

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

  use {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async',
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
          jump = { "<CR>", "<tab>" }, -- jump to the diagnostic or open / close folds
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
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>")
      vim.keymap.set("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<CR>")
      vim.keymap.set("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<CR>")
      vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<CR>")
      vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<CR>")
      vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<CR>")
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

  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end
  })

  use { 'dhruvasagar/vim-table-mode' }
  use { 'dstein64/vim-startuptime' }
  use { 'junegunn/fzf' }
  use { 'junegunn/fzf.vim', setup = [[require('config.fzf')]] }
  use { 'lewis6991/impatient.nvim' }
  use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
  use { 'rcarriga/nvim-notify', config = function() vim.notify = require("notify") end }
  use { 'simrat39/symbols-outline.nvim', setup = [[require('config.symbols-outline')]] }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    max_jobs = 8, -- Limit the number of simultaneous jobs. nil means no limit
    auto_reload_compiled = true,
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
