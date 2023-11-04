-- load gitsigns only when a git file is opened
vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
  callback = function()
    vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
    if vim.v.shell_error == 0 then
      vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
      vim.schedule(function()
        require("lazy").load { plugins = { "gitsigns.nvim" } }
      end)
    end
  end,
})

dofile(vim.g.base46_cache .. "git")
local default_opts = require("plugins.configs.others").gitsigns
local opts = vim.tbl_deep_extend("force", default_opts, {
  signs = {
    add = { text = "┃" },
    untracked = { text = "┃" },
    change = { text = "┃" },
    changedelete = { text = "┃╴" },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "right_align",
    delay = 800,
  },
})

require("gitsigns").setup(opts)
