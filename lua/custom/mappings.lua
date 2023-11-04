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
    ["<C-w>"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
    ["<leader>bo"] = {
      function()
        require("nvchad.tabufline").closeOtherBufs()
      end,
      "Close other buffers",
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

M.disabled = {
  n = {
    -- general
    ["<leader>n"] = "",

    -- lspconfig
    ["<leader>lf"] = "",
    ["K"] = "",

    -- nvterm
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
  },

  t = {
    -- nvterm
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
  },
}

return M
