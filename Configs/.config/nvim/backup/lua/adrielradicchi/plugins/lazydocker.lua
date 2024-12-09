return {
  "crnvl96/lazydocker.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    vim.keymap.set(
      "n",
      "<leader>ld",
      "<cmd>LazyDocker<CR>",
      { desc = "Open Lazy Docker", noremap = true, silent = true }
    ),
  },
}
