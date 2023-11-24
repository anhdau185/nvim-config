local default_opts = require "plugins.configs.telescope"
local actions = require "telescope.actions"

local EXCLUDE_PATTERN = "**/{.git,node_modules}/**"
local RG_GLOB_PATTERN = "!" .. EXCLUDE_PATTERN

-- all defaults: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua#L133
local mappings = {
  ["<C-k>"] = actions.move_selection_previous,
  ["<C-j>"] = actions.move_selection_next,
  ["<C-h>"] = actions.preview_scrolling_left,
  ["<C-l>"] = actions.preview_scrolling_right,
  ["<C-e>"] = actions.close,

  -- Switch to live_grep_args retaining the current prompt
  ["<C-g>"] = function(prompt_bufnr)
    local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
    local prompt = vim.trim(current_picker:_get_prompt())

    if prompt == "" then
      return
    end

    local rg_args = " -. -L -g " .. RG_GLOB_PATTERN .. " " -- equivalent to: --hidden --follow --glob "pattern"
    prompt = require("telescope-live-grep-args.helpers").quote(prompt, { quote_char = '"' })
    prompt = prompt .. rg_args

    vim.schedule(function()
      require("telescope").extensions.live_grep_args.live_grep_args { default_text = prompt }
    end)
    actions.close(prompt_bufnr)
  end,
}

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
    mappings = {
      i = mappings,
      n = mappings,
    },
  },

  pickers = {
    find_files = {
      find_command = { "fd", "--type", "file", "--hidden", "--follow", "--exclude", EXCLUDE_PATTERN },
    },
    live_grep = {
      additional_args = { "--hidden", "--follow" },
      glob_pattern = { RG_GLOB_PATTERN },
    },
    lsp_references = { show_line = false },
    lsp_definitions = { show_line = false },
  },
})

-- in order to load_extension this at lua/plugins/init.lua:247
table.insert(opts.extensions_list, "live_grep_args")

return opts
