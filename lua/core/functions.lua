local M = {}

function M.toggle_option(option)
  local value = not vim.api.nvim_get_option_value(option, {})
  vim.opt[option] = value
  vim.notify(option .. " set to " .. tostring(value))
end

function M.toggle_tabline()
  local value = vim.api.nvim_get_option_value("showtabline", {})
  if value == 2 then
    value = 0
  else
    value = 2
  end
  vim.opt.showtabline = value
  vim.notify("showtabline" .. " set to " .. tostring(value))
end

function M.build_run()
  -- HUUUUUUUUUUUUUUUUUUUUUUUGE kudos and thanks to
  -- https://github.com/hown3d for this function <3
  local function substitute(cmd)
    cmd = cmd:gsub("%%", vim.fn.expand "%")
    cmd = cmd:gsub("$fileBase", vim.fn.expand "%:r")
    cmd = cmd:gsub("$filePath", vim.fn.expand "%:p")
    cmd = cmd:gsub("$file", vim.fn.expand "%")
    cmd = cmd:gsub("$dir", vim.fn.expand "%:p:h")
    cmd = cmd:gsub("#", vim.fn.expand "#")
    cmd = cmd:gsub("$altFile", vim.fn.expand "#")

    return cmd
  end

  local file_extension = vim.fn.expand "%:e"
  local selected_cmd = ""
  local term_cmd = "bot 10 new | term "
  local supported_filetypes = {
    html = {
      default = "live-server .",
    },
    c = {
      default = "gcc % -o $fileBase && ./$fileBase",
      debug = "gcc -g % -o $fileBase && $fileBase",
    },
    cs = {
      default = "dotnet run",
    },
    cpp = {
      default = "g++ % -o  $fileBase && ./$fileBase",
      debug = "g++ -g % -o  $fileBase",
      -- competitive = "g++ -std=c++17 -Wall -DAL -O2 % -o $fileBase && $fileBase<input.txt",
      competitive = "g++ -std=c++17 -Wall -DAL -O2 % -o $fileBase && $fileBase",
    },
    py = {
      default = "python %",
    },
    go = {
      default = "go run %",
    },
    java = {
      default = "java %",
    },
    js = {
      default = "node %",
      debug = "node --inspect %",
    },
    ts = {
      default = "tsc % && node $fileBase",
    },
    rs = {
      default = "rustc % && $fileBase",
    },
    php = {
      default = "php %",
    },
    r = {
      default = "Rscript %",
    },
    jl = {
      default = "julia %",
    },
    rb = {
      default = "ruby %",
    },
    pl = {
      default = "perl %",
    },
  }

  if supported_filetypes[file_extension] then
    local choices = vim.tbl_keys(supported_filetypes[file_extension])

    if #choices == 0 then
      vim.notify("It doesn't contain any command", vim.log.levels.WARN, { title = "Code Runner" })
    elseif #choices == 1 then
      selected_cmd = supported_filetypes[file_extension][choices[1]]
      vim.cmd(term_cmd .. substitute(selected_cmd))
    else
      vim.ui.select(choices, { prompt = "Choose a command: " }, function(choice)
        selected_cmd = supported_filetypes[file_extension][choice]
        if selected_cmd then
          vim.cmd(term_cmd .. substitute(selected_cmd))
        end
      end)
    end
  else
    vim.notify("The filetype isn't included in the list", vim.log.levels.WARN, { title = "Code Runner" })
  end
end

local lazygit = require("toggleterm.terminal").Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = { border = "curved" },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})

function M.LazyGit()
  lazygit:toggle()
end

function M.Ranger()
  local status_ok, _ = pcall(require, "toggleterm")
  if not status_ok then
    return vim.notify("toggleterm.nvim isn't installed!")
  end
  if vim.fn.executable("ranger") == 0 then
    return vim.notify("ranger isn't installed")
  end
  local ranger = require("toggleterm.terminal").Terminal:new({
    cmd = "ranger",
    direction = "float",
    on_open = function(term)
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  })
  ranger:toggle()
end

return M
