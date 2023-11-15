local configs = require "plugins.configs.lspconfig" -- this also sets up the lua-language-server
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local NODE_MODULES_PATTERN = "node_modules/"

-- set up JS/TS language server
lspconfig.tsserver.setup {
  root_dir = function(filename, bufnr)
    local inside_node_modules = string.find(filename, NODE_MODULES_PATTERN)
    if inside_node_modules then -- avoid starting language server inside node_modules
      return nil
    end
    return require("lspconfig.server_configurations.tsserver").default_config.root_dir(filename, bufnr)
  end,
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
}

-- set up eslint-lsp
lspconfig.eslint.setup {
  root_dir = function(filename, bufnr)
    local inside_node_modules = string.find(filename, NODE_MODULES_PATTERN)
    if inside_node_modules then -- avoid linting inside node_modules due to performance issues
      return nil
    end
    return require("lspconfig.server_configurations.eslint").default_config.root_dir(filename, bufnr)
  end,
  capabilities = capabilities,
  on_attach = on_attach,

  -- all default server configurations can be found at
  -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/eslint.lua
  settings = {
    validate = "on",
    format = false,
    quiet = false,
  },
}

-- set up Rust development tools
require("rust-tools").setup {
  server = {
    standalone = true,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          allFeatures = true,
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
      },
    },
  },
}
