vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars:append { tab = "→ ", space = "·", trail = "·" }
vim.opt.fillchars:append { diff = "╱" }
vim.keymap.set({ "n", "x", "o" }, "$", "g_", { desc = "" })

-- custom neovim startup stuff
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    vim.schedule(function()
      local utils = require "custom.utils"
      local is_dir = utils.is_dir(data.file)

      -- open nvimtree and telescope for file browsing if neovim was opened in a directory
      if is_dir then
        require("nvim-tree.api").tree.open()
        require("telescope.builtin").find_files()
        return
      end

      -- close the redundant auto-generated buffer if neovim was opened with files
      local bufs = vim.api.nvim_list_bufs()
      if #bufs == 0 then
        return
      end

      local last_buf = bufs[#bufs]
      local no_filetype = utils.get_filetype(last_buf) == nil
      local empty = utils.get_buf_content(last_buf) == ""

      if no_filetype and empty then
        vim.api.nvim_buf_delete(last_buf, { force = true })
      end
    end)

    -- disable inline diagnostics signs to reduce visual noise in the signcolumn
    vim.schedule(function()
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        underline = true,
        signs = false,
        update_in_insert = false,
      })
    end)

    vim.schedule(function()
      vim.cmd "packadd cfilter" -- lazy-load cfilter to enhance quickfix list
    end)
  end,
})

-- cleanups on neovim exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    require("nvim-tree.api").tree.close()
  end,
})
