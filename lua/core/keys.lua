vim.g.mapleader = " "
local api = vim.api
local map = api.nvim_set_keymap

-- Function to create mappings
local function create_mapping(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  opts.silent = opts.silent == nil and true or opts.silent
  map(mode, lhs, rhs, opts)
end

-- Navigation
create_mapping("n", "<C-a>", "gg<S-v>G")            -- Select entire document
create_mapping('n', '<C-n>', ':NvimTreeToggle<cr>') -- Toggle NvimTree (file explorer)
create_mapping("n", "<leader>ft", ":NvimTheme<CR>") -- Telescope Themes

-- LspSaga (advanced LSP functions for navigation)
create_mapping("n", "K", ":Lspsaga hover_doc<CR>") -- Show hover documentation for symbol under cursor

-- NerdCommenter (comment/uncomment) with CTRL+/
create_mapping("v", "<leader>cc", "<Plug>NERDCommenterToggle<cr>") -- Toggle comments in visual mode
