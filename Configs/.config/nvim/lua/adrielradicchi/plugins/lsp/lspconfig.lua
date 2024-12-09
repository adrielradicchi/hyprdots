return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Languages Servers"
        keymap.set("n", "<leader>p", ":bfirst<CR>", opts)

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>pa", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>pn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>pD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>pd", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>ps", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["efm"] = function()
        lspconfig["efm"].setup({
          capabilities = capabilities,
          filetypes = { "lua", "elixir", "eelixir", "heex" },
        })
      end,
      ["elixirls"] = function() -- configure language server for elixir
        lspconfig["elixirls"].setup({
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          },
          settings = {
            elixirLS = {
              -- autoBuild = false,
              dialyzerEnabled = true,
              incrementalDialyzer = true,
              -- dialyzerWarnOpts = true,
              dialyzerFormat = "dialyxir_long",
              fetchDeps = false,
              enableTestLenses = true,
              testLenses = true,
              -- projectDir = false,
              -- suggestSpecs = true,
              -- traceServer = true,
              -- autoInsertRequiredAlias = true,
              -- signtureAfterComplete = true,
              -- additionalWatchedExtensions = false,
              -- languageServerOverridePath = false,
            },
          },
          filetypes = { "elixir", "eelixir", "heex", "surface" },
          cmd = { "elixir-ls" },
        })
      end,
      ["golangci_lint_ls"] = function()
        lspconfig["golangci_lint_ls"].setup({
          capabilities = capabilities,
          default_config = {
            cmd = { "golangci-lint-langserver" },
            root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
            init_options = {
              command = {
                "golangci-lint",
                "run",
                "--enable-all",
                "--disable",
                "lll",
                "--out-format",
                "json",
                "--issues-exit-code=1",
              },
            },
          },
          filetypes = { "go", "gomod" },
        })
      end,
      ["gopls"] = function() -- configure language server for golang
        lspconfig["gopls"].setup({
          capabilities = capabilities,
          default_config = {
            gopls = {
              analyses = {
                assign = true,
                atomic = true,
                bools = true,
                composites = true,
                copylocks = true,
                deepequalerrors = true,
                embed = true,
                errorsas = true,
                fieldalignment = true,
                httpresponse = true,
                ifaceassert = true,
                loopclosure = true,
                lostcancel = true,
                nilfunc = true,
                nilness = true,
                nonewvars = true,
                printf = true,
                shadow = true,
                shift = true,
                simplifycompositelit = true,
                simplifyrange = true,
                simplifyslice = true,
                sortslice = true,
                stdmethods = true,
                stringintconv = true,
                structtag = true,
                testinggoroutine = true,
                tests = true,
                timeformat = true,
                unmarshal = true,
                unreachable = true,
                unsafeptr = true,
                unusedparams = true,
                unusedresult = true,
                unusedvariable = true,
                unusedwrite = true,
                useany = true,
              },
              completeUnimported = true,
              staticcheck = true,
              gofumpt = true,
              hoverKind = "FullDocumentation",
              linkTarget = "pkg.go.dev",
              usePlaceholders = true,
              vulncheck = "Imports",
            },
          },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          cmd = { "gopls" },
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}
