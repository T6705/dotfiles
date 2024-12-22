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
          lsp_trouble = true,
          mason = true,
          notify = true,
          symbols_outline = true,
          treesitter_context = true,
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

  --{
  --  'lukas-reineke/indent-blankline.nvim',
  --  main = "ibl",
  --  ---@module "ibl"
  --  ---@type ibl.config
  --  opts = {},
  --  event = { "BufReadPost", "BufNewFile" },
  --  config = function()
  --    require('ibl').setup()
  --  end,
  --},

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
    'kevinhwang91/nvim-hlslens',
    event = "VeryLazy",
    config = function()
      require('hlslens').setup({
        override_lens = function(render, posList, nearest, idx, relIdx)
          local sfw = vim.v.searchforward == 1
          local indicator, text, chunks
          local absRelIdx = math.abs(relIdx)
          if absRelIdx > 1 then
            indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or
              '▼')
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

  {
    'mcauley-penney/visual-whitespace.nvim',
    keys = {
      { "<leader>vw", '<Cmd>lua require("visual-whitespace").toggle()<CR>' },
    },
  },

  { "nvim-zh/colorful-winsep.nvim", config = true,                          event = { "WinNew" }, },
  { 'Bekaboo/dropbar.nvim',         event = { "BufReadPre", "BufNewFile" }, },

  --------------------------------------------------------------------------------
  -- git
  --------------------------------------------------------------------------------
  -- use { 'rhysd/git-messenger.vim' }
  -- use {
  --   'tpope/vim-fugitive',
  --   config = function()
  --     -- vim.keymap.set('n', '<leader>gd', '<Cmd>Gvdiff<CR>')
  --     vim.keymap.set('n', '<leader>gb', '<Cmd>Git blame<CR>')
  --     vim.keymap.set('n', '<leader>gc', '<Cmd>Git commit<CR>')
  --     vim.keymap.set('n', '<leader>gps', '<Cmd>Git push<CR>')
  --     vim.keymap.set('n', '<leader>gpu', '<Cmd>Git pull<CR>')
  --     vim.keymap.set('n', '<leader>gr', '<Cmd>GRemove<CR>')
  --     vim.keymap.set('n', '<leader>gs', '<Cmd>Git<CR>')
  --     vim.keymap.set('n', '<leader>gw', '<Cmd>Gwrite<CR>')
  --   end
  -- }
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
          map("n", "<leader>sb", gs.stage_buffer, "Stage Buffer")
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

  {
    "FabijanZulj/blame.nvim",
    cmd = { "BlameToggle" },
    config = function()
      require('blame').setup({})
    end,
    keys = {
      { "<leader>gb", "<Cmd>BlameToggle virtual<CR>", desc = "blame shown in a virtual text floated to the right" } },
  },

  --------------------------------------------------------------------------------
  -- lsp
  --------------------------------------------------------------------------------
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
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
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000,    -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup({
        options = {
          multilines = true,
          show_source = true,
          use_icons_from_diagnostic = true,
        }
      })
    end
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
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile" },
    keys = {
      { '<leader>E', '<Cmd>NvimTreeToggle<CR>' },
      { '<leader>R', '<Cmd>NvimTreeRefresh<CR>' },
      { '<leader>F', '<Cmd>NvimTreeFindFile<CR>' },
    },
    config = function()
      -- Automatically open file upon creation
      local api = require("nvim-tree.api")
      api.events.subscribe(api.events.Event.FileCreated, function(file)
        vim.cmd("edit " .. file.fname)
      end)

      -- https://github.com/folke/snacks.nvim/blob/main/docs/rename.md
      local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
      vim.api.nvim_create_autocmd("User", {
        pattern = "NvimTreeSetup",
        callback = function()
          local events = require("nvim-tree.api").events
          events.subscribe(events.Event.NodeRenamed, function(data)
            if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
              data = data
              Snacks.rename.on_rename_file(data.old_name, data.new_name)
            end
          end)
        end,
      })

      local lsp_symbols = require("lsp_symbols")
      require("nvim-tree").setup({
        hijack_cursor = true,
        reload_on_bufenter = true,
        respect_buf_cwd = true,
        sync_root_with_cwd = true,
        filters = {
          custom = {
            "^.git$",
          },
        },
        view = {
          adaptive_size = true,
          width = 35,
          preserve_window_proportions = true,
        },
        renderer = {
          add_trailing = true,
          full_name = true,
          group_empty = true,
          highlight_git = true,
          indent_markers = {
            enable = true,
          },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = lsp_symbols.HINT,
            info = lsp_symbols.INFO,
            warning = lsp_symbols.WARN,
            error = lsp_symbols.ERROR,
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
      })
    end,
  },

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
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
      { "nvim-lua/plenary.nvim",                  lazy = true },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
        enabled =
            vim.fn.executable("cmake") == 1,
      },
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
          ["ui-select"] = {
            require("telescope.themes").get_dropdown()
          },
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

      require("telescope").load_extension("ui-select")
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
      { '<leader>d',  '<Cmd>Telescope lsp_definitions<CR>zzzv' },
      { '<leader>i',  '<Cmd>Telescope lsp_implementations<CR>zzzv' },
      { '<leader>r',  '<Cmd>Telescope lsp_references<CR>zzzv' },
      { '<leader>td', '<Cmd>Telescope lsp_type_definitions<CR>' },
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
    'windwp/nvim-ts-autotag',
    event = "InsertEnter",
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

  {
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
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
  -- {
  --   'rcarriga/nvim-notify',
  --   dependencies = "catppuccin",
  --   event = "VeryLazy",
  --   keys = { {
  --     "<leader>un",
  --     function()
  --       require("notify").dismiss({ silent = true, pending = true })
  --     end,
  --     desc = "Dismiss all Notification"
  --   } },
  --   config = function()
  --     local lsp_symbols = require("lsp_symbols")
  --     require("notify").setup({
  --       timeout = 3000,
  --       icons = {
  --         DEBUG = lsp_symbols.DEBUG,
  --         TRACE = lsp_symbols.TRACE,
  --         ERROR = lsp_symbols.ERROR,
  --         WARN = lsp_symbols.WARN,
  --         HINT = lsp_symbols.HINT,
  --         INFO = lsp_symbols.INFO,
  --       },
  --       max_height = function()
  --         return math.floor(vim.o.lines * 0.75)
  --       end,
  --       max_width = function()
  --         return math.floor(vim.o.columns * 0.75)
  --       end,
  --       on_open = function(win)
  --         vim.api.nvim_win_set_config(win, { zindex = 100 })
  --       end,
  --     })
  --     vim.notify = require("notify")
  --   end
  -- },
  {
    'simrat39/symbols-outline.nvim',
    cmd = { "SymbolsOutline" },
    config = true,
    keys = { { "<leader>so", "<Cmd>SymbolsOutline<CR>", desc = "SymbolsOutline" } },
  },
  {
    'nacro90/numb.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    config = true,
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
    dependencies = "kkharji/sqlite.lua",
    config = function()
      require('yankbank').setup({
        persist_type = "sqlite",
      })
    end,
    keys = { { "<leader>Y", "<Cmd>YankBank<CR>" } },
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile      = { enabled = false },
      bfdelete     = { enabled = false },
      dashboard    = { enabled = false },
      debug        = { enabled = false },
      dim          = { enabled = false },
      git          = { enabled = false },
      gitbrowse    = { enabled = true },
      indent       = { enabled = true },
      input        = { enabled = true },
      lazygit      = { enabled = true },
      notifier     = { enabled = true, timeout = 3000 },
      notify       = { enabled = true },
      profiler     = { enabled = false },
      quickfile    = { enabled = true },
      rename       = { enabled = true },
      scope        = { enabled = true },
      scratch      = { enabled = false },
      scroll       = { enabled = true },
      statuscolumn = { enabled = true },
      terminal     = { enabled = false },
      toggle       = { enabled = false },
      win          = { enabled = false },
      words        = { enabled = true },
      zen          = { enabled = false },
    },
    keys = {
      { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
      { "<leader>rf", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
    }
  }
})
