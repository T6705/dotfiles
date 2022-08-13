local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require('cmp')
-- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
      --vim.fn["UltiSnips#Anon"](args.body)
    end
  },
  sources = {
    { name = 'path', priority_weight = 110 },
    { name = 'nvim_lsp', priority_weight = 100 },
    { name = 'nvim_lsp_signature_help', priority_weight = 95 },
    { name = 'nvim_lua', priority_weight = 90 },
    -- { name = 'ultisnips', priority_weight = 80 },
    { name = 'luasnip', priority_weight = 80 },
    { name = 'buffer', priority_weight = 70, max_item_count = 5, },
    { name = 'rg',
      priority_weight = 60,
      keyword_length = 5,
      max_item_count = 5,
      option = {
        additional_arguments = "--smart-case --hidden",
      },
    },
    { name = 'calc' },
    { name = 'emoji' },
  },
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
        rg = "[RG]",
      })[entry.source.name]
      return vim_item
    end
  },
  mapping = {
    -- ["<Tab>"] = cmp.mapping({
    --   c = function()
    --     if cmp.visible() then
    --       cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
    --     else
    --       cmp.complete()
    --     end
    --   end,
    --   i = function(fallback)
    --     if cmp.visible() then
    --       cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
    --     else
    --       cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
    --     end
    --   end,
    --   s = function(fallback)
    --     cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
    --   end
    -- }),
    -- ["<S-Tab>"] = cmp.mapping({
    --   c = function()
    --     if cmp.visible() then
    --       cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
    --     else
    --       cmp.complete()
    --     end
    --   end,
    --   i = function(fallback)
    --     if cmp.visible() then
    --       cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
    --     else
    --       cmp_ultisnips_mappings.jump_backwards(fallback)
    --     end
    --   end,
    --   s = function(fallback)
    --     cmp_ultisnips_mappings.jump_backwards(fallback)
    --   end
    -- }),
    -- ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
    -- ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-n>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),
    ['<C-p>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  window = {
    documentation = cmp.config.window.bordered(),
    completion = cmp.config.window.bordered(),
  },
  view = {
    entries = cmp.EntriesConfig,
  }
}

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  completion = { autocomplete = false },
  sources = {
    { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  completion = { autocomplete = false },
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- gray
vim.cmd('highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080')
-- blue
vim.cmd('highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6')
vim.cmd('highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6')
-- light blue
vim.cmd('highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE')
-- pink
vim.cmd('highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0')
vim.cmd('highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0')
-- front
vim.cmd('highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4')
vim.cmd('highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4')
vim.cmd('highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4')

require("luasnip.loaders.from_vscode").lazy_load()
