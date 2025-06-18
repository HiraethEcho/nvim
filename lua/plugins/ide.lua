return {
  {
    "askfiy/nvim-picgo",
    cmd = "UploadClipboard",
    config = true,
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
  {
    "huantrinh1802/m_taskwarrior_d.nvim",
    version = "*",
    cmd = { "TWView", "TWQueryTasks","TWBufQueryTasks" },
    -- enabled = false,
    -- lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      -- Require
      require("m_taskwarrior_d").setup({
        -- The order of toggling task statuses
        task_statuses = { " ", ">", "x", "~","-" },
        -- The mapping between status and symbol in checkbox
        status_map = { [" "] = "pending", [">"] = "active", ["x"] = "completed", ["~"] = "deleted" , ["-"]="waiting"},
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
        display_due_or_scheduled = false,
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
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    keys = {
      {
        "ga",
        function()
          require("tiny-code-action").code_action()
        end,
        desc = "code actions",
      },
    },
    event = "LspAttach",
    opts = {
      --- The backend to use, currently only "vim", "delta", "difftastic", "diffsofancy" are supported
      backend = "vim",

      -- The picker to use, "telescope", "snacks", "select" are supported
      -- You can also set `picker = "telescope"` without any opts.
      picker = { "snacks" },
      backend_opts = {
        difftastic = {
          header_lines_to_remove = 1,

          -- The arguments to pass to difftastic
          args = {
            "--color=always",
            "--display=inline",
            "--syntax-highlight=on",
          },
        },
        diffsofancy = {
          header_lines_to_remove = 4,
        },
      },

      -- The icons to use for the code actions
      -- You can add your own icons, you just need to set the exact action's kind of the code action
      -- You can set the highlight like so: { link = "DiagnosticError" } or  like nvim_set_hl ({ fg ..., bg..., bold..., ...})
      signs = {
        quickfix = { "󰁨", { link = "DiagnosticInfo" } },
        others = { "?", { link = "DiagnosticWarning" } },
        refactor = { "", { link = "DiagnosticWarning" } },
        ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
        ["refactor.extract"] = { "", { link = "DiagnosticError" } },
        ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
        ["source.fixAll"] = { "", { link = "DiagnosticError" } },
        ["source"] = { "", { link = "DiagnosticError" } },
        ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
        ["codeAction"] = { "", { link = "DiagnosticError" } },
      },
    },
  },
}
