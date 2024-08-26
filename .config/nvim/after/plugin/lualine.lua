-- Color for highlights
local colors = {
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98BE65',
  orange = '#FF8800',
  violet = '#A9A1E1',
  magenta = '#C678DD',
  blue = '#51AFEF',
  red = '#EC5F67'
}

-- Lsp server name
local function lsp_name()
  local msg = '  No Active Lsp'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_clients()
  if next(clients) == nil then return msg end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return ' ' .. client.name
    end
  end
  return msg
end

-- Mixed indent
-- Shows 'MI:line' in lualine when both tab and spaces are used for indenting current buffer.
local function mixed_indent()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end
  if not mixed then return '' end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return 'MI:' .. mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
  local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
  if space_indent_cnt > tab_indent_cnt then
    return 'MI:' .. tab_indent
  else
    return 'MI:' .. space_indent
  end
end

local lsp_symbols = require('lsp_symbols')

require 'lualine'.setup {
  options = {
    -- theme = 'gruvbox_dark',
    -- theme = 'wombat',
    theme = "catppuccin",
    icons_enabled = true,
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 500,
      tabline = 500,
      winbar = 500,
    }
  },
  sections = {
    lualine_a = {
      -- { 'mode', separator = { left = '' }, right_padding = 2 },
      { 'mode' },
    },
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        colored = true,
        update_in_insert = true,
        always_visible = false,
        symbols = {
          error = lsp_symbols.ERROR,
          warn = lsp_symbols.WARN,
          hint = lsp_symbols.HINT,
          info = lsp_symbols.INFO,
        },
      }
    },
    lualine_c = {
      {
        'filename',
        path = 1
      },
      'filesize',
      lsp_name,
      'lsp_progress',
    },
    lualine_x = {
      'encoding', 'fileformat', 'filetype'
    },
    lualine_y = { 'progress' },
    lualine_z = {
      mixed_indent,
      -- { 'location', separator = { right = '' }, left_padding = 2 },
      { 'location' },
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        colored = true,
        update_in_insert = true,
        always_visible = false,
        symbols = {
          error = lsp_symbols.ERROR,
          warn = lsp_symbols.WARN,
          hint = lsp_symbols.HINT,
          info = lsp_symbols.INFO,
        },
      }
    },
    lualine_c = {
      {
        'filename',
        path = 1
      },
      'filesize'
    },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {
    'fugitive',
    'fzf',
    'nvim-dap-ui',
    'nvim-tree',
    'quickfix',
    'symbols-outline',
  },
}
