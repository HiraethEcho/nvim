return {
  { -- "FluxxField/bionic-reading.nvim",
    "FluxxField/bionic-reading.nvim",
    -- enabled = false,
    cmd ="BRToggle",
    opts = {
      -- determines if the file types below will be
      -- automatically highlighted on buffer open
      auto_highlight = true,
      -- the file types you want to highlight with
      -- the node types you would like to target
      -- using treesitter
      file_types = {
        ["text"] = "any", -- highlight any node
        ["help"] = "any", -- highlight any node
        ["markdown"] = "any",
        -- EX: only highlights comments in lua files
        ["lua"] = {
          "comment",
        },
      },
      -- Flag used to control if the user is prompted
      -- if BRToggle is called on a file type that is not
      -- explicitly defined above
      prompt_user = true,
      -- Enable or disable the use of treesitter
      treesitter = true,
    },
  },
  { -- "askfiy/nvim-picgo",
    "askfiy/nvim-picgo",
    enabled = false,
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
