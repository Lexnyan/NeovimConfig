-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#E06C75' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#E5C07B' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#61AFEF' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#D19A66' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#98C379' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#C678DD' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#56B6C2' })

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    vim = rainbow_delimiters.strategy['local'],
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  priority = {
    [''] = 110,
    lua = 210,
  },
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
}
