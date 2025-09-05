return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "ollama",
          keymaps = {
            send = {
              modes = {
                n = { "<CR>" },
                i = nil,
              },
            },
            close = {
              modes = {
                n = "q",
                i = "<c-x>",
              },
            },
            stop = {
              modes = {
                n = "<c-x>",
              },
            },
          },
        },
        inline = {
          adapter = "ollama",
        },
        agent = {
          adapter = "ollama",
        },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "llama3.1:8b",
              },
            },
          })
        end,
      },
    })
    vim.api.nvim_set_keymap("n", "<leader>cca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<leader>cca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionAdd<cr>", { noremap = true, silent = true })
  end,
}
