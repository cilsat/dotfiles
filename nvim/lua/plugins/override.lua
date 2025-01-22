return {
  {
    "indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "▏",
        tab_char = "▏",
      },
    },
  },
  {
    "mini.indentscope",
    opts = {
      draw = {
        animation = require("mini.indentscope").gen_animation.none(),
      },
      symbol = "▏",
    },
  },
  {
    "mini.surround",
    opts = {
      mappings = {
        add = "as",
        delete = "ds",
        replace = "rs",
      },
      search_method = "nearest",
    },
  },
  {
    "bufferline.nvim",
    opts = {
      options = {
        numbers = function(opts)
          return string.format("%s", opts.raise(opts.ordinal))
        end,
        always_show_bufferline = true,
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      animate = { enabled = false },
      scroll = { enabled = false },
      terminal = { enabled = false },
    }
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = { preset = "super-tab" }
    }
  },
}
