return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    { "<leader>m", ":bfirst<CR>", { desc = "Format file" } },
    {
      "<leader>mp",
      function()
        require("conform").format(
          {
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
            quiet = true,
          }
          -- ,
          -- function(_err)
          --   if not err then
          --     local mode = vim.api.nvim_get_mode().mode
          --     if vim.startswith(string.lower(mode), "v") then
          --       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
          --     end
          --   end
          -- end
        )
      end,
      { mode = "", desc = "Format file or range (in visual mode)" },
    },
  },
  --- @module "conform"
  --- @type conform.setupOpts
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofumpt", "goimports-reviser" },
      elixir = { "mix format" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
      quiet = true,
    },
    formatters = {
      elixir = { "mix format" },
      go = { "goimports", "gofumpt", "goimports-reviser" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
