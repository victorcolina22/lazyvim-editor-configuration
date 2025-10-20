local dashboard_header_original = [[
############################################################
##########################*=----=*##########################
########################*=--------=*########################
#####################+***=--------=***+#####################
##################*+*****----------*****+*##################
################*********----------*********################
###############+********+----------+********+###############
##############+**==*****+----------+*****==**+##############
#############+*+---=****+----------+****=---+*+#############
#############*=-----=***+--=*##*=--+***=-----=*#############
############*---------**+-*######*-+**---------*############
############+----------***########***----------+############
###########*=----+------**########**------+----=*###########
##########*++---+++=-----**######**-----=+++---++*##########
##########=++=-+++*##*=---+*####*+---=*##*+++-=++=##########
#########+++++-+++#####*=--+*##*+--=*#####+++-+++++#########
##########=++++=++*#######=-=**=-=#######*++=+++++##########
##########*++++=+++#########++++#########+++=++++*##########
###########*++++=++*####################*++=++++*###########
#############++++++=####################+++++++#############
###############*=++++##################++++=*###############
###################+=##################=+###################
############################################################
]]
local dashboard_header_current = [[
############################################################
###########################%*++*############################
#########################*--------*#########################
######################=**=--------=**=######################
###################+*****----------*****+###################
#################*******+----------+*******#################
###############+*********----------*********+###############
##############=**-=******----------******=-**=##############
#############+*=----*****----------*****----=*+#############
############**-------+***-=######=-***+-------**############
############*---------=*+-########-+*=---------*############
############-----------+**########**+-----------############
##########*++---=++=----=**######**=----=++=---++*##########
##########=++--++++##+----**####**----+##++++--++=##########
#########+++++-++=#####+---+*##*+---+#####=++-+++++#########
##########=++++=+++######%--=**=-=%######+++=++++=##########
###########++++-+++#########*++*#########+++-++++###########
###########%=++++++*####################*++++++=%###########
#############+=+++++####################+++++=+#############
#################=+++##################+++=#################
############################################################
]]

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    explorer = {},
    dashboard = {
      enabled = true,
      ---@class snacks.dashboard.Config
      ---@field enabled? boolean
      ---@field sections snacks.dashboard.Section
      ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
      width = 60,
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      pane_gap = 4, -- empty columns between vertical panes
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
      -- These settings are used by some built-in sections
      preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        pick = nil,
        -- Used by the `keys` section to show keymaps.
        -- Set your custom keymaps here.
        -- When using a function, the `items` argument are the default keymaps.
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        -- Used by the `header` section
        header = dashboard_header_current,
      },
      -- item field formatters
      formats = {
        icon = function(item)
          if item.file and item.icon == "file" or item.icon == "directory" then
            return M.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = "icon" }
        end,
        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ":h")
            local file = vim.fn.fnamemodify(fname, ":t")
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. "/…" .. file
            end
          end
          local dir, file = fname:match("^(.*)/(.+)$")
          return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          layout = {
            layout = {
              position = "right",
            },
          },
          win = {
            list = {
              keys = {
                ["o"] = "confirm",
                ["l"] = "explorer_open", -- open with system application
                ["C"] = "explorer_close_all",
              },
            },
          },
        },
      },
    },
    indent = {
      -- animate scopes. Enabled by default for Neovim >= 0.10
      -- Works on older versions but has to trigger redraws during animation.
      ---@class snacks.indent.animate: snacks.animate.Config
      ---@field enabled? boolean
      --- * out: animate outwards from the cursor
      --- * up: animate upwards from the cursor
      --- * down: animate downwards from the cursor
      --- * up_down: animate up or down based on the cursor position
      ---@field style? "out"|"up_down"|"down"|"up"
      animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        style = "out",
        easing = "linear",
        duration = {
          step = 20, -- ms per step
          total = 2000, -- maximum duration
        },
      },
    },
  },
}
