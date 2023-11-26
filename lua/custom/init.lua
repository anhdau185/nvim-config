table.unpack = table.unpack or unpack -- Lua 5.1 compatibility

vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars:append { tab = "→ ", space = "·", trail = "·" }
vim.opt.fillchars:append { diff = "╱" }

-- remap keys
vim.keymap.set({ "n", "x", "o" }, "$", "g_", { desc = "" })
vim.keymap.set({ "n" }, "<C-g>", function()
  local utils = require "custom.utils"
  local rel_path = utils.path_to_current_buf()
  local ln, col = utils.get_cursor_pos()
  local display_path = string.format("%s:%s:%s", rel_path, ln, col)
  print(display_path)
end, { desc = "" })

-- custom neovim startup stuff
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    -- initial workspace setup
    vim.schedule(function()
      local utils = require "custom.utils"

      -- open nvimtree and telescope for file browsing if neovim was opened in a directory
      if utils.is_dir(data.file) then
        require("nvim-tree.api").tree.open()
        require("telescope.builtin").find_files()
        return
      end

      -- close the redundant auto-generated buffer if neovim was opened with files
      -- only if the project is whitelisted in custom.projects:WHITELIST
      local bufs = vim.api.nvim_list_bufs()
      local proj_excluded = not utils.is_proj_whitelisted()

      if proj_excluded or #bufs == 0 then
        return
      end

      local last_buf = bufs[#bufs]
      local no_filetype = utils.get_filetype(last_buf) == nil
      local empty = utils.get_buf_content(last_buf) == ""

      if no_filetype and empty then
        vim.api.nvim_buf_delete(last_buf, { force = true })
      end
    end)

    -- lazy-load necessary vim packages
    vim.schedule(function()
      vim.cmd "packadd cfilter" -- for filtering quickfix list items
    end)
  end,
})

-- cleanups on neovim exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    require("nvim-tree.api").tree.close()
  end,
})

vim.api.nvim_create_user_command("Q", function()
  if #vim.api.nvim_list_tabpages() > 1 then
    vim.cmd "tabnext 1 | tabonly | quitall" -- close any open secondary tabs before quitting
  else
    vim.cmd "quitall"
  end
end, {})
