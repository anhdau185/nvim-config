local default_opts = require("plugins.configs.others").gitsigns

local opts = vim.tbl_deep_extend("force", default_opts, {
  signs = {
    add = { text = "┃" },
    untracked = { text = "┃" },
    change = { text = "┃" },
    changedelete = { text = "┃╴" },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "right_align",
    delay = 800,
  },
})

return opts
