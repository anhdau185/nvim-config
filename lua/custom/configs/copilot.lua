local opts = {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 50,
    keymap = {
      accept = "<Tab>",
      accept_line = "<C-]>",
      accept_word = "<C-l>",
      dismiss = "<C-h>",
    },
  },
}

return opts
