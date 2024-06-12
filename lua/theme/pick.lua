local telescopePickers = require("telescope.pickers")
local telescopeFinders = require("telescope.finders")
local telescopeActions = require("telescope.actions")
local telescopeActionState = require("telescope.actions.state")
local telescopeConfig = require("telescope.config").values
local utils = require("core.utils")

local M = {}

local themes = {}
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/theme/schemes")) do
  table.insert(themes, vim.fn.fnamemodify(file, ":r"))
end
table.sort(themes)

M.setTheme = function(theme)
  vim.g.NvimTheme = theme
  require("theme").applyTerminalColors(theme)
  require("plenary.reload").reload_module("theme")
  require("theme").loadThemes()
  utils.replaceword(
    "vim.g.NvimTheme",
    '"' .. vim.g.NvimTheme .. '"',
    '"' .. theme .. '"'
  )
end

M.setup = function()
  telescopePickers
      .new({
        prompt_title = "  COLORSCHEMES",
        layout_config = { height = 0.50, width = 0.50 },
        finder = telescopeFinders.new_table({ results = themes }),
        sorter = telescopeConfig.generic_sorter(),
        attach_mappings = function(bufnr, map)
          vim.schedule(function()
            vim.api.nvim_create_autocmd("TextChangedI", {
              buffer = bufnr,
              callback = function()
                if telescopeActionState.get_selected_entry() then
                  M.setTheme(telescopeActionState.get_selected_entry()[1])
                end
              end,
            })
          end)
          map("i", "<CR>", function()
            M.setTheme(telescopeActionState.get_selected_entry()[1])
            telescopeActions.close(bufnr)
          end)

          map("i", "<Down>", function()
            telescopeActions.move_selection_next(bufnr)
            M.setTheme(telescopeActionState.get_selected_entry()[1])
          end)
          map("i", "<C-j>", function()
            telescopeActions.move_selection_next(bufnr)
            M.setTheme(telescopeActionState.get_selected_entry()[1])
          end)

          map("i", "<Up>", function()
            telescopeActions.move_selection_previous(bufnr)
            M.setTheme(telescopeActionState.get_selected_entry()[1])
          end)
          map("i", "<C-k>", function()
            telescopeActions.move_selection_previous(bufnr)
            M.setTheme(telescopeActionState.get_selected_entry()[1])
          end)
          return true
        end,
      })
      :find()
end

M.toggleTransparency = function()
  vim.g.transparency = not vim.g.transparency
  require("theme").loadThemes()
  utils.replaceword(
    "vim.g.transparency",
    tostring(not vim.g.transparency),
    tostring(vim.g.transparency)
  )
end

M.random = function()
  local random_index = math.random(1, #themes)
  local random_theme = themes[random_index]
  M.setTheme(random_theme)
end

return M
