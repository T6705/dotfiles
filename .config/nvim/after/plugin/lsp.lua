local lsp = require("lsp-zero")
local navbuddy = require("nvim-navbuddy")

require('mason.settings').set({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      fpackage_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

lsp.preset("recommended")

lsp.ensure_installed({
  'clangd',
  'dockerls',
  'gopls',
  'jsonls',
  'lua_ls',
  'pyright',
  'rust_analyzer',
  'tsserver',
  'yamlls',
})

lsp.configure('gopls', {
  settings = {
    gopls = {
      codelenses = {
        gc_details = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
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
      experimentalPostfixCompletions = true,
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  }
})
lsp.configure('jsonls', {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      schemas = require("schemastore").json.schemas(),
    },
  }
})
lsp.configure('yamlls', {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  }
})
lsp.configure('lua_ls', {
  settings = {
    Lua = {
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
  }
})

lsp.set_preferences({
  manage_nvim_cmp = false,
  set_lsp_keymaps = false,
  suggest_lsp_servers = false,
  sign_icons = {
    --error = " ",
    --error = 'E',
    --hint = " ",
    --hint = 'H',
    --info = " "
    --info = 'I'
    --warn = " ",
    --warn = 'W',
    error = " ",
    hint = " ",
    info = " ",
    warn = " ",
  }
})

lsp.on_attach(function(client, bufnr)
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
  -- vim.keymap.set('n', '<space>ca', function() vim.lsp.buf.code_action() end, opts)
  -- vim.keymap.set('n', '<space>d', function() vim.lsp.buf.definition() end, opts)
  -- vim.keymap.set('n', '<space>i', function() vim.lsp.buf.implementation() end, opts)
  -- vim.keymap.set('n', '<space>r', function() vim.lsp.buf.references() end, opts)
  -- vim.keymap.set('n', '<space>td', function() vim.lsp.buf.type_definition() end, opts)

  navbuddy.attach(client, bufnr)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = true,
})
