return {
  { -- CopilotChat
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "CopilotChatToggle" },
    dependencies = {
      "zbirenbaum/copilot.lua",
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    -- See Commands section for default commands if you want to lazy load on them
    config = function()
      local chat = require("CopilotChat")
      chat.setup({
        mappings = {
          reset = { normal = "<C-S-L>", insert = "<C-S-L>" },
          show_diff = { full_diff = true },
        },
      })
      -- local mcp = require("mcphub")
    end,
  },
  { -- codecompanion
    "olimorris/codecompanion.nvim",
    -- enabled = false,
    -- event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ravitemer/mcphub.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<localleader>c", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle codecompanion chat" },
    },
    opts = {
      adapters = {
        --[[ ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            env = { url = "http://localhost:11434" },
            parameters = { sync = true },
            schema = { model = { default = "qwen2.5-coder:7b" } },
          })
        end, ]]
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = "sk-e229a6f4cadf426ea7e3972b09d03f02",
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        agent = { adapter = "copilot" },
        cmd = { adapter = "copilot" },
      },
      extensions = {
        mcphub = {
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
        },
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
  { -- mcphub
    "ravitemer/mcphub.nvim",
    -- enabled = false,
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
  { -- "sudo-tee/opencode.nvim",
    "sudo-tee/opencode.nvim",
    -- enabled = false,
    cmd = { "Opencode" },
    opts = {
      prefered_picker = snacks, -- 'telescope', 'fzf', 'mini.pick', 'snacks', if nil, it will use the best available picker
      default_global_keymaps = false, -- If false, disables all default global keymaps
      default_mode = "build", -- 'build' or 'plan' or any custom configured. @see [OpenCode Modes](https://opencode.ai/docs/modes/)
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
          switch_mode = "<M-m>", -- Switch between modes (build/plan)
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
  { -- avante
    "yetone/avante.nvim",
    enabled = false,
    build = "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      keys = function(_, keys)
        local opts =
          require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)
        local mappings = {
          {
            opts.mappings.ask,
            function()
              require("avante.api").ask()
            end,
            desc = "avante: ask",
            mode = { "n", "v" },
          },
          {
            opts.mappings.refresh,
            function()
              require("avante.api").refresh()
            end,
            desc = "avante: refresh",
            mode = "v",
          },
          {
            opts.mappings.edit,
            function()
              require("avante.api").edit()
            end,
            desc = "avante: edit",
            mode = { "n", "v" },
          },
        }
        mappings = vim.tbl_filter(function(m)
          return m[1] and #m[1] > 0
        end, mappings)
        return vim.list_extend(mappings, keys)
      end,
      -- mcp-hub
      -- system_prompt as function ensures LLM always has latest MCP server state This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
      -- provider = "copilot",
      provider = "ollama",
      providers = {
        ollama = {
          endpoint = "http://localhost:11434",
          model = "qwen2.5-coder:7b",
        },
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "sk-e229a6f4cadf426ea7e3972b09d03f02",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-coder",
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim", -- for input provider snacks
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      "ravitemer/mcphub.nvim",
    },
  },
}
