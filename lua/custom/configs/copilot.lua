local opts = {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 50,
    keymap = {
      accept = "<Tab>",
      accept_word = "<C-l>",
      dismiss = "<S-Tab>",
    },
  },
}

return opts
