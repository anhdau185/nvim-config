local default_opts = require "plugins.configs.treesitter"

local opts = vim.tbl_deep_extend("force", default_opts, {
  ensure_installed = { "lua", "javascript", "typescript", "ruby", "rust", "toml", "markdown" },
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ident = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
})

return opts
