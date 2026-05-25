return {
  { -- copilot
    "zbirenbaum/copilot.lua",
    -- enabled = false,
    cmd = "Copilot",
    keys = { -- Example mapping to toggle outline
      { "<localleader>Cc", "<cmd>Copilot<CR>", desc = "Copilot" },
      { "<localleader>Ct", "<cmd>Copilot toggle<CR>", desc = "Copilot toggle" },
      { "<localleader>Cd", "<cmd>Copilot detach<CR>", desc = "Copilot detach" },
      { "<localleader>Ca", "<cmd>Copilot attach<CR>", desc = "Copilot attach" },
      { "<localleader>Cp", "<cmd>Copilot panel<CR>", desc = "Copilot panel" },
    },
    dependencies = { { "zbirenbaum/copilot-cmp", config = true } },
    opts = {
      auth_provider_url = "https://github.com",
      filetypes = { ["*"] = true },
      panel = {
        enabled = false,
        auto_refresh = true,
        keymap = {
          jump_prev = "K",
          jump_next = "J",
        },
        layout = {
          position = "bottom", -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = false,
        debounce = 75,
      },
    },
  },
  { -- "carlos-algms/agentic.nvim",
    "carlos-algms/agentic.nvim",
    opts = {
      -- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp" | "kiro-acp" | "pi-acp"
      provider = "opencode-acp", -- setting the name here is all you need to get started
      keymaps = {
        -- Keybindings for ALL buffers in the widget (chat, prompt, code, files)
        widget = {
          close = "q", -- String for a single keybinding
          change_mode = {
            {
              "<S-Tab>",
              mode = { "i", "n", "v" }, -- Specify modes for this keybinding
            },
          },
          switch_provider = "<localLeader>as", -- Switch ACP provider
          switch_model = "<localLeader>am", -- Switch model
          change_thought_level = "<localLeader>at", -- Select thought effort level
        },
        -- Keybindings for the prompt buffer only
        prompt = {
          submit = {
            "<CR>", -- Normal mode, just Enter
            {
              "<C-s>",
              mode = { "n", "v", "i" },
            },
          },
          paste_image = {
            {
              "<localLeader>p",
              mode = { "n" },
            },
            {
              "<C-v>", -- Same as Claude-code in insert mode
              mode = { "i" },
            },
          },
        },
        -- Keybindings for chat buffer navigation
        chat = {
          next_heading = "]]",
          prev_heading = "[[",
          next_tool_call = "]t",
          prev_tool_call = "[t",
        },
        -- Keybindings for diff preview navigation
        diff_preview = {
          next_hunk = "]c",
          prev_hunk = "[c",
        },
        -- Keybindings to cycle focus between pending permission blocks.
        -- Once a block is focused, per-block keys work on its row N:
        --   h / <Left>  : focus previous button
        --   l / <Right> : focus next button
        --   <CR>        : submit focused button
        --   1..4        : submit option N directly
        -- Per-block keys only fire when the cursor is on the focused row.
        permission = {
          cycle_next = "<C-n>",
          cycle_prev = "<C-p>",
        },
      },
    },
    -- these are just suggested keymaps; customize as desired
    keys = {
      -- stylua: ignore start
      { "<localleader>aa", function() require("agentic").toggle() end, mode = { "n", "v", "i" }, desc = "Toggle Agentic Chat", },
      { "<localleader>aA", function() require("agentic").add_selection_or_file_to_context() end, mode = { "n", "v" }, desc = "Add file or selection to Agentic to Context", },
      { "<localleader>an", function() require("agentic").new_session() end, mode = { "n", "v", "i" }, desc = "New Agentic Session", },
      -- ai Restore
      { "<localleader>ar",  function() require("agentic").restore_session() end, desc = "Agentic Restore session", silent = true, mode = { "n", "v", "i" }, },
      -- ai Diagnostics
      { "<localleader>ad",  function() require("agentic").add_current_line_diagnostics() end, desc = "Add current line diagnostic to Agentic", mode = { "n" }, },
      -- ai all Diagnostics
      { "<localleader>aD", function() require("agentic").add_buffer_diagnostics() end, desc = "Add all buffer diagnostics to Agentic", mode = { "n" }, },
      -- sytlua: ignore stop
    },
  },
  { -- "sudo-tee/opencode.nvim",
    "sudo-tee/opencode.nvim",
    -- enabled = false,
    keys = {
      { "<localleader>oo", "<cmd>Opencode<cr>", desc = "Toggle Opencode" },
    },
    cmd = { "OpenCode" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("opencode").setup({
        preferred_picker = "snack", -- 'telescope', 'fzf', 'mini.pick', 'snacks', 'select', if nil, it will use the best available picker. Note mini.pick does not support multiple selections
        preferred_completion = "blink", -- 'blink', 'nvim-cmp','vim_complete' if nil, it will use the best available completion
        default_global_keymaps = false, -- If false, disables all default global keymaps
        default_mode = "plan", -- 'build' or 'plan' or any custom configured. @see [OpenCode Agents](https://opencode.ai/docs/modes/)
        default_system_prompt = nil, -- Custom system prompt to use for all sessions. If nil, uses the default built-in system prompt
        keymap_prefix = "<localleader>o", -- Default keymap prefix for global keymaps change to your preferred prefix and it will be applied to all keymaps starting with <leader>o
        opencode_executable = "opencode", -- Name of your opencode binary
        server = {
          url = nil, -- URL/hostname (e.g., 'http://192.168.1.100', 'localhost', 'https://myserver.com')
          port = nil, -- Port number (e.g., 8080), 'auto' for random port
          timeout = 5, -- Health check timeout in seconds when connecting
          spawn_command = nil, -- Optional function to start the server: function(port, url) ... end
          auto_kill = true, -- Kill spawned servers when last nvim instance exits (default: true) Only applies to servers spawned by the plugin with spawn_command/kill_command
          path_map = nil, -- Map host paths to server paths: string ('/app') or function(path) -> string
        },
        keymap = {
          editor = {
            ["<localleader>oo"] = { "toggle" }, -- Open opencode. Close if opened
            ["<localleader>oi"] = { "open_input" }, -- Opens and focuses on input window on insert mode
            ["<localleader>on"] = { "open_input_new_session" }, -- Opens and focuses on input window on insert mode. Creates a new session
            ["<localleader>oO"] = { "open_output" }, -- Opens and focuses on output window
            ["<localleader>ot"] = { "toggle_focus" }, -- Toggle focus between opencode and last window
            ["<localleader>oT"] = { "timeline" }, -- Display timeline picker to navigate/undo/redo/fork messages
            ["<localleader>oq"] = { "close" }, -- Close UI windows
            ["<localleader>os"] = { "select_session" }, -- Select and load a opencode session
            ["<localleader>oR"] = { "rename_session" }, -- Rename current session
            ["<localleader>op"] = { "configure_provider" }, -- Quick provider and model switch from predefined list
            ["<localleader>oV"] = { "configure_variant" }, -- Switch model variant for the current model
            ["<localleader>oy"] = { "add_visual_selection", mode = { "v" } },
            ["<localleader>oY"] = { "add_visual_selection_inline", mode = { "v" } }, -- Insert visual selection as inline code block in the input buffer
            ["<localleader>oz"] = { "toggle_zoom" }, -- Zoom in/out on the Opencode windows
            ["<localleader>ov"] = { "paste_image" }, -- Paste image from clipboard into current session
            ["<localleader>od"] = { "diff_open" }, -- Opens a diff tab of a modified file since the last opencode prompt
            ["<localleader>o]"] = { "diff_next" }, -- Navigate to next file diff
            ["<localleader>o["] = { "diff_prev" }, -- Navigate to previous file diff
            ["<localleader>oc"] = { "diff_close" }, -- Close diff view tab and return to normal editing
            ["<localleader>ora"] = { "diff_revert_all_last_prompt" }, -- Revert all file changes since the last opencode prompt
            ["<localleader>ort"] = { "diff_revert_this_last_prompt" }, -- Revert current file changes since the last opencode prompt
            ["<localleader>orA"] = { "diff_revert_all" }, -- Revert all file changes since the last opencode session
            ["<localleader>orT"] = { "diff_revert_this" }, -- Revert current file changes since the last opencode session
            ["<localleader>orr"] = { "diff_restore_snapshot_file" }, -- Restore a file to a restore point
            ["<localleader>orR"] = { "diff_restore_snapshot_all" }, -- Restore all files to a restore point
            ["<localleader>ox"] = { "swap_position" }, -- Swap Opencode pane left/right
            ["<localleader>ott"] = { "toggle_tool_output" }, -- Toggle tools output (diffs, cmd output, etc.)
            ["<localleader>otr"] = { "toggle_reasoning_output" }, -- Toggle reasoning output (thinking steps)
            ["<localleader>o/"] = { "quick_chat", mode = { "n", "x" } }, -- Open quick chat input with selection context in visual mode or current line context in normal mode
          },
          input_window = {
            ["<S-cr>"] = { "submit_input_prompt", mode = { "n", "i" } }, -- Submit prompt (normal mode and insert mode)
            ["q"] = { "close", defer_to_completion = true, mode = { "n" } }, -- Close UI windows
            ["<C-c>"] = { "cancel", defer_to_completion = true }, -- Cancel opencode request while it is running
            ["~"] = { "mention_file", mode = "i" }, -- Pick a file and add to context. See File Mentions section
            ["@"] = { "mention", mode = "i" }, -- Insert mention (file/agent)
            ["/"] = { "slash_commands", mode = "i" }, -- Pick a command to run in the input window
            ["#"] = { "context_items", mode = "i" }, -- Manage context items (current file, selection, diagnostics, mentioned files)
            ["<M-v>"] = { "paste_image", mode = "i" }, -- Paste image from clipboard as attachment
            ["<tab>"] = { "toggle_pane", mode = { "n", "i" }, defer_to_completion = true }, -- Toggle between input and output panes
            ["<up>"] = { "prev_prompt_history", mode = { "n", "i" }, defer_to_completion = true }, -- Navigate to previous prompt in history
            ["<down>"] = { "next_prompt_history", mode = { "n", "i" }, defer_to_completion = true }, -- Navigate to next prompt in history
            ["<M-m>"] = { "switch_mode" }, -- Switch between modes (build/plan)
            ["<M-r>"] = { "cycle_variant", mode = { "n", "i" } }, -- Cycle through available model variants
          },
          output_window = {
            ["<esc>"] = { "close" }, -- Close UI windows
            ["<C-c>"] = { "cancel" }, -- Cancel opencode request while it is running
            ["]]"] = { "next_message" }, -- Navigate to next message in the conversation
            ["[["] = { "prev_message" }, -- Navigate to previous message in the conversation
            ["<tab>"] = { "toggle_pane", mode = { "n", "i" } }, -- Toggle between input and output panes
            ["i"] = { "focus_input", "n" }, -- Focus on input window and enter insert mode at the end of the input from the output window
            ["<M-r>"] = { "cycle_variant", mode = { "n" } }, -- Cycle through available model variants
            ["<localleader>oS"] = { "select_child_session" }, -- Select and load a child session
            ["<localleader>oP"] = { "select_parent_session" }, -- Go to parent session
            ["<localleader>oB"] = { "select_sibling_session" }, -- Select sibling session (children of same parent)
            ["<localleader>oD"] = { "debug_message" }, -- Open raw message in new buffer for debugging
            ["<localleader>oO"] = { "debug_output" }, -- Open raw output in new buffer for debugging
            ["<localleader>ods"] = { "debug_session" }, -- Open raw session in new buffer for debugging
          },
        },
        ui = {
          enable_treesitter_markdown = false, -- Use Treesitter for markdown rendering in the output window (default: true).
          position = "right", -- 'right' (default), 'left' or 'current'. Position of the UI split. 'current' uses the current window for the output.
          input_position = "bottom", -- 'bottom' (default) or 'top'. Position of the input window
          window_width = 0.40, -- Width as percentage of editor width
          zoom_width = 0.8, -- Zoom width as percentage of editor width
          questions = {
            use_vim_ui_select = false, -- If true, render questions/prompts with vim.ui.select instead of showing them inline in the output buffer.
          },
          output = {
            filetype = "opencode_output", -- Filetype assigned to the output buffer (default: 'opencode_output')
            compact_assistant_headers = "full", -- 'full' (default), 'minimal' (compact if same mode), or 'hidden' (no headers for assistant)
            tools = {
              show_output = false, -- Show tools output [diffs, cmd output, etc.] (default: true)
              show_reasoning_output = false, -- Show reasoning/thinking steps output (default: true)
              use_folds = true, -- Use folds for tool output (default: true)
              folding_threshold = 5, -- Number of lines to show before folding when show_output is true (default: 5)
            },
            rendering = {
              markdown_debounce_ms = 250, -- Debounce time for markdown rendering on new data (default: 250ms)
              on_data_rendered = nil, -- Called when new data is rendered; set to false to disable default RenderMarkdown/Markview behavior
            },
            max_messages = nil, -- Max number of messages to keep in the output buffer; older messages will be removed as new ones arrive (default: nil, which means no limit)
          },
          input = {
            min_height = 0.10, -- min height of prompt input as percentage of window height
            max_height = 0.45, -- max height of prompt input as percentage of window height
            text = {
              wrap = false, -- Wraps text inside input window
            },
            -- Auto-hide input window when prompt is submitted or focus switches to output window
            auto_hide = false,
          },
        },
        context = {
          enabled = true, -- Enable automatic context capturing
          cursor_data = {
            enabled = false, -- Include cursor position and line content in the context
            context_lines = 5, -- Number of lines before and after cursor to include in context
          },
        },
        debug = {
          enabled = false, -- Enable debug messages in the output window
          capture_streamed_events = false,
          show_ids = true,
        },
        hooks = {
          on_file_edited = nil, -- Called after a file is edited by opencode.
          on_session_loaded = nil, -- Called after a session is loaded.
          on_done_thinking = nil, -- Called when opencode finishes thinking (all jobs complete).
          on_permission_requested = nil, -- Called when a permission request is issued.
        },
        quick_chat = {
          default_model = nil, -- works better with a fast model like gpt-4.1
          default_agent = nil, -- Uses the current mode when nil
          instructions = nil, -- Use built-in instructions if nil
        },
      })
    end,
  },
  { -- "folke/sidekick.nvim",
    "folke/sidekick.nvim",
    -- lazy = false,
    enabled = false,
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "zellij",
          enabled = false,
        },
      },
    },
    keys = {
      -- stylua: ignore start
      -- if there is a next edit, jump to it, otherwise apply it if any
      --  fallback to normal tab
      { "<tab>", function() if not require("sidekick").nes_jump_or_apply() then return "<Tab>"  end end, expr = true, desc = "Goto/Apply Next Edit Suggestion", },
      { "<c-.>", function() require("sidekick.cli").focus() end, desc = "Sidekick Focus", mode = { "n", "t", "i", "x" }, },
      { "<localleader>sa", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle CLI", },
      -- { "<localleader>ss", function() require("sidekick.cli").select() end,  desc = "Select CLI", },
      { "<localleader>ss", function()  require("sidekick.cli").select({ filter = { installed = true } }) end, desc = "Select CLI", },
      { "<localleader>sd", function() require("sidekick.cli").close() end, desc = "Detach a CLI Session", },
      { "<localleader>st", function() require("sidekick.cli").send({ msg = "{this}" }) end, mode = { "x", "n" }, desc = "Send This", },
      { "<localleader>sf", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Send File", },
      { "<localleader>sv", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = { "x" }, desc = "Send Visual Selection", },
      { "<localleader>sp", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "Sidekick Select Prompt", },
      { "<localleader>sc", function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end, desc = "Sidekick Toggle Claude", },
      -- sytlua: ignore stop
    },
  },

  { -- codecompanion
    "olimorris/codecompanion.nvim",
    enabled = false,
    -- event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
      -- "ravitemer/mcphub.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "Davidyz/VectorCode",
    },
    keys = {
      { "<localleader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle codecompanion chat" },
      { "<localleader>ca", "<cmd>CodeCompanionActions<cr>", desc = "codecompanion action" },
    },
    opts = {
      interactions = {
        chat = {
          adapter = {
            name = "opencode",
            model = "gpt-4.1",
          },
        },
      },
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        agent = { adapter = "copilot" },
        cmd = { adapter = "copilot" },
      },
      extensions = {
        spinner = {},
      },
    },
  },
  { -- CopilotChat
    enabled = false,
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "CopilotChatToggle" },
    keys = {
      { "<localleader>Cc", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChatToggle" },
      { "<localleader>Ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChatExplain" },
      { "<localleader>Cm", "<cmd>CopilotChatCommit<cr>", desc = "CopilotChatCommit" },
    },
    dependencies = {
      "zbirenbaum/copilot.lua",
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    -- See Commands section for default commands if you want to lazy load on them
    config = function()
      local vectorcode_ctx = require("vectorcode.integrations.copilotchat").make_context_provider({
        prompt_header = "Here are relevant files from the repository:", -- Customize header text
        prompt_footer = "\nConsider this context when answering:", -- Customize footer text
        skip_empty = true, -- Skip adding context when no files are retrieved
      })
      require("CopilotChat").setup({
        -- sticky = { "#vectorcode" },
        mappings = {
          reset = { normal = "<C-S-L>", insert = "<C-S-L>" },
          show_diff = { full_diff = true },
        },
        -- contexts = { vectorcode = vectorcode_ctx },
        prompts = {
          Explain = {
            prompt = "Explain the following code in detail:\n$input",
            context = { "selection" }, -- Add vectorcode to the context
          },
        },
      })
    end,
  },
  { -- avante
    "yetone/avante.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim", -- for input provider snacks
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      -- "ravitemer/mcphub.nvim",
    },
    build = "make",
    -- event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    -- stylua: ignore
    keys = {
      { "<localleader>aa", "<cmd>AvanteChat<cr>", desc = "Avante chat" },
      { "<localleader>at", "<cmd>AvanteToggle<cr>", desc = "Toggle Avante chat" },
      { "<localleader>ar", "<cmd>AvanteRefresh<cr>", desc = "AvanteRefresh" },
      { "<localleader>af", "<cmd>AvanteFocus<cr>", desc = "Change focus" },
      { "<localleader>a?", "<cmd>AvanteModels<cr>", desc = "select model" },
      { "<localleader>an", "<cmd>AvanteChatNew<cr>", desc = "New Ask" },
      { "<localleader>ae", "<cmd>AvanteEdit<cr>", desc = "Edit selected block" },
      { "<localleader>aS", "<cmd>AvanteStop<cr>", desc = "Stop current AI request" },
      { "<localleader>ah", "<cmd>AvanteHistory<cr>", desc = "select between chat histories" },
      -- { "<localleader>ad", "<cmd>Avante<cr>", desc = "select between chat histories" },
      { "<localleader>aC", "<cmd>AvanteClear<cr>", desc = "Clear Avante chat" },
    },
    opts = {
      --[[ system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      custom_tools = function()
        return { require("mcphub.extensions.avante").mcp_tool() }
      end, ]]
      provider = "copilot",
      providers = {
        ollama = {
          endpoint = "http://localhost:11434",
          model = "qwen3:8b",
        },
      },
      behaviour = {
        auto_set_keymaps = false,
        support_paste_from_clipboard = true,
        enable_token_counting = true,
      },
      mappings = {
        files = {
          add_current = "<localleader>ac", -- Add current buffer to selected files
          add_all_buffers = "<localleader>aB", -- Add all buffer files to selected files
        },
        select_model = "<localleader>a?", -- Select model command
        select_history = "<localleader>ah", -- Select history command
        confirm = {
          focus_window = "<C-w>f",
          code = "c",
          resp = "r",
          input = "i",
        },
        ask = "<localleader>aa",
        new_ask = "<localleader>an",
        edit = "<localleader>ae",
        refresh = "<localleader>ar",
        focus = "<localleader>af",
        stop = "<localleader>aS",
        toggle = {
          default = "<localleader>at",
          debug = "<localleader>ad",
          hint = "<localleader>ah",
          suggestion = "<localleader>as",
          repomap = "<localleader>aR",
        },
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {},
        jump = {
          next = "]]",
          prev = "[[",
        },
        cancel = {
          normal = { "<C-c>", "<Esc>", "q" },
          insert = { "<C-c>" },
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          retry_user_request = "r",
          edit_user_request = "e",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
          remove_file = "d",
          add_file = "@",
          close = { "<Esc>", "q" },
          close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
        },
      },
      input = { provider = "snacks" },
      hints = { enabled = false },
    },
  },
  { -- mcphub
    "ravitemer/mcphub.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup({
        config = vim.fn.expand("~/.config/mcphub/global.json"), -- Absolute path to MCP Servers config file (will create if not exists)
        ---Chat-plugin related options-----------------
        auto_approve = false, -- Auto approve mcp tool calls
        auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
        extensions = {
          avante = { make_slash_commands = true },
          copilotchat = {
            enabled = true,
            convert_tools_to_functions = true, -- Convert MCP tools to CopilotChat functions
            convert_resources_to_functions = true, -- Convert MCP resources to CopilotChat functions
            add_mcp_prefix = false, -- Add "mcp_" prefix to function names
          },
        },
        builtin_tools = {
          edit_file = {
            parser = {
              track_issues = true, -- Track parsing issues for LLM feedback
              extract_inline_content = true, -- Handle content on marker lines
            },
            locator = {
              fuzzy_threshold = 0.8, -- Minimum similarity for fuzzy matches (0.0-1.0)
              enable_fuzzy_matching = true, -- Allow fuzzy matching when exact fails
            },
            ui = {
              go_to_origin_on_complete = true, -- Jump back to original file on completion
              keybindings = {
                accept = ".", -- Accept current change
                reject = ",", -- Reject current change
                next = "n", -- Next diff
                prev = "p", -- Previous diff
                accept_all = "ga", -- Accept all remaining changes
                reject_all = "gr", -- Reject all remaining changes
              },
            },
            feedback = {
              include_parser_feedback = true, -- Include parsing feedback for LLM
              include_locator_feedback = true, -- Include location feedback for LLM
              include_ui_summary = true, -- Include UI interaction summary
              ui = {
                include_session_summary = true, -- Include session summary in feedback
                include_final_diff = true, -- Include final diff in feedback
                send_diagnostics = true, -- Include diagnostics after editing
                wait_for_diagnostics = 500, -- Wait time for diagnostics (ms)
                diagnostic_severity = vim.diagnostic.severity.WARN, -- Min severity to include
              },
            },
          },
        },
        --- Plugin specific options-------------------
        native_servers = {}, -- add your custom lua native servers here
        on_ready = function(hub)
          vim.notify("MCP HUB is ready")
        end,
        on_error = function(err)
          vim.notify("MCP HUB error")
        end,
      })
    end,
  },
}
