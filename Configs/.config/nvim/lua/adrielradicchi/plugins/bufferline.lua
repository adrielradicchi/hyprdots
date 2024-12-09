return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          separator = true,
          text_align = "center",
        },
      },
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d%",
      left_mouse_command = "buffer %d%",
      indicator = {
        style = "icon",
        icon = "▎",
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "󰅖",
        left_trunc_marker = "",
        right_trunc_marker = "",
      },
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "")
          s = s .. n .. sym
        end
        return s
      end,
      -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
      show_close_icon = true,
      show_buffer_close_icons = true,
      color_icons = true,
      always_show_bufferline = true,
      houver = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
    vim.keymap.set("n", "<leader>b", "+Buffers")
    vim.keymap.set("n", "<leader>bd", "<CMD>BufferLineSortByDirectory<CR>", { desc = "Buffer line Sort by Directory" })
    vim.keymap.set("n", "<leader>bg", "<cmd>BufferlineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
    vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Delete Other Buffers" })
    vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
    vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
    vim.keymap.set("n", "<leader>bp", "<CMD>BufferLinePick<CR>", { desc = "Buffer line pick" })
    vim.keymap.set("n", "<leader>bs", "<CMD>BufferLinePickClose<CR>", { desc = "Buffer line pick close" })
    vim.keymap.set("n", "<leader>bc", "<cmd>:bd!<cr>", { desc = "Buffer line delete current buffer" })
    vim.keymap.set("n", "<S-l>", "<CMD>BufferLineCycleNext<CR>")
    vim.keymap.set("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>")
    vim.keymap.set("n", "]b", "<CMD>BufferLineCycleNext<CR>")
    vim.keymap.set("n", "[b", "<CMD>BufferLineCyclePrev<CR>")
    vim.keymap.set("n", "]B", "<CMD>BufferLineMoveNext<CR>")
    vim.keymap.set("n", "[B", "<CMD>BufferLineMovePrev<CR>")
  end,
}
