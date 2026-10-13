return {
  { -- "Julian/lean.nvim",
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    dependencies = {
      -- optional dependencies:
      -- 'nvim-telescope/telescope.nvim', -- for Lean-specific pickers
      -- 'andrewradev/switch.vim',        -- for switch support
      -- 'tomtom/tcomment_vim',           -- for commenting
    },
    opts = { -- see the manual for full configuration options
      mappings = true,
    },
  },
  {
    "nghiant03/jove.nvim",
    version = "v*",
    cmd = { "Jove", "JoveReload" },
    opts = {
      auto_kernel = true,
      jupytext = "jupytext", -- path to the jupytext binary
      bridge_python = "python3", -- fallback Python for the kernel helper
      auto_kernel = true, -- start kernel automatically on open
      auto_import_outputs = true, -- render persisted outputs on open/reload
      auto_export_outputs = true, -- merge session outputs into the notebook on save
      persist_exec_counts = true, -- persist kernel execution counts into the notebook
      elapsed = true, -- show per-cell elapsed execution time
      auto_reload = false, -- auto-reload when the notebook changes on disk
      cell_motions = true, -- map cell motions
      signs = {
        queued = "…", -- gutter sign: queued for execution
        running = "▶", -- gutter sign: currently running
        ok = "✓", -- gutter sign: finished successfully
        error = "✗", -- gutter sign: finished with an error
      },
      output = {
        max_lines = 50, -- inline output truncation limit
        images = true, -- render images via snacks.image when available
        image_max_width = 80, -- cap rendered image width in terminal cells
        image_max_height = 40, -- cap rendered image height in terminal cells
        header = true, -- draw the Output top frame
        guide = "▎ ", -- per-line inner output rail
        inside_border = false, -- render output inside the cell border instead of its own bordered block below it
        hl = nil, -- output background tint
      },
      variables = {
        auto_refresh = true, -- refresh the variables inspector on idle
        size = 0.25, -- sidebar size as a fraction of the screen
      },
      ui = {
        conceal_headers = true, -- conceal cell headers
        active_cell = true, -- highlight the active cell
        exec_counts = true, -- show per-cell execution counts
        elapsed = true, -- show per-cell elapsed time
        borders = true, -- draw a closing line below each cell
        border_hl = nil, -- cell border highlight
        window_mode = "vsplit", -- all Jove viewers: "vsplit" (right), "hsplit" (below), or "float"
        window_overrides = {}, -- optional per-view modes: sidebar, output, inspect, webview
      },
      lsp = {
        auto_attach = false, -- start the servers in `servers` on notebook open
        servers = {}, -- language id to lsp server names,
      },
      webview = {
        enabled = true,
        cmd = "terminal-browser", -- terminal-browser binary
        width = 0.5, -- webview width in float/vsplit mode, as a fraction of the editor
        height = 0.5, -- webview height in float/hsplit mode, as a fraction of the editor
      },
    },
  },
  { -- "mihovilrak/scroll.nvim",
    "mihovilrak/scroll.nvim",
    cmd = { "ScrollToggle", "ScrollEnable", "ScrollDisable", "ScrollMinimapToggle" },
    opts = {
      horizontal = { enabled = false },
      visibility = "always", -- "auto" | "always" | "hover"
      minimap = {
        enable = true,
        min_window_width = 80, -- not drawn in narrower windows
        winblend = 0,
        autohide = false, -- hide along with the scrollbars under `visibility`
        excluded_filetypes = { "ministarter" },
      },
      winblend = 30, -- 0 = opaque, 100 = invisible
      zindex = 40, -- below completion popups, above window text
      excluded_filetypes = { "help", "qf", "NvimTree", "neo-tree", "TelescopePrompt", "lazy", "mason" },
      excluded_buftypes = { "terminal", "prompt", "nofile", "quickfix" },
    },
  },
  { -- "FluxxField/bionic-reading.nvim",
    "FluxxField/bionic-reading.nvim",
    -- enabled = false,
    cmd = "BRToggle",
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
