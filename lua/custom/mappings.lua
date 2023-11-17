local M = {}

M.general = {
  n = {
    -- navigate tmux panes in normal mode
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft <CR>", "Window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight <CR>", "Window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown <CR>", "Window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp <CR>", "Window up" },

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
      "Move current buffer to the left",
    },
    ["<leader>bl"] = {
      function()
        require("nvchad.tabufline").move_buf(1)
      end,
      "Move current buffer to the right",
    },
  },
}

M.lsgconfig = {
  n = {
    ["gh"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },
    ["gH"] = {
      function()
        vim.diagnostic.open_float { border = "single" }
      end,
      "Floating diagnostic",
    },
  },
}

M.telescope = {
  n = {
    ["dx"] = { "<cmd> Telescope diagnostics bufnr=0 <CR>", "Document diagnostics" },
    ["gr"] = { "<cmd> Telescope lsp_references include_current_line=true <CR>", "Find all references" },
    ["gd"] = { "<cmd> Telescope lsp_definitions <CR>", "Find definition" },

    -- clear all unimportant local marks before showing the mark list to make it cleaner and more readable
    ["<leader>ma"] = {
      function()
        vim.cmd [[ delmarks a-z0-9\"<>[]^. ]]
        vim.cmd "Telescope marks"
      end,
      "Show global bookmarks",
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

    -- lspconfig
    ["<leader>q"] = "",
    ["<leader>lf"] = "",
    ["K"] = "",

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

  t = {
    -- nvterm
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
  },
}

return M
