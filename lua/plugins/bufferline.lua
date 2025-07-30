return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  event = "BufAdd",
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        mode = "tabs",
        hover = {
          enabled = true,
          delay = 0,
          reveal = { "close" },
        },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
      },
    })
  end,
}
