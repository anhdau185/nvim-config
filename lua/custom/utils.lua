local M = {}

M.is_dir = function(path)
  return vim.fn.isdirectory(path) ~= 0
end

M.path_to_current_buf = function()
  local plenary = require "plenary"
  local buf_name = vim.api.nvim_buf_get_name(0)

  return plenary.path:new(buf_name):make_relative()
end

M.path_to_current_dir = function()
  local plenary = require "plenary"
  local buf_name = vim.api.nvim_buf_get_name(0)

  return plenary.path:new(buf_name):make_relative():gsub("/[^/]+$", "/")
end

M.get_cursor_pos = function()
  local ln, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  local is_blank_line = vim.api.nvim_get_current_line() == ""
  local one_based_col = (is_blank_line and 0) or col + 1 -- original col is 0-based, this converts it to 1-based in a non-blank line

  return ln, one_based_col
end

M.get_filetype = function(buf)
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")

  if ft == "" then
    return nil
  end
  return ft
end

M.get_buf_content = function(buf)
  return table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
end

M.is_proj_whitelisted = function()
  local proj_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

  if proj_name == nil or proj_name == "" then
    return false
  end
  return vim.tbl_contains(require("custom.constants").WHITELIST, proj_name)
end

M.fd_exclude_glob = function()
  local exclude = table.concat(require("custom.constants").FD_EXCLUDE, ",")
  return string.format("**/{%s}/**", exclude)
end

M.rg_exclude_glob = function()
  local exclude = table.concat(require("custom.constants").RG_EXCLUDE, ",")
  return string.format("!**/{%s}/**", exclude)
end

-- when in visual mode, get the currently selected text and then exit visual mode
M.get_visual_selection = function()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg "v"
  vim.fn.setreg("v", {})
  text = string.gsub(text, "\n", "")

  if #text > 0 then
    return text
  end
  return ""
end

return M
