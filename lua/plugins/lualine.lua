return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")
    local icon = {
      kind = {
        Codeium = "",
        Copilot = "",
        TabNine = "󰏚",

        Class = "󰠱",
        Color = "󰏘",
        Constant = "󰏿",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "󰈙",
        Folder = "󰉋",
        Function = "󰊕",
        Interface = "",
        Keyword = "󰌋",
        Method = "",
        Module = "󰆧",
        Operator = "󰆕",
        Property = "󰜢",
        Reference = "",
        Snippet = "",
        Text = "",
        TypeParameter = "󰗴",
        Unit = "",
        Value = "󰎠",

        Array = "",
        Boolean = "",
        Collapsed = "",
        Control = "",
        Key = "󰌋",
        Namespace = "󰦮",
        Null = "",
        Number = "󰎠",
        Object = "",
        Package = "",
        String = "",
        Struct = "󰆼",
        Variable = "󰀫",
      },
      git = {
        LineAdded = "",
        LineModified = "",
        LineRemoved = "",
        LineLeft = "▎",
        LineMiddle = "│",
        Branch = "",
      },
      ui = {
        Search = "",
        Selected = "❯",
        Pointer = "➜",
        Bug = "",
        Circle = "",
        Round = "",
        Ellipsis = "",
        Plus = "",
        Robot = "󰚩",
        LSP = "",
        Fold = "",
        ThinSpace = " ",
      },
      task = {
        Canceled = " ",
        Failure = " ",
        Success = " ",
        Running = " ",
      },
      diagnostics = {
        Error = " ",
        Warning = " ",
        Info = " ",
        Hint = " ",
      },
      spinner = { "", "", "", "", "", "", "", "", "", "", "", "", "" },
      dap = {
        Stopped = { " ", "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint = " ",
        BreakpointCondition = " ",
        BreakpointRejected = { " ", "DiagnosticError" },
        LogPoint = "󰮔 ",
      },
    }

    local filetype = { "filetype", icon_only = true }

    local lsp_status = {
      "lsp_status",
      icon = "", -- f013
      symbols = {
        spinner = icon.spinner,
        done = false,
        separator = " ",
      },
      -- List of LSP names to ignore (e.g., `null-ls`):
      ignore_lsp = {},
    }

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn", "info", "hint" },
      symbols = {
        error = icon.diagnostics.Error,
        hint = icon.diagnostics.Hint,
        info = icon.diagnostics.Info,
        warn = icon.diagnostics.Warning,
      },
      colored = true,
      update_in_insert = false,
      always_visible = false,
    }

    local diff = {
      "diff",
      source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end,
      symbols = {
        added = icon.git.LineAdded .. " ",
        modified = icon.git.LineModified .. " ",
        removed = icon.git.LineRemoved .. " ",
      },
      colored = true,
      always_visible = false,
    }

    local lazy_updates = {
      lazy_status.updates,
      cond = lazy_status.has_updates,
      color = { fg = "#ff9e64" },
    }

    lualine.setup({
      options = {
        theme = "auto",
        -- globalstatus = true,
        section_separators = "",
        component_separators = "",
        disabled_filetypes = { "mason", "lazy", "NvimTree" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { "filename", lsp_status, "codecompanion", "supermaven" },
        lualine_x = { lazy_updates, { "branch", icon = icon.git.Branch }, diff, diagnostics, filetype },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
