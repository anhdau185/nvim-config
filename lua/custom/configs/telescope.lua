local default_opts = require "plugins.configs.telescope"
local actions = require "telescope.actions"

local opts = vim.tbl_deep_extend("force", default_opts, {
  defaults = {
    layout_config = {
      horizontal = {
        preview_width = 0.5,
      },
      width = 0.96,
      height = 0.92,
    },
    wrap_results = true,
    prompt_prefix = "", -- no prefix icon

    -- all defaults: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua#L133
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-h>"] = actions.preview_scrolling_left,
        ["<C-l>"] = actions.preview_scrolling_right,
        ["<C-e>"] = actions.close,
      },
      n = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-h>"] = actions.preview_scrolling_left,
        ["<C-l>"] = actions.preview_scrolling_right,
        ["<C-e>"] = actions.close,
      },
    },
  },

  pickers = {
    find_files = {
      find_command = { "fd", "--type", "file", "--hidden", "--follow", "--exclude", "**/{.git,node_modules}/**" },
    },
    live_grep = {
      additional_args = { "--hidden", "--follow" },
      glob_pattern = { "!**/{.git,node_modules}/**" },
    },
    lsp_references = { show_line = false },
    lsp_definitions = { show_line = false },
  },
})

return opts
