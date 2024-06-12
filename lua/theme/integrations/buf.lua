local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

return {
  BuffLineTree = { bg = colors.darker, fg = colors.foreground },
  BuffLineEmpty = { bg = colors.background, fg = colors.foreground },
  BuffLineEmptyColor = { bg = colors.lighter, fg = colors.foreground },
  BuffLineButton = { bg = utils.blend(colors.base0E, colors.base00, 0.1), fg = colors.base0E },
  BuffLineCloseButton = { bg = colors.base08, fg = colors.base00 },
  BuffLineRun = { bg = utils.blend(colors.base0F, colors.base00, 0.1), fg = colors.base0F },
  BuffLineSplit = { bg = utils.blend(colors.base0B, colors.base00, 0.1), fg = colors.base0B },
  BufflineTrans = { bg = utils.blend(colors.base0D, colors.base00, 0.1), fg = colors.base0D },

  BufflineBufOnActive = { bg = colors.base0D, fg = colors.base00 },
  BufflineBufOnInactive = { fg = colors.base07, bg = colors.base00 },
  BuffLineBufOnModified = { bg = colors.base0D, fg = colors.base00 },
  BuffLineBufOffModified = { fg = colors.base0F, bg = colors.base00 },
  BuffLineBufOnClose = { bg = colors.base0D, fg = colors.base00 },
  BuffLineBufOffClose = { fg = colors.base0F, bg = utils.blend(colors.base0F, colors.base00, 0.1) },
}
