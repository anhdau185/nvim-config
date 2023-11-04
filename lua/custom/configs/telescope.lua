local default_opts = require "plugins.configs.telescope"

local opts = vim.tbl_deep_extend("force", default_opts, {
  defaults = {
    layout_config = {
      horizontal = {
        preview_width = 0.5,
      },
      width = 0.92,
      height = 0.88,
    },
    wrap_results = true,
  },
})

return opts
