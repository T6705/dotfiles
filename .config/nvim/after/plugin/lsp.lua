local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, silent = true, noremap = true }

  vim.keymap.set('n', '<leader>D', function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format({ async = true }) end, opts)
  vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<leader>wa', function() vim.lsp.buf.add_workspace_folder() end, opts)
  vim.keymap.set('n', '<leader>wf', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  vim.keymap.set('n', '<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<leader>of', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
  -- vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
  -- vim.keymap.set('n', '<space>d', function() vim.lsp.buf.definition() end, opts)
  -- vim.keymap.set('n', '<space>i', function() vim.lsp.buf.implementation() end, opts)
  -- vim.keymap.set('n', '<space>r', function() vim.lsp.buf.references() end, opts)
  -- vim.keymap.set('n', '<space>td', function() vim.lsp.buf.type_definition() end, opts)

  -- Format the current buffer using the active language servers.
  lsp_zero.buffer_autoformat()
end)

require('flutter-tools').setup({
  lsp = {
    capabilities = lsp_zero.capabilities
  }
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = true,
})


local lsp_symbols = require('lsp_symbols')
lsp_zero.set_sign_icons({
  error = lsp_symbols.ERROR,
  warn = lsp_symbols.WARN,
  hint = lsp_symbols.HINT,
  info = lsp_symbols.INFO,
})

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
    "delve",
    "gofumpt",
    "goimports",
    "golangci-lint",
    "gomodifytags",
    "impl",
    "php-cs-fixer",
    "prettier",
    "revive",
    "shellcheck",
    "shfmt",
    "staticcheck",
  }
}

require("mason-lspconfig").setup {
  ensure_installed = {
    "bashls",
    "clangd",
    "docker_compose_language_service",
    "dockerls",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "tsserver",
    "yamlls",
  },

  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            hint = {
              enable = true,
            },
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Setup your lua path
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              -- Fix Undefined global 'vim'
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
              },
            },
          }
        },
        on_init = function(client)
          local uv = vim.uv or vim.loop
          local path = client.workspace_folders[1].name

          -- Don't do anything if there is a project local config
          if uv.fs_stat(path .. '/.luarc.json')
              or uv.fs_stat(path .. '/.luarc.jsonc')
          then
            return
          end

          -- Apply neovim specific settings
          local lua_opts = lsp_zero.nvim_lua_ls()

          client.config.settings.Lua = vim.tbl_deep_extend(
            'force',
            client.config.settings.Lua,
            lua_opts.settings.Lua
          )
        end,
      })
    end,

    gopls = function()
      require('lspconfig').gopls.setup({
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
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              shadow = true,
              unusedparams = true,
              unusedvariable = true,
              unusedwrite = true,
              useany = true,
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
      })
    end,

    pyright = function()
      require('lspconfig').pyright.setup({
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
      })
    end,

    jsonls = function()
      require('lspconfig').yamlls.setup({
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
    end,

    yamlls = function()
      require('lspconfig').jsonls.setup({
        settings = {
          yaml = {
            hover = true,
            completion = true,
            validate = true,
            schemas = require("schemastore").json.schemas(),
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
          },
        }
      })
    end,

  },
}
