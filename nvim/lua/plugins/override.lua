return {
  {
    "indent-blankline.nvim",
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
      symbol = "▏",
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
}
