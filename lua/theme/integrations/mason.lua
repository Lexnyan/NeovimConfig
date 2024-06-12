local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

return {
  MasonHeader = { bg = colors.red, fg = colors.background },
  MasonHighlight = { fg = colors.blue },
  MasonHighlightBlock = { fg = colors.background, bg = colors.green },
  MasonHighlightBlockBold = { link = "MasonHighlightBlock" },
  MasonHeaderSecondary = { link = "MasonHighlightBlock" },
  MasonMuted = { fg = colors.foreground },
  MasonMutedBlock = { fg = colors.foreground, bg = utils.blend(colors.foreground, colors.background, 0.2) },
}
