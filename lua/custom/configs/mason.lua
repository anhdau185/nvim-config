local default_opts = require "plugins.configs.mason"

local opts = vim.tbl_deep_extend("force", default_opts, {
  ensure_installed = {
    "lua-language-server",
    "typescript-language-server",
    "eslint-lsp",
    "rust-analyzer",
    "prettier",
    "stylua",
    "rustfmt",
  },
})

return opts
