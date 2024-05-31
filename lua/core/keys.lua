vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap

-- Navegación
map("n", "<C-a>", "gg<S-v>G", { noremap = true, silent = true })            -- Seleccionar todo el documento
map('n', '<C-n>', ':NvimTreeToggle<cr>', { noremap = true, silent = true }) -- Alternar NvimTree (explorador de archivos)
--map('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })

-- Telescope (herramienta de búsqueda y navegación)
--map("n", "<leader>ff", ":Telescope find_files<cr>", { noremap = true, silent = true }) -- Buscar archivos
--map("n", "<leader>fg", ":Telescope oldfiles<cr>", { noremap = true, silent = true })   -- Buscar archivos recientes
--map("n", "<leader>fb", ":Telescope buffers<cr>", { noremap = true, silent = true })    -- Buscar buffers (archivos abiertos)
--map("n", "<leader>fh", ":Telescope help_tags<cr>", { noremap = true, silent = true })  -- Buscar etiquetas de ayuda
--map("n", "<leader>fr", ":Telescope live_grep<cr>", { noremap = true, silent = true })  -- Buscar coincidencias en vivo
map("n", "<leader>ft", ":PrismTelescope<CR>", { noremap = true, silent = true })

-- LspSaga (funciones avanzadas de LSP para navegación)
map("n", "K", ":Lspsaga hover_doc<CR>", { noremap = true, silent = true }) -- Mostrar documentación flotante para el símbolo bajo el cursor
--map("n", "<leader>e", ":Lspsaga diagnostic_jump_next<CR>", { noremap = true, silent = true })-
--map("n", "gi", ":Lspsaga finder<CR>", { noremap = true, silent = true })
--map("n", "gd", ":Lspsaga peek_definition<CR>", { noremap = true, silent = true })

-- NerdCommenter (comentar/descomentar) con CTRL+/
map("v", "<leader>cc", "<Plug>NERDCommenterToggle<cr>", { noremap = true }) -- Alternar comentarios en modo visual
--map("n", "<leader>c", "<Plug>NERDCommenterToggle<cr>", { noremap = true }) -- Alternar comentarios en modo normal

-- Markdown
--map('n', "<C-s>", "<Plug>MarkdownPreview<cr>", { noremap = true, silent = true })
