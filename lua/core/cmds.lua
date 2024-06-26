local notify = require("notify")

local function has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

local function set_status_style(theme)
  vim.g.statusStyle = theme
  require("ui.stl").setup(theme)
end

local function notify_invalid_theme()
  notify('Invalid Theme', 'error', {
    title = 'Theme Error',
    timeout = 3000,
  })
end

local available_themes = { 'blocks', 'fancy', 'minimal' }

local function statusline_glowup_command(opts)
  local theme = opts.args[1]

  if not has_value(available_themes, theme) then
    notify_invalid_theme()
    return
  end

  set_status_style(theme)
end

local function complete_available_themes()
  return available_themes
end

vim.api.nvim_create_user_command('StatuslineGlowup', statusline_glowup_command, {
  nargs = 1,
  complete = complete_available_themes,
})
