local M = {}

local function tablist(show_newtab_button)
  local fn = vim.fn
  local result, number_of_tabs = "", fn.tabpagenr "$"

  if number_of_tabs <= 1 then
    return ""
  end

  for i = 1, number_of_tabs, 1 do
    local tab_hl = ((i == fn.tabpagenr()) and "%#TbLineTabOn# ") or "%#TbLineTabOff# "
    result = result .. ("%" .. i .. "@TbGotoTab@" .. tab_hl .. i .. " ")
    result = (i == fn.tabpagenr() and result .. "%#TbLineTabCloseBtn#" .. "%@TbTabClose@󰅙 %X") or result
  end

  local new_tabtn = (show_newtab_button and "%#TblineTabNewBtn#" .. "%@TbNewTab@  %X") or ""
  local tabsTitle = "%#TBTabTitle# Tabs %X"

  return tabsTitle .. result .. new_tabtn
end

local function closeall_button()
  return "%@TbCloseAllBufs@%#TbLineCloseAllBufsBtn#" .. " 󰅖 " .. "%X"
end

M.get_tabufline = function(opts)
  return {
    overriden_modules = function(modules)
      if opts.show_closeall_button then
        modules[3] = closeall_button()
        modules[4] = tablist(opts.show_newtab_button)
      else
        modules[3] = tablist(opts.show_newtab_button)
        table.remove(modules)
      end
    end,
  }
end

return M
