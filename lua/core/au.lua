local custom_autocmd_group = vim.api.nvim_create_augroup("CustomAutocmdGroup", { clear = true })

-- Code formatting when saving
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function()
    for _, client in ipairs(vim.lsp.get_active_clients()) do
      if client.attached_buffers[vim.api.nvim_get_current_buf()] then
        vim.lsp.buf.format()
        return
      end
    end
  end
})

-- Load theme when starting UI
vim.api.nvim_create_autocmd({ "UIEnter" }, {
  callback = function()
    if vim.g.loadNvimTheme then
      dofile(vim.g.themeCache .. "allThemes")
    end
    local should_skip = false
    if vim.fn.argc() > 0 or vim.fn.line2byte "$" ~= -1 or not vim.o.modifiable then
      should_skip = true
    else
      for _, arg in pairs(vim.v.argv) do
        if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
          should_skip = true
          break
        end
      end
    end
    if not should_skip then vim.cmd("Alpha") end
  end
})

-- Open the file tree when entering Vim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
      return
    end
    -- Change to directory
    vim.cmd.cd(data.file)

    -- Open the file tree
    require("nvim-tree.api").tree.open()
  end
})

-- Open floating window for LSP diagnostics
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.diagnostic.open_float({ scope = "cursor", focusable = false })
  end,
  desc = "Open Float Window for LSP Diagnostics",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = custom_autocmd_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight yanked text",
})

-- Close help, manual, quickfix, and floating DAP windows with 'q'
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = custom_autocmd_group,
  callback = function()
    local buftype = vim.api.nvim_buf_get_option(0, "buftype")
    if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) and vim.fn.maparg("q", "n") == "" then
      vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close<cr>", {
        silent = true,
        noremap = true,
      })
    end
  end,
  desc = "Make q close help, man, quickfix, dap floats",
})

-- Do not list quickfix buffer
vim.api.nvim_create_autocmd("FileType", {
  group = custom_autocmd_group,
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
  desc = "Don't list quickfix buffer",
})

-- Reload Neovim configuration on save
vim.api.nvim_create_autocmd("BufWritePost", {
  group = custom_autocmd_group,
  pattern = vim.fn.stdpath("config") .. "/lua/*.lua",
  callback = function()
    local fp = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":r")
    local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
    local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")
    vim.cmd("silent source %")
    if vim.g.loadNvimTheme then
      require("plenary.reload").reload_module("theme")
    end
    require("plenary.reload").reload_module(module)
    if vim.g.loadNvimTheme then
      require("theme").loadThemes()
    end
  end,
  desc = "Reload neovim config on save",
})

-- Simplified user commands
vim.api.nvim_create_user_command("NvimTheme", function()
  require("theme.pick").setup()
end, {})

vim.api.nvim_create_user_command("NvimToggleTrans", function()
  require("theme.pick").toggleTransparency()
end, {})

vim.api.nvim_create_user_command("Ranger", function()
  require("core.utils").Ranger()
end, {})

