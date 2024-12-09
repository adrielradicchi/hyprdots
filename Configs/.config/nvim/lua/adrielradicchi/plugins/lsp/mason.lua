return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "lua_ls",
        "efm",
        "gopls",
        "golangci_lint_ls",
        "pyright",
        "elixirls",
        "rubocop",
        "solargraph",
        "jsonls",
        "helm_ls",
        "yamlls",
        "dockerls",
        "sqlls",
        "rust_analyzer",
        "ts_ls",
        "eslint",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint",

        -- golang
        "golangci_lint_ls",
        "gci",
        "go-debug-adapter",
        "gofumpt",
        "goimports",
        "goimports-reviser",
        "golangci-lint",
        "gotests",

        "rubocop",
        "yamllint",
      },
    })
  end,
}
