local actions = require "telescope.actions"
local default_opts = require "plugins.configs.telescope"

local EXCLUDE_GLOB_PATTERN = "**/{.git,node_modules}/**"
local RG_GLOB_PATTERN = "!" .. EXCLUDE_GLOB_PATTERN
local RG_DEFAULT_ARGS = " -. -L -g " .. RG_GLOB_PATTERN .. " " -- equivalent to: --hidden --follow --glob !**/{.git,node_modules}/**

-- all defaults: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua#L133
local common_mappings = {
  ["<C-k>"] = actions.move_selection_previous,
  ["<C-j>"] = actions.move_selection_next,
  ["<C-h>"] = actions.preview_scrolling_left,
  ["<C-l>"] = actions.preview_scrolling_right,
  ["<C-e>"] = actions.close,

  -- Switch to live_grep_args retaining the current prompt
  ["<C-g>"] = function(prompt_bufnr)
    local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
    local prompt = vim.trim(picker:_get_prompt())

    if prompt == "" then
      return
    end

    local rg_search_pattern =
      require("telescope-live-grep-args.helpers").quote(prompt, { -- pattern should be quoted in case of whitespace
        quote_char = '"',
      })
    local new_prompt = rg_search_pattern .. RG_DEFAULT_ARGS

    vim.schedule(function()
      require("telescope").extensions.live_grep_args.live_grep_args {
        default_text = new_prompt,
      }
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
      i = common_mappings,
      n = common_mappings,
    },
  },

  pickers = {
    find_files = {
      find_command = { "fd", "--type", "file", "--hidden", "--follow", "--exclude", EXCLUDE_GLOB_PATTERN },
    },
    live_grep = {
      additional_args = { "--hidden", "--follow" },
      glob_pattern = { RG_GLOB_PATTERN },
    },
    lsp_references = { show_line = false },
    lsp_definitions = { show_line = false },
  },
})

-- in order to for this extension to be loaded at lua/plugins/init.lua:247
table.insert(opts.extensions_list, "live_grep_args")

return opts
