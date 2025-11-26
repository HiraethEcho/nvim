---
title: task
---
```lua
return {
  { -- "huantrinh1802/khal_endar.nvim",
    "huantrinh1802/khal_endar.nvim",
    enabled = false,
    version = "*",
    cmd = {"KLInteract","KLList","KLShow"},
    dependencies = { "MunifTanjim/nui.nvim", "chrisbra/Colorizer" },
    config = function()
      -- Require
      require("khal_endar").setup()
      -- Optional
      -- vim.api.nvim_set_keymap("n", "<leader>ki", "<cmd>KLInteract<cr>", { desc = "[K]hal [I]interact", noremap = true, silent = true })
    end,
  },
  { -- "huantrinh1802/m_taskwarrior_d.nvim",
    "huantrinh1802/m_taskwarrior_d.nvim",
    version = "*",
    cmd = { "TWView", "TWQueryTasks", "TWBufQueryTasks" },
    -- enabled = false,
    -- lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      -- Require
      require("m_taskwarrior_d").setup({
        -- The order of toggling task statuses
        task_statuses = { " ", ">", "x", "~", "-" },
        -- The mapping between status and symbol in checkbox
        status_map = { [" "] = "pending", [">"] = "active", ["x"] = "completed", ["~"] = "deleted", ["-"] = "waiting" },
        -- The checkbox prefix and suffix
        checkbox_prefix = "[",
        checkbox_suffix = "]",
        -- The default list symbol
        default_list_symbol = "-",
        -- Comments pattern prefix and suffix
        -- This is extremely useful for viewing the note in any Makrdown previewers (i.e. Obsidian app) if you set
        comment_prefix = "<!--",
        comment_suffix = "-->",
        -- The file pattern to trigger the conceal
        -- file_patterns = { "*.md", "*.markdown" },
        display_due_or_scheduled = true,
        -- More configurations will be added in the future
      })
      -- Optional
      -- vim.api.nvim_set_keymap("n", "<leader>te", "<cmd>TWEditTask<cr>", { desc = "TaskWarrior Edit" })
      -- vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>TWView<cr>", { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap("n", "<leader>tu", "<cmd>TWUpdateCurrent<cr>", { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>TWSyncTasks<cr>", { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap( "n", "<c-space>", "<cmd>TWToggle<cr>", { silent = true })
      -- Be caution: it may be slow to open large files, because it scan the whole buffer
      --[[ vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("TWTask", { clear = true }),
        pattern = "*.md,*.markdown", -- Pattern to match Markdown files
        callback = function()
          vim.cmd('TWSyncTasks')
        end,
      }) ]]
    end,
  },
  { -- neowarrior
    "duckdm/neowarrior.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      -- 'nvim-telescope/telescope.nvim',
      --- Optional but recommended for nicer inputs
      --- 'folke/noice.nvim',
    },
    config = function()
      local nw = require("neowarrior")
      local home = vim.env.HOME
      nw.setup({
        -- report = "next",
        -- filter = "\\(due.before:2d or due: \\)",
        -- dir_setup = {
        --   {
        --     dir = home .. "/dev/nvim/neowarrior.nvim",
        --     filter = "project:neowarrior",
        --     mode = "tree",
        --     expanded = true,
        --   },
        -- }
      })
      vim.keymap.set("n", "<leader>nl", function()
        nw.open_left()
      end, { desc = "Open nwarrior on the left side" })
      vim.keymap.set("n", "<leader>nc", function()
        nw.open_current()
      end, { desc = "Open nwarrior below current buffer" })
      vim.keymap.set("n", "<leader>nb", function()
        nw.open_below()
      end, { desc = "Open nwarrior below current buffer" })
      vim.keymap.set("n", "<leader>na", function()
        nw.open_above()
      end, { desc = "Open nwarrior above current buffer" })
      vim.keymap.set("n", "<leader>nr", function()
        nw.open_right()
      end, { desc = "Open nwarrior on the right side" })
      vim.keymap.set("n", "<leader>nt", function()
        nw.focus()
      end, { desc = "Focus nwarrior" })
    end,
  },
}
```
