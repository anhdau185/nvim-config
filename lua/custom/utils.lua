local M = {}

M.is_dir = function(path)
  return vim.fn.isdirectory(path) ~= 0
end

M.path_to_current_buf = function()
  local plenary = require "plenary"
  local buf_name = vim.api.nvim_buf_get_name(0)

  return plenary.path:new(buf_name):make_relative()
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

return M
