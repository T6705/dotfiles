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
          blink_cmp = true,
          dropbar = {
            enabled = true,
            color_mode = true, -- enable color for kind's texts, not just kind's icons
          },
          gitsigns = true,
          lsp_trouble = true,
          markdown = true,
          mason = true,
          nvim_surround = true,
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
              ok = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
              ok = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
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
        highlights = require("catppuccin.special.bufferline").get_theme(),
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
    enabled = not vim.g.neovide, -- Disable if Neovide is detected
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


  --------------------------------------------------------------------------------
  -- lsp
  --------------------------------------------------------------------------------
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'folke/lazydev.nvim', ft = 'lua', opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } }, }, } },
      {
        "MysticalDevil/inlay-hints.nvim",
        event = "LspAttach",
        config = function()
          require("inlay-hints").setup()
        end
      },
      {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000,    -- needs to be loaded in first
        config = function()
          require("tiny-inline-diagnostic").setup({
            options = {
              multilines = {
                enabled = false,
              },
              show_source = {
                enabled = true,
              },
            },
          })
          vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
        end
      },
      {
        'saghen/blink.indent',
        --- @module 'blink.indent'
        --- @type blink.indent.Config
        -- opts = {},
      },
      {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = {
          {
            "saghen/blink.compat",
            optional = true, -- make optional so it's only enabled if any extras need it
            opts = {},
            version = "*",
          },
          { "mikavilpas/blink-ripgrep.nvim" },
          {
            'L3MON4D3/LuaSnip',
            version = "v2.*",
            build = "make install_jsregexp",
            enabled = vim.fn.executable("make") == 1,
            opts = { history = true, delete_check_events = "TextChanged" },
            dependencies = { "rafamadriz/friendly-snippets" },
          },
          {
            "nvim-mini/mini.icons",
            lazy = true,
            opts = {
              file = {
                [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
              },
              filetype = {
                dotenv = { glyph = "", hl = "MiniIconsYellow" },
              },
            },
            init = function()
              package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
              end
            end,
          },
        },

        version = '1.*',
        --build = 'cargo build --release',
        event = "InsertEnter",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
          keymap = { preset = 'enter' },
          appearance = { nerd_font_variant = 'mono' },
          completion = {
            menu = {
              border = 'single',
              draw = {
                treesitter = { "lsp" },
                columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
                components = {
                  kind_icon = {
                    text = function(ctx)
                      local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                      return kind_icon
                    end,
                    -- (optional) use highlights from mini.icons
                    highlight = function(ctx)
                      local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                      return hl
                    end,
                  },
                  kind = {
                    -- (optional) use highlights from mini.icons
                    highlight = function(ctx)
                      local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                      return hl
                    end,
                  }
                }
              }
            },
            documentation = {
              auto_show = true,
              auto_show_delay_ms = 500,
              window = { border = 'single' },
            }
          },
          snippets = { preset = 'luasnip' },
          cmdline = {
            enabled = true,
            completion = { menu = { auto_show = true } }
          },
          sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer", "ripgrep" },
            providers = {
              lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
              },
              path = {
                score_offset = 110,
                opts = { show_hidden_files_by_default = true }
              },
              lsp = { score_offset = 90, },
              snippets = { score_offset = 80, },
              buffer = { score_offset = 70, },
              ripgrep = {
                module = "blink-ripgrep",
                name = "Ripgrep",
                ---@module "blink-ripgrep"
                ---@type blink-ripgrep.Options
                score_offset = 70,
                opts = {},
              },
            },
          },
          fuzzy = {
            implementation = "prefer_rust_with_warning",
            sorts = { 'score' }
          },
          signature = {
            enabled = true,
            window = { border = 'single' }
          },
        },
        opts_extend = {
          "sources.completion.enabled_providers",
          "sources.compat",
          "sources.default",
        }
      },
    },
    config = function()
      local lsp_symbols = require('lsp_symbols')
      vim.diagnostic.config({
        virtual_text = false, -- https://github.com/rachartier/tiny-inline-diagnostic.nvim
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = lsp_symbols.ERROR,
            [vim.diagnostic.severity.WARN] = lsp_symbols.WARN,
            [vim.diagnostic.severity.HINT] = lsp_symbols.HINT,
            [vim.diagnostic.severity.INFO] = lsp_symbols.INFO,
          }
        }
      })

      local servers = {
        bashls = {
          filetypes = { "sh", "zsh" },
        },
        clangd = {},
        cssls = {},
        docker_compose_language_service = {},
        dockerls = {},
        groovyls = {},
        html = {},
        marksman = {},
        rust_analyzer = {},
        ts_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              telemetry = { enable = false },
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";"),
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
              },
              codeLens = { enable = true, },
              completion = { callSnippet = "Replace", },
              doc = { privateName = { "^_" }, },
              diagnostics = {
                -- Fix Undefined global 'vim'
                globals = { "vim" },
                disable = { 'missing-fields' }
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              codelenses = {
                gc_details = true,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = true,
                functionTypeParameters = false,
                parameterNames = true,
                rangeVariableTypes = false,
              },
              analyses = {
                appends = true,
                asmdecl = true,
                assign = true,
                atomic = true,
                atomicalign = true,
                bools = true,
                buildtag = true,
                cgocall = true,
                composites = true,
                copylocks = true,
                deepequalerrors = true,
                defers = true,
                deprecated = true,
                directive = true,
                embed = true,
                errorsas = true,
                fillreturns = true,
                framepointer = true,
                hostport = true,
                httpresponse = true,
                ifaceassert = true,
                infertypeargs = true,
                loopclosure = true,
                lostcancel = true,
                modernize = true,
                nilfunc = true,
                nilness = true,
                nonewvars = true,
                noresultvalues = true,
                printf = true,
                shadow = true,
                shift = true,
                sigchanyzer = true,
                simplifycompositelit = true,
                simplifyrange = true,
                simplifyslice = true,
                slog = true,
                sortslice = true,
                stdmethods = true,
                stdversion = true,
                stringintconv = true,
                structtag = true,
                testinggoroutine = true,
                tests = true,
                timeformat = true,
                unmarshal = true,
                unreachable = true,
                unsafeptr = true,
                unusedfunc = true,
                unusedparams = true,
                unusedresult = true,
                unusedvariable = true,
                unusedwrite = true,
                waitgroup = true,
                yield = true
              },
              completeUnimported = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              experimentalPostfixCompletions = true,
              gofumpt = true,
              semanticTokens = true,
              staticcheck = true,
              usePlaceholders = true,
            },
          }
        },
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
        },
        pyright = {
          single_file_support = true,
          settings = {
            pyright = {
              disableLanguageServices = false,
              disableOrganizeImports = false
            },
            python = {
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace", -- openFilesOnly, workspace
                typeCheckingMode = "strict",  -- off, basic, strict
                useLibraryCodeForTypes = true
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
              hover = true,
              completion = true,
              format = { enable = true },
              validate = true,
              schemas = require("schemastore").json.schemas(),
              schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
            },
          }
        },
        jsonls = {
          -- lazy-load schemastore when needed
          before_init = function(_, new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})

      require('mason').setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            fpackage_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
      require('mason-tool-installer').setup {
        ensure_installed = {
          "black",
          "clang-format",
          "delve",
          "gofumpt",
          "goimports",
          "golangci-lint",
          "gomodifytags",
          "hadolint",
          "impl",
          "markdownlint-cli2",
          "npm-groovy-lint",
          "php-cs-fixer",
          "phpcs",
          "prettier",
          "pyright",
          "revive",
          "ruff",
          "shellcheck",
          "shfmt",
          "staticcheck",
        }
      }
      require('mason-lspconfig').setup({
        ensure_installed = ensure_installed
      })

      for server, settings in pairs(servers) do
        vim.lsp.config(server, settings)
        vim.lsp.enable(server)
      end

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
        opts = {
          enable = true,            -- Enable this plugin
          max_lines = 3,            -- How many lines the window should span
          min_window_height = 15,   -- Only show context if window is tall enough
          line_numbers = true,
          multiline_threshold = 20, -- Max lines to show for a single context
          trim_scope = "outer",     -- Which context lines to discard if max_lines exceeded
          mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
        },
        keys = {
          { "[c", function() require("treesitter-context").go_to_context() end, desc = "Jump to context" },
        },
      },
    },
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter'.setup {
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "diff",
          "dockerfile",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "groovy",
          "groovydoc",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "json5",
          "jsonc",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "ninja",
          "norg",
          "printf",
          "python",
          "query",
          "regex",
          "rst",
          "scss",
          "svelte",
          "toml",
          "tsx",
          "typescript",
          "typst",
          "vim",
          "vimdoc",
          "vue",
          "xml",
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
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
      }
    end,
  },

  { 'b0o/SchemaStore.nvim', event = "VeryLazy" },

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
  -- lang
  --------------------------------------------------------------------------------
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    config = function()
      require('lint').linters_by_ft = {
        dockerfile = { "hadolint" },
        go = { "golangcilint" },
        markdown = { "markdownlint-cli2" },
        php = { "phpcs" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          -- try_lint without arguments runs the linters defined in `linters_by_ft`
          -- for the current filetype
          require("lint").try_lint()
        end,
      })
    end
  },
  {
    'stevearc/conform.nvim',
    dependencies = { "mason.nvim" },
    lazy = true,
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 5000,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          c = { "clang-format" },
          cpp = { "clang-format" },
          go = { "goimports", "gofumpt" },
          groovy = { "npm_groovy_lint" },
          html = { "prettier" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
          php = { "php_cs_fixer" },
          python = { "isort", "black" },
          sh = { "shellcheck", "shfmt" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          yaml = { "prettier" },
        },
        formatters = {
          ["clang-format"] = {
            prepend_args = { "-style=file", "-fallback-style=LLVM" },
          },
        },
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end
  },

  --------------------------------------------------------------------------------
  -- other
  --------------------------------------------------------------------------------
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
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
        --- options for snacks picker
        ---@type snacks.picker.Config
        snacks = {
          layout = { preset = "default" },
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
    priority = 49,
    ft = { 'markdown', 'typst' },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
      "saghen/blink.cmp",
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
    "ptdewey/yankbank-nvim",
    config = function()
      require('yankbank').setup()
    end,
    keys = { { "<leader>Y", "<Cmd>YankBank<CR>" } },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile      = { enabled = true, size = 5 * 1024 * 1024, },
      explorer     = { enabled = true },
      gitbrowse    = { enabled = true },
      image        = { enabled = true },
      indent       = { enabled = false },
      input        = { enabled = true },
      lazygit      = { enabled = true },
      notifier     = { enabled = true, timeout = 3000 },
      notify       = { enabled = true },
      picker       = {
        enabled = true,
        previewers = {
          file = {
            max_size = 5 * 1024 * 1024,
          },
        },
      },
      quickfile    = { enabled = true },
      rename       = { enabled = true },
      scope        = { enabled = true },
      scroll       = { enabled = not vim.g.neovide },
      statuscolumn = { enabled = true },
      words        = { enabled = true },
    },
    keys = {
      { "<leader>sa",  function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
      { "<leader>un",  function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
      { "<leader>rf",  function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
      { "]]",          function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
      { "[[",          function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
      { "<leader>:",   function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>e",   function() Snacks.picker.files({ hidden = true, }) end,                 desc = "Find Files" },
      { "<leader>E",   function() Snacks.explorer() end,                                       desc = "File Explorer" },
      ---- find
      { "<leader>fb",  function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>fc",  function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>fg",  function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
      { "<leader>fp",  function() Snacks.picker.projects() end,                                desc = "Projects" },
      { "<leader>fr",  function() Snacks.picker.recent() end,                                  desc = "Recent" },
      ---- git
      { "<leader>gb",  function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
      { "<leader>gB",  function() Snacks.gitbrowse() end,                                      desc = "Git Browse" },
      { "<leader>gd",  function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
      { "<leader>gf",  function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
      { "<leader>gg",  function() Snacks.lazygit() end,                                        desc = "Lazygit" },
      { "<leader>gl",  function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
      { "<leader>gL",  function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
      { "<leader>gs",  function() Snacks.picker.git_status() end,                              desc = "Git Status" },
      { "<leader>gS",  function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
      { "<leader>lgl", function() Snacks.lazygit.log() end,                                    desc = "Lazygit Log (cwd)" },
      ---- Grep
      { "<leader>sl",  function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sb",  function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
      { "<leader>sg",  function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>sw",  function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
      ---- search
      { "<leader>sD",  function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
      { "<leader>sc",  function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
      { "<leader>sd",  function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
      { "<leader>si",  function() Snacks.picker.icons() end,                                   desc = "Icons" },
      { "<leader>sk",  function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      { "<leader>sm",  function() Snacks.picker.marks() end,                                   desc = "Marks" },
      { "<leader>su",  function() Snacks.picker.undo() end,                                    desc = "Undo History" },
      ---- LSP
      { "<leader>d",   function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
      { "<leader>D",   function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
      { "<leader>r",   function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
      { "<leader>i",   function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
      { "<leader>td",  function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
      { "<leader>so",  function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
      { "gai",         function() Snacks.picker.lsp_incoming_calls() end,                      desc = "C[a]lls Incoming" },
      { "gao",         function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "C[a]lls Outgoing" },
    }
  },
})
