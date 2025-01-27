return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true,
    })
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    npairs.add_rules({
      Rule("<", ">", "html"):with_pair(function(opts)
        return opts.line:sub(opts.col, opts.col) ~= ">"
      end),
    })
  end,
}
