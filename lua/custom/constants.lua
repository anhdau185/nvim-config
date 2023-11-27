local M = {}

-- List of projects to perform auto-generated buffer removal on startup
M.WHITELIST = {
  "nvim",
  "frontend-core",
  "employment-hero",
  "ipsniffer",
}

-- List of folders to exclude from telescope.builtin.find_files
M.FD_EXCLUDE = {
  ".git",
  "node_modules",
}

-- List of folders to exclude from telescope.builtin.live_grep
M.RG_EXCLUDE = {
  ".git",
  "node_modules",
  "build",
  "dist",
  "bin",
}

return M
