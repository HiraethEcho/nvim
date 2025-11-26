return {
  { -- codecompanion
    "olimorris/codecompanion.nvim",
    -- enabled = false,
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
      -- stylua: ignore
      strategies = { chat = { adapter = "copilot" }, inline = { adapter = "copilot" }, agent = { adapter = "copilot" }, cmd = { adapter = "copilot" }, },
      extensions = {
        --[[
        vectorcode = {
          opts = {
            tool_group = {
              enabled = true,
              extras = {},
              collapse = false, -- whether the individual tools should be shown in the chat
            },
            tool_opts = {
              ["*"] = {},
              ls = {},
              vectorise = {},
              query = {
                max_num = { chunk = -1, document = -1 },
                default_num = { chunk = 50, document = 10 },
                include_stderr = false,
                use_lsp = false,
                no_duplicate = true,
                chunk_mode = false,
                summarise = {
                  enabled = false,
                  adapter = nil,
                  query_augmented = true,
                },
              },
              files_ls = {},
              files_rm = {},
            },
          },
        },
        --]]
        spinner = {},
        --[[ mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true, -- Show tool results directly in chat buffer
            format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
            make_vars = true, -- Convert MCP resources to #variables for prompts
            make_slash_commands = true, -- Add MCP prompts as /slash commands
          },
        }, ]]
      },
    },
    --[[ config = function()
      require("codecompanion").setup({
        strategies = { chat = { adapter = "anthropic" }, inline = { adapter = "anthropic" } },
      })
      vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.keymap.set({ "n", "v" }, "<LocalLeader>c", "<cmd>CodeCompanionChat Toggle<cr>")
      vim.keymap.set("v", "gA", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
    end, ]]
    -- vim.cmd([[cabbrev cc CodeCompanion]])
  },
  { -- copilot
    "zbirenbaum/copilot.lua",
    -- enabled = false,
    cmd = "Copilot",
    keys = { -- Example mapping to toggle outline
      { "<leader>cc", "<cmd>Copilot<CR>", desc = "Copilot" },
      { "<leader>ct", "<cmd>Copilot toggle<CR>", desc = "Copilot toggle" },
      { "<leader>cd", "<cmd>Copilot detach<CR>", desc = "Copilot detach" },
      { "<leader>ca", "<cmd>Copilot attach<CR>", desc = "Copilot attach" },
      { "<leader>cp", "<cmd>Copilot panel<CR>", desc = "Copilot panel" },
    },
    dependencies = { { "zbirenbaum/copilot-cmp", config = true } },
    opts = {
      filetypes = { ["*"] = true },
      panel = {
        enabled = true,
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
  { -- avante
    "yetone/avante.nvim",
    -- enabled = false,
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
  { -- "sudo-tee/opencode.nvim",
    "sudo-tee/opencode.nvim",
    enabled = false,
    keys = {
      { "<localleader>oo", "<cmd>Opencode<cr>", desc = "Toggle Opencode" },
    },
    cmd = { "Opencode" },
    opts = {
      prefered_picker = snacks, -- 'telescope', 'fzf', 'mini.pick', 'snacks', if nil, it will use the best available picker
      default_global_keymaps = false, -- If false, disables all default global keymaps
      default_mode = "build", -- 'build' or 'plan' or any custom configured. @see [OpenCode Modes](https://opencode.ai/docs/modes/)
      keymap = {
        global = {
          toggle = "<localleader>oo", -- Open opencode. Close if opened
          open_input = "<localleader>oi", -- Opens and focuses on input window on insert mode
          open_input_new_session = "<localleader>oI", -- Opens and focuses on input window on insert mode. Creates a new session
          open_output = "<localleader>oO", -- Opens and focuses on output window
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
          diff_revert_all = "<localleader>oRa", -- Revert all file changes since the last opencode session
          diff_revert_this = "<localleader>oRt", -- Revert current file changes since the last opencode session
          swap_position = "<localleader>ox", -- Swap Opencode pane left/right
        },
        window = {
          submit = "<cr>", -- Submit prompt (normal mode)
          submit_insert = "<C-s>", -- Submit prompt (insert mode)
          close = "q", -- Close UI windows
          stop = "<C-c>", -- Stop opencode while it is running
          next_message = "]]", -- Navigate to next message in the conversation
          prev_message = "[[", -- Navigate to previous message in the conversation
          mention_file = "@", -- Pick a file and add to context. See File Mentions section
          toggle_pane = "<tab>", -- Toggle between input and output panes
          prev_prompt_history = "<up>", -- Navigate to previous prompt in history
          next_prompt_history = "<down>", -- Navigate to next prompt in history
          switch_mode = "<localleader>om", -- Switch between modes (build/plan)
          focus_input = "i", -- Focus on input window and enter insert mode at the end of the input from the output window
          debug_messages = "<localleader>oD", -- Open raw message in new buffer for debugging
          debug_output = "<localleader>oO", -- Open raw output in new buffer for debugging
        },
      },
      ui = {
        window_width = 0.30,
        input_height = 0.20,
        output = {
          tools = {
            show_output = true, -- Show tools output [diffs, cmd output, etc.] (default: true)
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
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
  { -- minuet-ai
    "milanglacier/minuet-ai.nvim",
    enabled = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("minuet").setup({
        provider = "openai_fim_compatible",
        -- provider = "openai_compatible",
        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM",
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "qwen2.5-coder:7b",
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
            --[[ end_point = "https://api.deepseek.com/beta/completions",
            api_key = function()
              return "sk-e229a6f4cadf426ea7e3972b09d03f02"
            end,
            name = "deepseek",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            }, ]]
          },
          openai_compatible = {
            end_point = "https://api.deepseek.com",
            api_key = function()
              return "sk-e229a6f4cadf426ea7e3972b09d03f02"
            end,
            name = "deepseek",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
      })
    end,
  },
  { -- "Davidyz/VectorCode",
    "Davidyz/VectorCode",
    enabled = false,
    version = "*", -- optional, depending on whether you're on nightly or release
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "VectorCode", -- if you're lazy-loading VectorCode
    build = "uv tool upgrade vectorcode",
  },
}
