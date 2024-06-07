local M = {}

M.notify = function()
  require("notify").setup({
    level = 2,
    minimum_width = 50,
    render = "minimal",
    stages = "fade",
    timeout = 2000,
    top_down = true,
    background_colour = "#000000",
  })
end

M.dressing = function()
  require("dressing").setup({
    input = {
      enabled = true,
      default_prompt = "➤ ",
      win_options = {
        winblend = 10,
      },
    },
    select = {
      enabled = true,
      backend = { "telescope", "buildtin" },
      buildtin = {
        win_options = {
          winbled = 0,
        },
      },
    },
  })
end


M.nerdcommenter = function()
  vim.g.NERDSpaceDelims = 1
  vim.g.NERDCompactSexyComs = 1
  vim.g.NERDDefaultAlign = "left"
  vim.g.NERDAltDelims_java = 1
  vim.g.NERDCustomDelimiters = { c = { left = "/**", right = "*/" } }
  vim.g.NERDCommentEmptyLines = 1
  vim.g.NERDTrimTrailingWhitespace = 1
  vim.g.NERDToggleCheckAllLines = 1
end

return M
