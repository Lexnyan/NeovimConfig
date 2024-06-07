local wk = require("which-key")

local fn = vim.fn
local cwd = vim.fn.stdpath("config") .. "/"
local config_dir = { cwd }

function ClickGit()
  local status_ok, _ = pcall(require, "toggleterm")
  if not status_ok then
    return vim.notify("toggleterm.nvim isn't installed!!!")
  end

  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new { cmd = "lazygit", direction = "float", hidden = true }
  lazygit:toggle()
end

wk.register({
  ["<leader>"] = {
    e = {
      name = "  Nvim-Tree",
      e = { "<cmd>NvimTreeToggle<cr>", "Toggle Tree", opts = { silent = true } },
    },
    c = {
      name = "󰆄 Comment",
      c = { "<Plug>NERDCommenterToggle<cr>", "Toggle Comment", opts = { silent = true } },
    },
    d = {
      name = "󰃤 Debugger",
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue", opts = { silent = true } },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over", opts = { silent = true } },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into", opts = { silent = true } },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out", opts = { silent = true } },
      b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint", opts = { silent = true } },
      B = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Set Breakpoint Condition", opts = { silent = true } },
      d = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle Dap UI", opts = { silent = true } },
      l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last", opts = { silent = true } },
    },
    f = {
      name = " Find",
      a = { "<cmd>Telescope autocommands<cr>", "Autocommands", opts = { silent = true } },
      f = { "<cmd>Telescope find_files<cr>", "Find Files", opts = { silent = true } },
      s = { "<cmd>Telescope persisted<cr>", "Find Sessions", opts = { silent = true } },
      m = { "<cmd>Telescope marks<cr>", "Find Marks", opts = { silent = true } },
      M = { "<cmd>Telescope man_pages<cr>", "Find Man Pages", opts = { silent = true } },
      w = { "<cmd>Telescope live_grep<cr>", "Live Grep", opts = { silent = true } },
      b = { "<cmd>Telescope buffers<cr>", "Find Buffers", opts = { silent = true } },
      n = { "<cmd>lua require('telescope').extensions.notify.notify()<cr>", "Notify History", opts = { silent = true } },
      p = { "<cmd>Telescope projects<cr>", "Find Projects", opts = { silent = true } },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help", opts = { silent = true } },
      k = { "<cmd>Telescope keymaps<cr>", "Find Keymaps", opts = { silent = true } },
      C = { "<cmd>Telescope commands<cr>", "Find Commands", opts = { silent = true } },
      r = { "<cmd>Telescope oldfiles<cr>", "Find Recent Files", opts = { silent = true } },
      H = { "<cmd>Telescope highlights<cr>", "Find Highlights", opts = { silent = true } },
    },
    g = {
      name = "󰊢 Git",
      o = { "<cmd>Telescope git_status<cr>", "Open Changed File", opts = { silent = true } },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch", opts = { silent = true } },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout Commit", opts = { silent = true } },
      g = {
        function()
          ClickGit()
        end,
        "Lazygit",
        opts = { silent = true },
      },
      j = { "<cmd>lua require'gitsigns'.next_hunk()<cr>", "Next Hunk", opts = { silent = true } },
      k = { "<cmd>lua require'gitsigns'.prev_hunk()<cr>", "Previous Hunk", opts = { silent = true } },
      l = { "<cmd>lua require'gitsigns'.blame_line()<cr>", "Blame Line", opts = { silent = true } },
      p = { "<cmd>lua require'gitsigns'.preview_hunk()<cr>", "Preview Hunk", opts = { silent = true } },
      r = { "<cmd>lua require'gitsigns'.reset_hunk()<cr>", "Reset Hunk", opts = { silent = true } },
      R = { "<cmd>lua require'gitsigns'.reset_buffer()<cr>", "Reset Buffer", opts = { silent = true } },
      s = { "<cmd>lua require'gitsigns'.stage_hunk()<cr>", "Stage Hunk", opts = { silent = true } },
      u = { "<cmd>lua require'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk", opts = { silent = true } },
      d = {
        function()
          if next(require("diffview.lib").views) == nil then
            vim.cmd("DiffviewOpen")
          else
            vim.cmd("DiffviewClose")
          end
        end,
        "Toggle Diffview",
        opts = { silent = true },
      },
    },
    l = {
      name = " LSP",
      k = { "<cmd>Lspsaga hover_doc<cr>", "Hover Doc", opts = { silent = true } },
      e = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic", opts = { silent = true } },
      a = { "<cmd>Lspsaga code_action<cr>", "Code Action", opts = { silent = true } },
      o = { "<cmd>Lspsaga outline<cr>", "Code Outline", opts = { silent = true } },
      I = { "<cmd>Lspsaga incoming_calls<cr>", "Incoming Calls", opts = { silent = true } },
      O = { "<cmd>Lspsaga outgoing_calls<cr>", "Outgoing Calls", opts = { silent = true } },
      r = { "<cmd>Lspsaga rename<cr>", "Rename", opts = { silent = true } },
      i = { "<cmd>LspInfo<cr>", "LSP Info", opts = { silent = true } },
    },
    n = {
      name = " Neovim",
      f = {
        function()
          require("telescope.builtin").find_files {
            prompt_title = "Config Files",
            search_dirs = config_dir,
            cwd = cwd,
          }
        end,
        "Find Config Files",
        opts = { silent = true }
      },
      g = {
        function()
          require("telescope.builtin").live_grep {
            prompt_title = "Config Files",
            search_dirs = config_dir,
            cwd = cwd,
          }
        end,
        "Grep Config Files",
        opts = { silent = true }
      },
      i = {
        function()
          if vim.fn.has("nvim-0.9.0") == 1 then
            vim.cmd("Inspect")
          else
            vim.notify("Inspect isn't available in this Neovim version", vim.log.levels.WARN, { title = "Inspect" })
          end
        end,
        "Inspect",
        opts = { silent = true }
      },
      m = { "<cmd>messages<cr>", "Messages", opts = { silent = true } },
      h = { "<cmd>checkhealth<cr>", "Health", opts = { silent = true } },
      v = {
        function()
          local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
          return vim.notify(version, vim.log.levels.INFO, { title = "Neovim Version" })
        end,
        "Version",
        opts = { silent = true }
      },
    },
    o = {
      name = " Options",
    },
    p = {
      name = " Plugins",
      c = { "<cmd>Lazy clean<cr>", "Clean Plugins", opts = { silent = true } },
      C = { "<cmd>Lazy check<cr>", "Check Plugins", opts = { silent = true } },
      d = { "<cmd>Lazy debug<cr>", "Debug Plugins", opts = { silent = true } },
      i = { "<cmd>Lazy install<cr>", "Install Plugins", opts = { silent = true } },
      s = { "<cmd>Lazy sync<cr>", "Sync Plugins", opts = { silent = true } },
      l = { "<cmd>Lazy log<cr>", "Log Plugins", opts = { silent = true } },
      h = { "<cmd>Lazy home<cr>", "Home Plugins", opts = { silent = true } },
      H = { "<cmd>Lazy help<cr>", "Help Plugins", opts = { silent = true } },
      p = { "<cmd>Lazy profile<cr>", "Profile Plugins", opts = { silent = true } },
      u = { "<cmd>Lazy update<cr>", "Update Plugins", opts = { silent = true } },
    },
    t = {
      name = " Terminal",
      f = { "<cmd>ToggleTerm direction=float<cr>", "Float Terminal", opts = { silent = true } },
      h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal Terminal", opts = { silent = true } },
      v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical Terminal", opts = { silent = true } },
    },
  },
})
