local M = {}

M.general = {
  n = {
    -- navigate tmux panes in normal mode
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "Window left" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "Window right" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "Window down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "Window up" },

    -- navigate tabpages
    ["<leader>tp"] = { "<cmd>tabprevious<CR>", "Previous tab" },
    ["<leader>tn"] = { "<cmd>tabnext<CR>", "Next tab" },
    ["<leader>tc"] = { "<cmd>tabclose<CR>", "Close tab" },
    ["<leader>to"] = {
      function()
        if #vim.api.nvim_list_tabpages() > 1 then
          vim.cmd "tabnext 1 | tabonly" -- close any open secondary tabs before quitting
        end
      end,
      "Close all tabs but primary tab",
    },

    -- copy relative path to current file
    ["<leader>cp"] = {
      function()
        local rel_path = require("custom.utils").path_to_current_buf()
        vim.fn.setreg("+", rel_path)
        print("Path copied: " .. rel_path)
      end,
      "Copy relative path to file",
    },
  },
}

M.tabufline = {
  n = {
    -- close multiple buffers
    ["<leader>bo"] = {
      function()
        require("nvchad.tabufline").closeOtherBufs()
      end,
      "Close other buffers",
    },
    ["<leader>br"] = {
      function()
        require("nvchad.tabufline").closeBufs_at_direction "right"
      end,
      "Close buffers to the right",
    },
    ["<leader>ba"] = {
      function()
        require("nvchad.tabufline").closeAllBufs()
        vim.schedule(function()
          require("telescope.builtin").find_files() -- open find_files prompt after closing all buffers
        end)
      end,
      "Close all buffers",
    },

    -- move current buffer
    ["<leader>bh"] = {
      function()
        require("nvchad.tabufline").move_buf(-1)
      end,
      "Move buffer to the left",
    },
    ["<leader>bl"] = {
      function()
        require("nvchad.tabufline").move_buf(1)
      end,
      "Move buffer to the right",
    },
  },
}

M.lspconfig = {
  n = {
    ["gh"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },
    ["ga"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
    ["gH"] = {
      function()
        vim.diagnostic.open_float { border = "single" }
      end,
      "Floating diagnostic",
    },
  },

  v = {
    ["<leader>ga"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}

M.telescope = {
  n = {
    ["gt"] = {
      function()
        require("telescope.builtin").git_status()
      end,
      "Git status",
    },
    ["gm"] = {
      function()
        require("telescope.builtin").git_commits()
      end,
      "Git commits",
    },
    ["gs"] = {
      function()
        require("telescope.builtin").git_stash()
      end,
      "Git stash",
    },
    ["dx"] = {
      function()
        require("telescope.builtin").diagnostics { bufnr = 0 }
      end,
      "Document diagnostics",
    },
    ["gd"] = {
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      "Find definition",
    },
    ["gr"] = {
      function()
        require("telescope.builtin").lsp_references {
          include_current_line = true,
        }
      end,
      "Find all references",
    },
    ["<leader>gr"] = {
      function()
        require("telescope.builtin").lsp_references {
          include_current_line = false,
          default_text = require("custom.utils").path_to_current_buf(),
        }
      end,
      "Find references within document",
    },
    ["<leader>fa"] = {
      function()
        require("telescope.builtin").find_files {
          find_command = {
            "fd",
            "--type",
            "file",
            "--follow",
            "--hidden",
            "--no-ignore",
            "--exclude",
            require("custom.utils").fd_exclude_glob(),
          },
        }
      end,
      "Find all files",
    },
    ["<leader>fW"] = {
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      "Live grep with args",
    },
    ["<leader>fq"] = {
      function()
        require("telescope.builtin").quickfixhistory()
      end,
      "Quickfix history",
    },
    ["<leader>fp"] = {
      function()
        require("telescope.builtin").builtin()
      end,
      "All builtin pickers",
    },

    -- clear all unimportant local marks before showing the mark list to make it cleaner and more readable
    ["<leader>ma"] = {
      function()
        vim.cmd [[ delmarks a-z0-9\"<>[]^. ]]
        vim.cmd "Telescope marks"
      end,
      "Show global bookmarks",
    },
  },
  v = {
    ["<leader>fw"] = {
      function()
        require("telescope.builtin").live_grep {
          default_text = require("custom.utils").get_visual_selection(),
        }
      end,
      "Find visual selection",
    },
    ["<leader>fz"] = {
      function()
        require("telescope.builtin").current_buffer_fuzzy_find {
          default_text = require("custom.utils").get_visual_selection(),
        }
      end,
      "Find visual selection in current buffer",
    },
  },
}

M.gitsigns = {
  n = {
    -- Navigation through hunks
    ["<leader>h["] = {
      function()
        package.loaded.gitsigns.prev_hunk()
      end,
      "Jump to prev hunk",
    },
    ["<leader>h]"] = {
      function()
        package.loaded.gitsigns.next_hunk()
      end,
      "Jump to next hunk",
    },

    -- Actions
    ["<leader>hp"] = {
      function()
        package.loaded.gitsigns.preview_hunk()
      end,
      "Preview hunk",
    },
    ["<leader>hr"] = {
      function()
        package.loaded.gitsigns.reset_hunk()
      end,
      "Reset hunk",
    },
    ["<leader>hs"] = {
      function()
        package.loaded.gitsigns.stage_hunk()
      end,
      "Stage hunk",
    },
    ["gB"] = {
      function()
        package.loaded.gitsigns.blame_line { full = true }
      end,
      "Hover-blame line",
    },
  },
}

M.disabled = {
  n = {
    -- general
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
    ["<leader>b"] = "",
    ["<leader>fm"] = "",

    -- lspconfig
    ["<leader>q"] = "",
    ["<leader>lf"] = "",
    ["<leader>ca"] = "",
    ["K"] = "",

    -- telescope
    ["<leader>th"] = "",
    ["<leader>gt"] = "",
    ["<leader>cm"] = "",
    ["<leader>pt"] = "",

    -- nvterm
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",

    -- gitsigns
    ["]c"] = "",
    ["[c"] = "",
    ["<leader>rh"] = "",
    ["<leader>ph"] = "",
    ["<leader>gb"] = "",
    ["<leader>td"] = "",
  },

  v = {
    -- lspconfig
    ["<leader>ca"] = "",
  },

  t = {
    -- nvterm
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
  },
}

return M
