local M = {}

M.getCurrentTheme = function()
  local defaultThemeAvailable, defaultTheme = pcall(require, "theme.schemes." .. vim.g.NvimTheme)
  if defaultThemeAvailable then
    return defaultTheme
  else
    print("Not select theme")
  end
end

M.loadThemeTable = function(themeName)
  local themeTable = require("theme.integrations." .. themeName)
  return themeTable
end

local merge_tables = function(...)
  return vim.tbl_deep_extend("force", ...)
end

local tableToStr = function(highlightGroups)
  local result = ""
  if vim.g.transparency then
    local transparencyTheme = require("theme.transparency")
    for key, transparencyValues in pairs(transparencyTheme) do
      if highlightGroups[key] then
        highlightGroups[key] = merge_tables(highlightGroups[key], transparencyValues)
      end
    end
  end
  for groupName, groupValues in pairs(highlightGroups) do
    local groupNameStr = "'" .. groupName .. "',"
    local options = ""
    for optionName, optionValue in pairs(groupValues) do
      local valueStr = ((type(optionValue)) == "boolean" or type(optionValue) == "number") and tostring(optionValue)
          or '"' .. optionValue .. '"'
      options = options .. optionName .. "=" .. valueStr .. ","
    end
    result = result .. "vim.api.nvim_set_hl(0," .. groupNameStr .. "{" .. options .. "})"
  end
  return result
end

local serializeTableToCache = function(fileName, tableData)
  local serializedFunction = "return string.dump(function()" .. tableToStr(tableData) .. "end, true)"
  local file = io.open(vim.g.themeCache .. fileName, "wb")
  if file then
    ---@diagnostic disable-next-line: deprecated
    file:write(loadstring(serializedFunction)())
    file:close()
  end
end

local compileThemes = function()
  if not vim.loop.fs_stat(vim.g.themeCache) then
    vim.fn.mkdir(vim.g.themeCache, "p")
  end

  local allThemes = {}
  for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/theme/integrations")) do
    for key, themeData in pairs(M.loadThemeTable(vim.fn.fnamemodify(file, ":r"))) do
      allThemes[key] = themeData
    end
  end

  serializeTableToCache("allThemes", allThemes)
end

M.loadThemes = function()
  compileThemes()
  dofile(vim.g.themeCache .. "allThemes")
end

M.applyTerminalColors = function(colorScheme)
  vim.g.terminal_color_0 = colorScheme.base01
  vim.g.terminal_color_1 = colorScheme.base08
  vim.g.terminal_color_2 = colorScheme.base0B
  vim.g.terminal_color_3 = colorScheme.base0A
  vim.g.terminal_color_4 = colorScheme.base0D
  vim.g.terminal_color_5 = colorScheme.base0E
  vim.g.terminal_color_6 = colorScheme.base0C
  vim.g.terminal_color_7 = colorScheme.base05
  vim.g.terminal_color_8 = colorScheme.base03
  vim.g.terminal_color_9 = colorScheme.base08
  vim.g.terminal_color_10 = colorScheme.base0B
  vim.g.terminal_color_11 = colorScheme.base0A
  vim.g.terminal_color_12 = colorScheme.base0D
  vim.g.terminal_color_13 = colorScheme.base0E
  vim.g.terminal_color_14 = colorScheme.base0C
  vim.g.terminal_color_15 = colorScheme.base07
end

return M
