local M = {}

local sep_icons = {
  default = { left = "", right = " " },
  round = { left = "", right = "" },
  block = { left = "█", right = "█" },
  arrow = { left = "", right = "" },
}

local function gen_extra_space(sep_style)
  if sep_style == "arrow" then
    return " "
  end

  return ""
end

local function stbufnr()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
end

local function mode(sep_style)
  local modes = require("nvchad.statusline.default").modes
  local is_activewin = vim.api.nvim_get_current_win() == vim.g.statusline_winid

  if not is_activewin then
    return ""
  end

  local m = vim.api.nvim_get_mode().mode
  local sep_r = sep_icons[sep_style].right
  local current_mode = "%#" .. modes[m][2] .. "#" .. "  " .. modes[m][1] .. gen_extra_space(sep_style)
  local mode_sep1 = "%#" .. modes[m][2] .. "Sep" .. "#" .. sep_r
  local mode_sep2 = "%#ST_EmptySpace#" .. sep_r

  return current_mode .. mode_sep1 .. mode_sep2
end

local function lsp_diagnostics()
  if not rawget(vim, "lsp") then
    return ""
  end

  local errors = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.INFO })

  errors = (errors and errors > 0) and ("%#St_lspError#" .. " " .. errors .. " ") or ""
  warnings = (warnings and warnings > 0) and ("%#St_lspWarning#" .. " " .. warnings .. " ") or ""
  hints = (hints and hints > 0) and ("%#St_lspHints#" .. "󰛩 " .. hints .. " ") or ""
  info = (info and info > 0) and ("%#St_lspInfo#" .. "󰋼 " .. info .. " ") or ""

  return errors .. warnings .. hints .. info
end

local function file_encoding()
  local encoding = vim.bo[stbufnr()].fileencoding
  return encoding == "" and "" or ("%#St_FileEncoding#" .. " " .. encoding .. " ")
end

local function cursor_position(sep_style)
  local sep_l = sep_icons[sep_style].left

  -- calculate cursor position as a percentage
  local current_line = vim.fn.line(".", vim.g.statusline_winid)
  local total_line = vim.fn.line("$", vim.g.statusline_winid)
  local percentage = math.modf((current_line / total_line) * 100) .. tostring "%%"
  percentage = string.format("%4s", percentage)

  -- show "Top" or "Bot" at first line or last line instead of percentage
  percentage = (current_line == 1 and "Top") or percentage
  percentage = (current_line == total_line and "Bot") or percentage

  -- to change this module accent color (currently light green for "default" theme),
  -- override the St_pos_sep, St_pos_icon, and St_pos_icon highlights in chadrc
  local icon_block = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#" .. gen_extra_space(sep_style) .. " "
  local percentage_block = "%#St_pos_text#" .. percentage .. " "

  return icon_block .. percentage_block
end

local function ruler(sep_style)
  local sep_l = sep_icons[sep_style].left
  local ruler_sep1 = "%#ST_EmptySpace#" .. sep_l
  local ruler_sep2 = "%#St_RulerSep#" .. sep_l
  local ruler_text = "%#St_RulerText#" .. gen_extra_space(sep_style) .. "%l:%c "

  return ruler_sep1 .. ruler_sep2 .. ruler_text
end

M.get_statusline = function(options)
  return {
    theme = options.theme,
    separator_style = options.style,
    overriden_modules = function(modules)
      if options.theme ~= "default" then
        return
      end

      modules[1] = mode(options.style)
      modules[7] = lsp_diagnostics()
      modules[9] = file_encoding()
      modules[10] = cursor_position(options.style)
      table.insert(modules, ruler(options.style))
    end,
  }
end

return M
