local colors = require("theme").getCurrentTheme()
local utils = require("core.utils")

return {
  NvimTreeNormal = { fg = colors.foreground, bg = colors.darker },
  NvimTreeNormalNC = { fg = colors.foreground, bg = colors.darker },
  NvimTreeRootFolder = { fg = colors.base09 },
  NvimTreeGitDirty = { fg = colors.base09 },
  NvimTreeGitNew = { fg = colors.base0B },
  NvimTreeGitDeleted = { fg = colors.base08 },
  NvimTreeSpecialFile = { fg = colors.base0D },
  NvimTreeIndentMarker = { fg = utils.blend(colors.base01, colors.base01, 0.2) },
  NvimTreeImageFile = { fg = colors.foreground },
  NvimTreeSymlink = { fg = colors.base0C },
  NvimTreeFolderIcon = { fg = colors.base0A, bg = colors.darker },
  NvimTreeFolderName = { fg = colors.foreground },
  NvimTreeOpenedFolderName = { fg = colors.foreground },
  NvimTreeEmptyFolderName = { fg = colors.foreground },
  NvimTreeStatusLineNC = { bg = colors.background, fg = colors.darker },
}
