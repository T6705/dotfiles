-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- --Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<space>fm', '<cmd>lua vim.lsp.buf.format({async=true})<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>of', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>td', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.document_formatting then
    buf_set_keymap("n", "<space>fm", "<cmd>lua vim.lsp.buf.format({async=true})<CR>", opts)
  elseif client.server_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>fm", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec([[
     augroup lsp_document_highlight
     autocmd! * <buffer>
     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
     augroup END
     ]], false)
  end

  -- -- lsp_signature.nvim
  -- require "lsp_signature".on_attach({
  --   bind = true, -- This is mandatory, otherwise border config won't get registered.
  --   handler_opts = {
  --     border = "rounded"
  --   }
  -- }, bufnr)
end

-- config that activates keymaps and enables snippet support
local function make_config()
  -- use LSP snippet
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  capabilities.textDocument.completion.completionItem = {
    commitCharactersSupport = true,
    deprecatedSupport = true,
    documentationFormat = { "markdown", "plaintext" },
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    preselectSupport = true,
    snippetSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      }
    },
  }
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,

    flags = {
      debounce_text_changes = 150,
    },
  }
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- virtual_text = {
  --   prefix = "",
  --   spacing = 0,
  -- },
  virtual_text = false,
  float = { border = "single" },
  signs = true,
  underline = true,
  -- set this to true if you want diagnostics to show in insert mode
  update_in_insert = true,
})
-- Show line diagnostics automatically in hover window
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]

local lspconfig = require('lspconfig')
require("mason-lspconfig").setup_handlers({
  function(server_name)
    local opts = {}
    require("lspconfig")[server_name].setup(opts)
  end,
  ["gopls"] = function()
    local config = make_config()
    config["settings"] = {
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
    lspconfig.gopls.setup(config)
  end,
  ["jsonls"] = function()
    local config = make_config()
    config["settings"] = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    }
    lspconfig.jsonls.setup(config)
  end,
  ["sumneko_lua"] = function()
    local config = make_config()
    config["settings"] = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
        },
      },
    }
    lspconfig.sumneko_lua.setup(config)
  end,
  ["tsserver"] = function()
    local config = make_config()
    lspconfig.tsserver.setup(config)
  end,
  ["yamlls"] = function()
    local config = make_config()
    config["settings"] = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
        schemas = require("schemastore").json.schemas(),
      },
    }
    lspconfig.yamlls.setup(config)
  end,
})
