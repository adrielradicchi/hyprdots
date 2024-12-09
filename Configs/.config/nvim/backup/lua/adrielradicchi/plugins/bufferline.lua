return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      numbers = "buffer_id",
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
      hover = {
        enabled = true,
        delay = 150,
        reveal = { "close" },
      },
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
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
      show_close_icon = true,
      show_buffer_close_icons = true,
      color_icons = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true,
      duplicate_across_groups = true,
      persist_buffer_sort = true,
      separator_style = "thin",
      enforce_regular_tabs = true,
      always_show_bufferline = true,
      auto_toggle_bufferline = true,
      sort_by = "tabs",
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
    vim.keymap.set("n", "<leader>bp", "<CMD>BufferLinePick<CR>", { desc = "Buffer line pick" })
    vim.keymap.set("n", "<leader>bs", "<CMD>BufferLinePickClose<CR>", { desc = "Buffer line pick close" })
    vim.keymap.set("n", "<S-l>", "<CMD>BufferLineCycleNext<CR>")
    vim.keymap.set("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>")
    vim.keymap.set("n", "]b", "<CMD>BufferLineMoveNext<CR>")
    vim.keymap.set("n", "[b", "<CMD>BufferLineMovePrev<CR>")
    vim.keymap.set("n", "<leader>bs", "<CMD>BufferLineSortByDirectory<CR>", { desc = "Buffer line Sort by Directory" })
  end,
}
