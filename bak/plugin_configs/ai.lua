return {
  {
    "Kurama622/llm.nvim",
    enabled = false, -- need api key added by environment
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    config = function()
      require("llm").setup({
        url = "https://api.deepseek.com/chat/completions",
        model = "deepseek-chat",
        api_type = "openai",
        max_tokens = 4096,
        temperature = 0.3,
        top_p = 0.7,

        prompt = "You are a helpful Chinese assistant.",

        prefix = {
          user = { text = "  ", hl = "Title" },
          assistant = { text = "  ", hl = "Added" },
        },

        -- history_path = "/tmp/llm-history",
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = "n", key = "<cr>" },
          ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
          ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
          ["Session:Close"]     = { mode = "n", key = {"<esc>", "Q"} },
        },
      })
    end,
    keys = {
      { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
      { "<leader>ae", mode = "v", "<cmd>LLMSelectedTextHandler 请解释下面这段代码<cr>" },
      { "<leader>ts", mode = "x", "<cmd>LLMSelectedTextHandler 英译汉<cr>" },
    },
  },

  {
    "sudo-tee/opencode.nvim",
    enabled = false,
    -- name ="opencode-nvim",
    cmd = { "Opencode" },
    opts = {
      -- Default configuration with all available options
      prefered_picker = nil, -- 'telescope', 'fzf', 'mini.pick', 'snacks', if nil, it will use the best available picker
      default_global_keymaps = true, -- If false, disables all default global keymaps
      default_mode = "build", -- 'build' or 'plan' or any custom configured. @see [OpenCode Modes](https://opencode.ai/docs/modes/)
      config_file_path = nil, -- Path to opencode configuration file if different from the default `~/.config/opencode/config.json` or `~/.config/opencode/opencode.json`
      keymap = {
        global = {
          toggle = "<localleader>oa", -- Open opencode. Close if opened
          open_input = "<localleader>oi", -- Opens and focuses on input window on insert mode
          open_input_new_session = "<localleader>oI", -- Opens and focuses on input window on insert mode. Creates a new session
          open_output = "<localleader>oo", -- Opens and focuses on output window
          toggle_focus = "<localleader>ot", -- Toggle focus between opencode and last window
          close = "<localleader>oq", -- Close UI windows
          select_session = "<localleader>os", -- Select and load a opencode session
          configure_provider = "<localleader>op", -- Quick provider and model switch from predefined list
          diff_open = "<localleader>od", -- Opens a diff tab of a modified file since the last opencode prompt
          diff_next = "<localleader>o]", -- Navigate to next file diff
          diff_prev = "<localleader>o[", -- Navigate to previous file diff
          diff_close = "<localleader>oc", -- Close diff view tab and return to normal editing
          diff_revert_all_last_prompt = "<localleader>ora", -- Revert all file changes since the last opencode prompt
          diff_revert_this_last_prompt = "<localleader>ort", -- Revert current file changes since the last opencode prompt
          diff_revert_all = "<localleader>orA", -- Revert all file changes since the last opencode session
          diff_revert_this = "<localleader>orT", -- Revert current file changes since the last opencode session
          swap_position = "<localleader>ox", -- Swap Opencode pane left/right
        },
        window = {
          submit = "<cr>", -- Submit prompt (normal mode)
          submit_insert = "<C-s>", -- Submit prompt (insert mode)
          close = "<esc>", -- Close UI windows
          stop = "<C-c>", -- Stop opencode while it is running
          next_message = "]]", -- Navigate to next message in the conversation
          prev_message = "[[", -- Navigate to previous message in the conversation
          mention_file = "@", -- Pick a file and add to context. See File Mentions section
          toggle_pane = "<tab>", -- Toggle between input and output panes
          prev_prompt_history = "<up>", -- Navigate to previous prompt in history
          next_prompt_history = "<down>", -- Navigate to next prompt in history
          switch_mode = "<M-m>", -- Switch between modes (build/plan)
          focus_input = "<C-i>", -- Focus on input window and enter insert mode at the end of the input from the output window
          debug_messages = "<localleader>oD", -- Open raw message in new buffer for debugging
          debug_output = "<localleader>oO", -- Open raw output in new buffer for debugging
        },
      },
      ui = {
        position = "right", -- 'right' (default) or 'left'. Position of the UI split
        input_position = "bottom", -- 'bottom' (default) or 'top'. Position of the input window
        window_width = 0.40, -- Width as percentage of editor width
        input_height = 0.15, -- Input height as percentage of window height
        display_model = true, -- Display model name on top winbar
        window_highlight = "Normal:OpencodeBackground,FloatBorder:OpencodeBorder", -- Highlight group for the opencode window
        output = {
          tools = {
            show_output = true, -- Show tools output [diffs, cmd output, etc.] (default: true)
          },
        },
      },
      context = {
        cursor_data = true, -- send cursor position and current line to opencode
        diagnostics = {
          info = true, -- Include diagnostics info in the context (default to false
          warn = true, -- Include diagnostics warnings in the context
          error = true, -- Include diagnostics errors in the context
        },
      },
      debug = {
        enabled = true, -- Enable debug messages in the output window
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
