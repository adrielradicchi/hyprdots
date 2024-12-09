return {
  "https://git.sr.ht/~swaits/zellij-nav.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {
    { "<leader>sc", "Zellij Navigate Window<CR>", { silent = true, desc = "Zellij Navigate Window" } },
    { "<leader>sca", "<cmd>ZellijNavigateLeft<cr>", { silent = true, desc = "navigate left" } },
    { "<leader>scs", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
    { "<leader>scw", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
    { "<leader>scd", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
  },
  opts = {},
}
