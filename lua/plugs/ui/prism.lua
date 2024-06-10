local cfg = require("core.cfg")

require("prism"):setup({
  customSchemes = cfg.customSchemes,
  currentTheme = "atom_one_dark_darker",
  reset = false,
  customFiles = vim.fn.stdpath "config" .. "/lua/hls",
  transparent = false,
  reload = {},
})
