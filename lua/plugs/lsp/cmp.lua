local present, cmp = pcall(require, 'cmp')

if not present then
  return
end

local kind_icons = {
  Array = "  ",
  Boolean = "  ",
  Class = "  ",
  Color = "  ",
  Constant = "  ",
  Constructor = "  ",
  Enum = "  ",
  EnumMember = "  ",
  Event = "  ",
  Field = "  ",
  File = "  ",
  Folder = " 󰉋 ",
  Function = "  ",
  Interface = "  ",
  Key = "  ",
  Keyword = "  ",
  Method = "  ",
  Module = "  ",
  Namespace = "  ",
  Null = " 󰟢 ",
  Number = "  ",
  Object = "  ",
  Operator = "  ",
  Package = "  ",
  Property = "  ",
  Reference = "  ",
  Snippet = "  ",
  String = "  ",
  Struct = "  ",
  Text = "  ",
  TypeParameter = "  ",
  Unit = "  ",
  Value = "  ",
  Variable = "  ",
  Codeium = "  ",
}

local colors = require("prism.themer"):getColors()

cmp.setup({
  vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = colors.color4, bg = "NONE" }),
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = colors.color3, bg = "NONE" }),
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = colors.color1, bg = "NONE" }),
  snippet = {
    expand = function(args)
      local present, luasnip = pcall(require, "luasnip")
      if present then
        luasnip.lsp_expand(args.body)
      end
    end,
  },
  window = {
    completion = {
      border = "single",
      scrollbar = false,
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"
    },
    documentation = {
      border = "single",
      scrollbar = false,
    }
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

  }),

  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]
      vim_item.menu = ({
        buffer = " [Buf]",
        path = "󰴠 [Path]",
        nvim_lsp = " [Lsp]",
        luasnip = " [Snip]",
        cmdline = " [Cmd]",
        nvim_lua = " [Lua]",
        codeium = " [Ai]",
      })[entry.source.name]
      return vim_item
    end,
  },

  sources = cmp.config.sources({
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "luasnip_choice" },
    { name = "snippy" },
    { name = "nvim_lua" },
    { name = "vsnip" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "codeium" },
  }),
})