-- `PROF=1 nvim` to start nvim with profiler
if vim.env.PROF then
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = {
      -- event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      event = "VeryLazy",
    },
  })
end

-- vim.g.mapleader = " "
-- vim.g.maplocalleader = ","

vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode(",")

-- require("opts")
-- require("core")
-- require("utils")
require("options")
require("keymaps")
require("pm")
