return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    -- import nvim-autopairs
    local autopairs = require("nvim-autopairs")
    local Rule = require('nvim-autopairs.rule')
    local ts_conds = require('nvim-autopairs.ts-conds')
    local endwise = require("nvim-autopairs.ts-rule").endwise

    -- configure autopairs
    autopairs.setup({
      check_ts = true, -- enable treesitte
      ts_config = {
        lua = {'template_string'},-- it will not add a pair on that treesitter node
        go = {'template_string'},
        elixir = {'template_string'},
      },
    })

    autopairs.add_rules({
      Rule("%", "%", "lua") :with_pair(ts_conds.is_ts_node({'string', 'comment'})),
      Rule("$", "$", "lua") :with_pair(ts_conds.is_ts_node({'function'})),
      endwise(" do$", "end", "elixir", nil),
      endwise('then$', 'end', 'lua', nil)
    })

    -- import nvim-autopairs completion functionality
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- import nvim-cmp plugin (completions plugin)
    local cmp = require("cmp")

    -- make autopairs and completion work together
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
