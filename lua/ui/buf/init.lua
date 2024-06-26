local M = {}

-- Utility function to check if a buffer is valid and listed
local function is_buffer_valid_and_listed(buf)
  return vim.api.nvim_buf_is_valid(buf)
      and vim.bo[buf].buflisted
      and vim.api.nvim_buf_is_loaded(buf)
end

-- Utility function to get the buffer name or an empty string if the buffer is not named
local function get_buffer_name(buf)
  local buf_name = vim.api.nvim_buf_get_name(buf)
  return (#buf_name ~= 0) and vim.fn.fnamemodify(buf_name, ":t") or ""
end

-- Function to create a tab string for a buffer
local function create_tab_string(buf)
  if not is_buffer_valid_and_listed(buf) then
    return ""
  end

  local buf_name = get_buffer_name(buf)
  local is_active = (buf == vim.api.nvim_get_current_buf())
  local is_modified = vim.bo[buf].modified
  local buf_highlight = is_active and "%#BufflineBufOnActive#" or "%#BufflineBufOnInactive#"
  local close_btn_highlight = is_active and "%#BuffLineBufOnClose#" or "%#BuffLineBufOffClose#"

  if is_modified then
    close_btn_highlight = is_active and "%#BuffLineBufOnModified#" or "%#BuffLineBufOffModified#"
  end

  local close_btn = "%" .. buf .. "@BufflineKillBuf@ 󰅜 %X"
  close_btn = close_btn_highlight .. close_btn .. " "

  return buf_highlight .. "  " .. buf_name .. close_btn .. "%#BufflineEmptyColor#"
end

-- Function to get the width of the NvimTree window
local function get_tree_width()
  for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].ft == "NvimTree" then
      return vim.api.nvim_win_get_width(win)
    end
  end
  return 0
end

-- Function to generate the entire tabline string
M.get_tabline = function()
  local buffline = ""
  local buffstart = "%#BuffLineEmpty#"
  local run = "%#BuffLineRun# %@Run@" .. "  "
  if vim.bo.filetype == "html" then
    run = "%#BuffLineRun# %@Run@" .. "󰀂  "
  end
  local button = "%#BufflineButton# %@ToggleTheme@" .. "󱥚  "
  local trans = "%#BufflineTrans# %@ToggleTrans@" .. "󱡓  "
  local split = "%#BuffLineSplit# %@Split@" .. "  "
  local closebutton = "%#BufflineCloseButton# %@CloseAll@" .. "󰅜 "
  local counter = 0

  for _, buf in pairs(vim.api.nvim_list_bufs()) do
    if is_buffer_valid_and_listed(buf) then
      local filename = vim.api.nvim_buf_get_name(buf)
      local buf_type = vim.bo[buf].ft
      if filename ~= "" and not vim.tbl_contains({ 'NvimTree', 'help', 'dasher', 'lir', 'alpha', "toggleterm" }, buf_type) then
        local tab_string = create_tab_string(buf)
        buffline = buffline .. tab_string
        counter = counter + 1
      end
    end
  end

  if counter > 0 then
    buffstart = "%#BufflineEmptyColor#"
  end

  local treespace = ""
  local tree_width = get_tree_width()

  if tree_width > 2 then
    treespace = ("%#BufflineTree#" .. string.rep(" ", tree_width / 2 - 3) .. "Browse" .. string.rep(" ", tree_width / 2 - 2))
  else
    treespace = "%#BufflineTree#" .. string.rep(" ", tree_width)
  end

  return treespace .. buffstart .. buffline .. "%=" .. run .. split .. trans .. button .. closebutton
end

-- Setup function
M.setup = function()
  if #vim.fn.getbufinfo { buflisted = 1 } >= 1 then
    vim.opt.showtabline = 2
    vim.opt.tabline = '%!v:lua.require("ui.buf").get_tabline()'
  end
end

-- Mappings
vim.cmd [[
  nnoremap <silent><TAB> :BufflineNext<CR>
  nnoremap <silent><S-TAB> :BufflinePrev<CR>
]]

return M
