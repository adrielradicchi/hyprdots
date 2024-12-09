return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local status_ok, toggleterm = pcall(require, "toggleterm")
    if not status_ok then
      return
    end

    toggleterm.setup({
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })

    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    local Terminal = require("toggleterm.terminal").Terminal
    local lazysql = Terminal:new({ cmd = "lazysql", hidden = true })

    function _LAZYSQL_TOGGLE()
      lazysql:toggle()
    end

    local lazykube = Terminal:new({ cmd = "lazykube", hidden = true })

    function _LAZYKUBE_TOGGLE()
      lazykube:toggle()
    end

    vim.keymap.set("n", "<leader>r", ":bfirst<CR>", { desc = "Terminal" })
    vim.keymap.set("n", "<leader>rf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Open terminal (Float)" })
    vim.keymap.set(
      "n",
      "<leader>rh",
      "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
      { desc = "Open terminal (Horizontal)" }
    )
    vim.keymap.set(
      "n",
      "<leader>rv",
      "<cmd>ToggleTerm size=80 direction=vertical<cr>",
      { desc = "Open terminal (Vertical)" }
    )
    vim.keymap.set("n", "<leader>ls", "<cmd>lua _LAZYSQL_TOGGLE()<cr>", { desc = "Open Lazy SQL" })
    vim.keymap.set("n", "<leader>lk", "<cmd>lua _LAZYKUBE_TOGGLE()<CR>", { desc = "Open Lazy Kube" })
  end,
}
