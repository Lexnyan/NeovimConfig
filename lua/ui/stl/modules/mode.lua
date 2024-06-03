local api = vim.api
local modes = require("ui.stl.modes")


local M = function(m)
  local mode = api.nvim_get_mode().mode
  local sep = "%#" .. modes[mode][2] .. "Sep" .. "#" .. "  "
  local septwo = "%#StalineModeSepTwo" .. "#" .. " "
  local septhree = "%#StalineModeSepThree" .. "#" .. "  "
  if (m == 'blocks') then
    return "%#" .. modes[mode][2] .. "#" .. " " .. modes[mode][1] .. " " .. septhree;
  elseif (m == 'minimal') then
    return "%#" .. "StalineModeMinimal" .. "#" .. " " .. modes[mode][1] .. " ";
  elseif (m == 'fancy') then
    return "%#" .. modes[mode][2] .. "#" .. "   " .. modes[mode][1] .. " " .. sep .. septwo .. "";
  else
    return "F"
  end
end

return M
