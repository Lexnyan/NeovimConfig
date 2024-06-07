--NOTE: Plugins should be lazy loaded

require("plugs.strap")
local lazy = require("lazy")
lazy.setup({

  {
    "stevearc/dressing.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "rcarriga/nvim-notify",
    },
    config = function()
      require("plugs.util.utils").notify()
      require("plugs.util.utils").dressing()
    end,
  },

  -- noice
  {
    "folke/noice.nvim",
    event = "CmdlineEnter",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("plugs.util.noice")
    end
  },


  -- lspsaga
  {
    "nvimdev/lspsaga.nvim",
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    event = { "LspAttach" },
    config = function()
      require("plugs.lsp.lspsaga")
    end
  },


  -- Highlight, List and Search Todo comments in your projects
  {
    "folke/todo-comments.nvim",
    lazy = false,
    cmd = { "TodoTrouble", "TodoLocList", "TodoQuickFix", "TodoTelescope" },
    config = function()
      require("plugs.util.todo-comments")
    end
  },

  -- Keymaps Popup
  {
    "folke/which-key.nvim",
    envent = "VeryLazy",
    lazy = false,
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("plugs.util.which-key")
    end
  },

  -- SHow diffs
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
  },

  -- Improve Folds
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.foldmethod = "indent"
    end,
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
    },
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
              { text = { "%s" },                  click = "v:lua.ScSa" },
            },
          }
        end,
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    lazy = true,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    dependencies = {
      {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
          require "plugs.ts.rainbow"
        end
      },
      {
        "windwp/nvim-ts-autotag",
        ft = { "html", "javascript", "jsx", "typescript", "tsx", "svelte", "vue", "xml", "markdown" },
        opts = { enable_close_on_slash = false },
      },
    },
    config = function() require('plugs.ts.treesitter') end
  },

  {
    'windwp/nvim-ts-autotag',
    event = "InsertEnter",
    lazy = true
  },

  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufRead',
    config = function() require('plugs.ui.colorizer') end,
    lazy = true
  },

  {
    "nvim-tree/nvim-web-devicons",
    event = 'BufRead',
    config = function() require('plugs.ui.devicons') end,
    lazy = true,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    event = "BufReadPost",
    config = function()
      require("plugs.ui.indent")
    end
  },

  {
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    cmd = "NvimTreeToggle",
    config = function() require('plugs.util.nvim-tree') end
  },

  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },

  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    lazy = true,
    dependencies = { 'plenary.nvim' },
    config = function() require('plugs.util.telescope') end
  },

  {
    "terrortylor/nvim-comment",
    config = function()
      require('nvim_comment').setup({ create_mappings = false })
    end
  },

  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    config = function() require('plugs.util.toggleterm') end,
    cmd = "ToggleTerm",
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { "BufRead" },
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
          change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          untracked    = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsDeleteLn' },
        },
      }
    end
  },

  -- mason
  {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("plugs.lsp.mason")
    end
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    lazy = true,
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "LspStart" },
    config = function()
      require "plugs.lsp.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    lazy = true,
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
          require("plugs.lsp.luasnip")
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        event = "InsertEnter",
        lazy = true,
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    config = function()
      require("plugs.lsp.cmp")
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "InsertEnter" },
    opts = {
      signs = false,
    }
  },

  {
    "goolord/alpha-nvim",
    cmd = {
      "Alpha",
      "AlphaRedraw"
    },
    config = function()
      require("plugs.ui.alpha")
    end
  },

  {
    "chadcat7/prism",
    lazy = true,
    event = "UIEnter",
    config = function()
      require("plugs.ui.prism")
    end
  },

  {
    "Exafunction/codeium.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end
  },

  --TODO: DAP config
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("plugs.dap")
    end
  },
  {
    "preservim/nerdcommenter",
    lazy = false,
    config = function()
      require("plugs.util.utils").nerdcommenter()
    end
  },
}, {
  ui = {
    size = { width = 0.8, height = 0.8 },
    border = "solid",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "鈴 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
      list = { "●", "➜", "★", "‒" },
    },
    throttle = 20,
  },
  defaults = { lazy = true },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
      ttl = 3600 * 24 * 5,
      disable_events = { "VimEnter", "BufReadPre", "UIEnter" },
    },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "logipat",
        "matchit",
        "matchparen",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "logipat",
        "matchit",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
        "archlinux",
        "fzf",
        "tutor_mode_plugin",
        "sleuth",
        "vimgrep"
      },
    },
  },
})
