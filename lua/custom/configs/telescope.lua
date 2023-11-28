local actions = require "telescope.actions"
local utils = require "custom.utils"
local default_opts = require "plugins.configs.telescope"

local fd_exclude_glob = utils.fd_exclude_glob()
local rg_exclude_glob = utils.rg_exclude_glob()

-- Switch to "Find all files" with current prompt retained
local function switch_to_find_all_files(prompt_bufnr)
  local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local prompt = picker:_get_prompt()

  actions.close(prompt_bufnr)
  require("telescope.builtin").find_files {
    find_command = {
      "fd",
      "--type",
      "file",
      "--follow",
      "--hidden",
      "--no-ignore",
      "--exclude",
      fd_exclude_glob,
    },
    default_text = prompt,
  }
end

-- Switch to "Live grep with args" with current prompt retained
local function switch_to_live_grep_args(prompt_bufnr)
  local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local prompt = picker:_get_prompt()
  if prompt == "" then
    return
  end

  local rg_search_pattern = require("telescope-live-grep-args.helpers").quote(prompt, { -- only quoted patterns work
    quote_char = '"',
  })
  local rg_default_args = string.format(" -L -g %s ", rg_exclude_glob) -- add -uu flag to find in ALL files (does not respect .gitignore)
  local new_prompt = rg_search_pattern .. rg_default_args

  actions.close(prompt_bufnr)
  require("telescope").extensions.live_grep_args.live_grep_args {
    default_text = new_prompt,
  }
end

local opts = vim.tbl_deep_extend("force", default_opts, {
  defaults = {
    layout_config = {
      horizontal = { preview_width = 0.5 },
      width = 0.96,
      height = 0.93,
    },
    wrap_results = true,
    prompt_prefix = "", -- no prefix icon
    get_status_text = function(picker, opts) -- how prompt counter should be displayed
      local results_count = (picker.stats.processed or 0) - (picker.stats.filtered or 0)
      local status_icon = ""

      if opts and not opts.completed then
        status_icon = "*"
      end

      if results_count == 0 then
        return status_icon
      end
      return string.format("%s(%s)", status_icon, results_count)
    end,
    mappings = { -- all defaults: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua#L133
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
      mappings = {
        i = {
          ["<C-a>"] = switch_to_find_all_files,
        },
        n = {
          ["<C-a>"] = switch_to_find_all_files,
        },
      },
    },
    live_grep = {
      additional_args = { "--follow" },
      glob_pattern = { rg_exclude_glob },
      mappings = {
        i = {
          ["<C-g>"] = switch_to_live_grep_args,
        },
        n = {
          ["<C-g>"] = switch_to_live_grep_args,
        },
      },
    },
    current_buffer_fuzzy_find = {
      skip_empty_lines = true,
      results_ts_highlight = false,
    },
    command_history = {
      mappings = {
        i = {
          ["<C-e>"] = actions.close,
          ["<C-c>"] = actions.edit_command_line,
        },
        n = {
          ["<C-e>"] = actions.close,
          ["<C-c>"] = actions.edit_command_line,
        },
      },
    },
    search_history = {
      mappings = {
        i = {
          ["<C-e>"] = actions.close,
          ["<C-c>"] = actions.edit_search_line,
        },
        n = {
          ["<C-e>"] = actions.close,
          ["<C-c>"] = actions.edit_search_line,
        },
      },
    },
    registers = {
      mappings = {
        i = {
          ["<C-e>"] = actions.close,
          ["<C-c>"] = actions.edit_register,
        },
        n = {
          ["<C-e>"] = actions.close,
          ["<C-c>"] = actions.edit_register,
        },
      },
    },
    git_status = {
      initial_mode = "normal",
      mappings = {
        i = {
          ["<C-s>"] = actions.git_staging_toggle,
        },
        n = {
          ["s"] = actions.git_staging_toggle,
        },
      },
    },
    lsp_references = {
      show_line = false,
      initial_mode = "normal",
    },
    lsp_definitions = {
      show_line = false,
      initial_mode = "normal",
    },
  },
})

-- in order for this extension to be loaded at lua/plugins/init.lua:247
table.insert(opts.extensions_list, "live_grep_args")

return opts
