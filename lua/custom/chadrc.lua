---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "catppuccin",
  hl_add = {
    St_FileEncoding = {
      fg = "NONE",
      bg = "#232232",
      bold = true,
    },
    St_RulerText = {
      fg = "#1e1d2d",
      bg = "#8bc2f0",
      bold = true,
    },
    St_RulerSep = {
      fg = "#8bc2f0",
      bg = "#474656",
    },
    GitSignsChange = {
      fg = "#f9e2af",
      bg = "NONE",
    },

    -- for both GitSignsDelete and GitSignsTopdelete, whose hunks are
    -- represented with a character, not a vertical bar like Add or Change
    -- so `bold = true` is important here to make the character more noticeable
    GitSignsDelete = {
      fg = "#f38ba8",
      bg = "NONE",
      bold = true,
    },
  },
  hl_override = {
    Visual = {
      bg = "#6d5f7c",
    },
    Search = {
      bg = "#69d3e6",
    },
    NormalFloat = {
      bg = "NONE",
    },
    DiffAdd = {
      fg = "NONE",
      bg = "#373f37",
    },
    DiffChange = {
      fg = "NONE",
      bg = "#48350b",
    },
    DiffText = {
      fg = "NONE",
      bg = "#825f13",
    },
    DiffDelete = {
      fg = "NONE",
      bg = "#442128",
    },
    St_pos_icon = {
      fg = "#d9e0ee",
      bg = "#2f2e3e",
    },
    St_pos_text = {
      fg = "#d9e0ee",
      bg = "#2f2e3e",
    },
    St_pos_sep = {
      fg = "#2f2e3e",
      bg = "#232232",
    },
  },
  telescope = {
    style = "bordered",
  },
  tabufline = require("custom.configs.tabufline").get_tabufline {
    show_closeall_button = false, -- allows closing all buffers within a tab in one click
    show_newtab_button = false, -- only shows when there are more than one tab
  },
  statusline = require("custom.configs.statusline").get_statusline {
    theme = "default",
    style = "block",
  },
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M
