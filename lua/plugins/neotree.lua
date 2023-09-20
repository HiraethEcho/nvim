return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = function()
    if vim.g.is_linux then
      return {
        {
          "<leader>ee",
          "<cmd>Neotree position=left toggle=true<cr>",
          desc = "File tree",
        },
        {
          "<leader>ef",
          "<cmd>Neotree float toggle=true<cr>",
          desc = "File tree float",
        },
        {
          "<leader>en",
          "<cmd>Neotree toggle=true float dir=" .. vim.fn.stdpath("config") .. " <cr>",
          desc = "nvim file float",
        },
        {
          "<leader>ep",
          "<cmd>Neotree toggle=true float dir=~/projects <cr>",
          desc = "Projects file float",
        },
        {
          "<leader>eh",
          "<cmd>Neotree toggle=true float dir=~<cr>",
          desc = "home file float",
        },
        {
          "<leader>et",
          "<cmd>Neotree toggle=true float dir=~/tmp <cr>",
          desc = "tmp file float",
        },
        {
          "<leader>eb",
          "<cmd>Neotree toggle=true float dir=~/blogs <cr>",
          desc = "blogs file float",
        },
        {
          "<leader>gs",
          "<cmd>Neotree source=git_status <cr>",
          desc = "git_status",
        },
      }
    else
      return {
        {
          "<leader>ee",
          "<cmd>Neotree position=left toggle=true<cr>",
          desc = "File tree",
        },
        {
          "<leader>ef",
          "<cmd>Neotree float toggle=true<cr>",
          desc = "File tree float",
        },
        {
          "<leader>eb",
          "<cmd>Neotree toggle=true float source=buffers<cr>",
          desc = "buffers float",
        },
        {
          "<leader>en",
          "<cmd>Neotree toggle=true float dir=" .. vim.fn.stdpath("config") .. " <cr>",
          desc = "nvim file float",
        },
        {
          "<leader>eg",
          "<cmd>Neotree toggle=true float dir=~/github<cr>",
          desc = "win github file float",
        },
        {
          "<leader>eG",
          "<cmd>Neotree toggle=true float dir=~/Github_arch<cr>",
          desc = "arch Github file float",
        },
        {
          "<leader>ep",
          "<cmd>Neotree toggle=true float dir=~/documents/Projects <cr>",
          desc = "Projects file float",
        },
        {
          "<leader>ed",
          "<cmd>Neotree toggle=true float dir=~/documents<cr>",
          desc = "documents file float",
        },
        {
          "<leader>eo",
          "<cmd>Neotree toggle=true float dir=~/obsidian<cr>",
          desc = "obsidian file float",
        },
        {
          "<leader>es",
          "<cmd>Neotree toggle=true float dir=~/site<cr>",
          desc = "site file float",
        },
        {
          "<leader>eh",
          "<cmd>Neotree toggle=true float dir=~<cr>",
          desc = "home file float",
        },
        {
          "<leader>gs",
          "<cmd>Neotree source=git_status <cr>",
          desc = "git_status",
        },
      }
    end
  end,

  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "MunifTanjim/nui.nvim" },
    {
      "s1n7ax/nvim-window-picker",
      config = function()
        require("window-picker").setup({
          autoselect_one = true,
          include_current = false,
        })
      end,
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
    filesystem = {
      bind_to_cwd = true,
    },
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    commands = {
      system_open = function(state)
        require("config.util").system_open(state.tree:get_node():get_id())
      end,
      copy_selector = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local results = {
          e = { val = modify(filename, ":e"), msg = "Extension only" },
          f = { val = filename, msg = "Filename" },
          F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
          h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
          p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
          P = { val = filepath, msg = "Absolute path" },
        }

        local messages = {
          { "\nChoose to copy to clipboard:\n", "Normal" },
        }
        for i, result in pairs(results) do
          if result.val and result.val ~= "" then
            vim.list_extend(messages, {
              { ("%s."):format(i),           "Identifier" },
              { (" %s: "):format(result.msg) },
              { result.val,                  "String" },
              { "\n" },
            })
          end
        end
        vim.api.nvim_echo(messages, false, {})
        local result = results[vim.fn.getcharstr()]
        if result and result.val and result.val ~= "" then
          utils.notify(("Copied: `%s`"):format(result.val))
          vim.fn.setreg("+", result.val)
        end
      end,
    },
    window = {
      mappings = {
        x = "system_open",
        Y = "copy_selector",
        ["l"] = {
          "toggle_node",
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        -- ["<esc>"] = "revert_preview",
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["L"] = "focus_preview",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["S"] = "split_with_window_picker",
        ["V"] = "vsplit_with_window_picker",
        ["t"] = "open_tabnew",
        ["h"] = "close_node",
        ["zM"] = "close_all_nodes",
        ["zR"] = "expand_all_nodes",
        ["a"] = {
          "add",
          config = {
            show_path = "none", -- "none", "relative", "absolute"
          },
        },
        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
        ["D"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["dd"] = "cut_to_clipboard",
        -- ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        -- ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
        -- ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
        ["q"] = "close_window",
        ["<esc>"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["[b"] = "prev_source",
        ["]b"] = "next_source",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        -- ["H"] = "toggle_hidden",
        ["zh"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        -- ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        -- ["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
      },
    },
    default_component_configs = {
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰉖",
      },
      git_status = {
        symbols = {
          added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "", -- this can only be used in the git_status source
          renamed = "󰁕",
          -- Status type
          untracked = "",
          ignored = "◌",
          unstaged = "✗",
          staged = "✓",
          conflict = "",
        },
      },
    },
  },
}
