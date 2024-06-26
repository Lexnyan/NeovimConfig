local colors = require("theme").getCurrentTheme()

if not colors then
  return { error = "colors not found" }
end

return {
  Boolean = { fg = colors.base09 },
  Character = { fg = colors.base08 },
  Conditional = { fg = colors.base0E },
  Constant = { fg = colors.base08 },
  Define = { fg = colors.base0E, sp = "none" },
  Delimiter = { fg = colors.base0F },
  Float = { fg = colors.base09 },
  Variable = { fg = colors.base09 },
  Function = { fg = colors.base0D, bold = true },
  Identifier = { fg = colors.base08, sp = "none" },
  Include = { fg = colors.base0D },
  Keyword = { fg = colors.base0E },
  Label = { fg = colors.base0A },
  Number = { fg = colors.base09 },
  Operator = { fg = colors.base05, sp = "none" },
  PreProc = { fg = colors.base0A },
  Repeat = { fg = colors.base0A },
  Special = { fg = colors.base0C },
  SpecialChar = { fg = colors.base0F },
  Statement = { fg = colors.base08 },
  StorageClass = { fg = colors.base0A },
  String = { fg = colors.base0B },
  Structure = { fg = colors.base0E },
  Tag = { fg = colors.base0A },
  Todo = { fg = colors.base0A, bg = colors.base01 },
  Type = { fg = colors.base0A, sp = "none" },
  Typedef = { fg = colors.base0A },
}
