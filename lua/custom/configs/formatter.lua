local conform = require "conform"

require("conform").setup {
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    rust = { "rustfmt" },
  },
  format_on_save = {
    async = false,
    lsp_fallback = true,
    timeout_ms = 800,
    quiet = true,
  },
}

vim.keymap.set("n", "<leader>mp", function()
  conform.format {
    async = true,
    lsp_fallback = true,
  }
end, { desc = "Format document" })
