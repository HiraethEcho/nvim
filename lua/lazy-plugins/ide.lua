return {
  {
    "askfiy/nvim-picgo",
    cmd = "UploadClipboard",
    config = true,
  },
  {
    "willothy/flatten.nvim",
    enabled = false,
    lazy = false,
    priority = 1001,
    -- event = "VimEnter",
    opts = {
      window = {
        open = "vsplit",
      },
    },
  },
}
