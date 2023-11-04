local opts = {
  home = vim.fn.expand "~/zettelkasten",
}

vim.keymap.set("n", "<leader>np", "<cmd>Telekasten panel<CR>", { desc = "Telekasten show panel" })
vim.keymap.set("n", "<leader>nn", "<cmd>Telekasten new_note<CR>", { desc = "Telekasten new note" })
vim.keymap.set("n", "<leader>nf", "<cmd>Telekasten find_notes<CR>", { desc = "Telekasten find notes" })
vim.keymap.set("n", "<leader>nw", "<cmd>Telekasten search_notes<CR>", { desc = "Telekasten search notes" })
vim.keymap.set("n", "<leader>nd", "<cmd>Telekasten goto_today<CR>", { desc = "Telekasten go to today" })
vim.keymap.set("n", "<leader>nt", "<cmd>Telekasten goto_thisweek<CR>", { desc = "Telekasten go to this week" })
vim.keymap.set("n", "<leader>nc", "<cmd>Telekasten show_calendar<CR>", { desc = "Telekasten show calendar" })

return opts
