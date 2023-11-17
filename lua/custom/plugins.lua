local plugins = {
  {
    "rmagatti/auto-session",
    lazy = false,
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { -- mason and mason-lspconfig must be loaded before loading nvim-lspconfig
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
          { -- mason must be loaded before loading mason-lspconfig
            "williamboman/mason.nvim",
            opts = function() -- override default mason opts
              return require "custom.configs.mason"
            end,
          },
        },
        opts = {
          ensure_installed = {
            "lua_ls",
            "tsserver",
            "eslint",
            "rust_analyzer",
          },
        },
      },
      -- rust language server and other development tools,
      -- will be set up in the nvim-lspconfig setup
      "simrat39/rust-tools.nvim",
    },
    config = function()
      require "custom.configs.lspconfig"
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    "machakann/vim-sandwich",
    keys = { "v", "V", "<C-v>" }, -- only usable in visual mode
    init = function()
      vim.g.sandwich_no_default_key_mappings = 1
    end,
    config = function()
      require "custom.configs.sandwich"
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gvdiff", "Gwrite", "Gw", "Gread", "Gr" },
  },
  {
    "stevearc/conform.nvim",
    keys = {
      { "<leader>mp", mode = "n", desc = "Format document" },
    },
    event = "BufWritePre",
    config = function()
      require "custom.configs.formatter"
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = require "custom.configs.copilot",
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "Dif", "DifA", "DifH" },
    config = function()
      require "custom.configs.diffview"
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = {
      { "<leader>so", mode = "n", desc = "Toggle symbols outline" },
    },
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
    config = function()
      require "custom.configs.symbols-outline"
    end,
  },
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    cmd = { "Telekasten" },
    opts = require "custom.configs.telekasten",
  },
  { -- extend default nvimtree opts
    "nvim-tree/nvim-tree.lua",
    opts = require "custom.configs.nvimtree",
  },
  { -- override default telescope opts
    "nvim-telescope/telescope.nvim",
    opts = function()
      return require "custom.configs.telescope"
    end,
  },
  { -- override default treesitter opts
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      return require "custom.configs.treesitter"
    end,
  },
  { -- make indent-blankline truly lazy-loaded
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    init = false,
  },
  { -- make gitsigns truly lazy-loaded
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    init = false,
    config = function()
      require "custom.configs.gitsigns"
    end,
  },
  {
    "NvChad/base46",
    event = "VeryLazy",
    config = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "custom.configs.cmp"
    end,
  },
  {
    "folke/which-key.nvim",
    init = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
    end,
    config = function()
      require "custom.configs.whichkey"
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    init = false,
  },
  {
    "NvChad/nvterm",
    enabled = false,
  },
}

return plugins
