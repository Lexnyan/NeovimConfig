local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

if not colors then
  return { error = "colors not found" }
end

return {
  NavicIconsConstant = { fg = colors.base09 },
  NavicIconsFunction = { fg = colors.base0D },
  NavicIconsIdentifier = { fg = colors.base08 },
  NavicIconsField = { fg = colors.base08 },
  NavicIconsVariable = { fg = colors.base0E },
  NavicIconsSnippet = { fg = colors.red },
  NavicIconsText = { fg = colors.base0B },
  NavicIconsStructure = { fg = colors.base0E },
  NavicIconsType = { fg = colors.base0A },
  NavicIconsKeyword = { fg = colors.base07 },
  NavicIconsMethod = { fg = colors.base0D },
  NavicIconsConstructor = { fg = colors.blue },
  NavicIconsFolder = { fg = colors.base07 },
  NavicIconsModule = { fg = colors.base0A },
  NavicIconsProperty = { fg = colors.base08 },
  NavicIconsEnum = { fg = colors.blue },
  NavicIconsUnit = { fg = colors.base0E },
  NavicIconsClass = { fg = colors.blue },
  NavicIconsFile = { fg = colors.base07 },
  NavicIconsInterface = { fg = colors.green },
  NavicIconsColor = { fg = colors.foreground },
  NavicIconsReference = { fg = colors.base05 },
  NavicIconsEnumMember = { fg = utils.mix(colors.red, colors.blue, 0.5) },
  NavicIconsStruct = { fg = colors.base0E },
  NavicIconsValue = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
  NavicIconsEvent = { fg = utils.mix(colors.red, colors.green, 0.5) },
  NavicIconsOperator = { fg = colors.base05 },
  NavicIconsTypeParameter = { fg = colors.base08 },
  NavicIconsNamespace = { fg = colors.blue },
  NavicIconsPackage = { fg = colors.green },
  NavicIconsString = { fg = colors.green },
  NavicIconsNumber = { fg = colors.red },
  NavicIconsBoolean = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5) },
  NavicIconsArray = { fg = colors.blue },
  NavicIconsObject = { fg = colors.base0E },
  NavicIconsKey = { fg = colors.red },
  NavicIconsNull = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
  NavicText = { fg = utils.blend(colors.foreground, colors.background, 0.2) },
  NavicSeparator = { fg = colors.red },
}
