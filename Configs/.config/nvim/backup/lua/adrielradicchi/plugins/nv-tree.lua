return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    {
      "JMarkin/nvim-tree.lua-float-preview",
      lazy = false,
      -- default
      opts = {
        -- Whether the float preview is enabled by default. When set to false, it has to be "toggled" on.
        toggled_on = true,
        -- wrap nvimtree commands
        wrap_nvimtree_commands = true,
        -- lines for scroll
        scroll_lines = 20,
        -- window config
        window = {
          style = "minimal",
          relative = "win",
          border = "rounded",
          wrap = false,
        },
        mapping = {
          -- scroll down float buffer
          down = { "<C-d>" },
          -- scroll up float buffer
          up = { "<C-e>", "<C-u>" },
          -- enable/disable float windows
          toggle = { "<C-x>" },
        },
        -- hooks if return false preview doesn't shown
        hooks = {
          pre_open = function(path)
            -- if file > 5 MB or not text -> not preview
            local size = require("float-preview.utils").get_size(path)
            if type(size) ~= "number" then
              return false
            end
            local is_text = require("float-preview.utils").is_text(path)
            return size < 5 and is_text
          end,
          post_open = function(bufnr)
            return true
          end,
        },
      },
    },
  },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35,
        adaptive_size = true,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            git = true,
          },
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
            git = {
              unstaged = "", -- 
              staged = "",
              unmerged = "",
              renamed = "➜",
              untracked = "",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local FloatPreview = require("float-preview")

        FloatPreview.attach_nvimtree(bufnr)
        local close_wrap = FloatPreview.close_wrap

        vim.keymap.set("n", "<C-t>", close_wrap(api.node.open.tab), { desc = "Open: New Tab" })
        vim.keymap.set("n", "<C-v>", close_wrap(api.node.open.vertical), { desc = "Open: Vertical Split" })
        vim.keymap.set("n", "<C-s>", close_wrap(api.node.open.horizontal), { desc = "Open: Horizontal Split" })
        vim.keymap.set("n", "<CR>", close_wrap(api.node.open.edit), { desc = "Open" })
        vim.keymap.set("n", "<Tab>", close_wrap(api.node.open.preview), { desc = "Open" })
        vim.keymap.set("n", "o", close_wrap(api.node.open.edit), { desc = "Open" })
        vim.keymap.set("n", "O", close_wrap(api.node.open.no_window_picker), { desc = "Open: No Window Picker" })
        vim.keymap.set("n", "a", close_wrap(api.fs.create), { desc = "Create" })
        vim.keymap.set("n", "d", close_wrap(api.fs.remove), { desc = "Delete" })
        vim.keymap.set("n", "r", close_wrap(api.fs.rename), { desc = "Rename" })
      end,
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>e", ":bfirst<CR>", { desc = "File Explorer" })
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
    --keymap.set("n", "<leader>et", ":tabnew ")
  end,
}
