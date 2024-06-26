local lspconfig = require("lspconfig")

local M = {}

M.on_attach = function(client, _)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local servers = {
  'bashls',
  "jdtls",
  "html",
  "pyright",
  "tsserver",
  "emmet_ls",
  "clangd",
  "cssls",
  "omnisharp",
  "texlab",
  "intelephense",
  "jsonls",
  "lemminx",
  "cmake",
}

for _, k in ipairs(servers) do
  lspconfig[k].setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }
end

lspconfig.lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      },
      diagnostics = {
        globals = { "vim", "opts", "ft_cmds" },
      },
    },
  }
}

lspconfig.intelephense.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "intelephense", "--stdio" },
  root_dir = lspconfig.util.root_pattern("composer.json", ".git", "index.php", "public"),
  filetypes = { "php" },
}

lspconfig.clangd.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "clangd", "--background-index" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", "compile_flags.txt", "compile_flags.txt"),
}

lspconfig.omnisharp.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "omnisharp" },
  root_dir = function() return vim.fn.getcwd() end,
}


return M
