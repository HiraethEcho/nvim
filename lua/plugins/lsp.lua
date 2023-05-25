-- if true then return {} end
local tree={
  'nvim-treesitter/nvim-treesitter',
  -- lazy=false,
  ft={'lua','md','latex','tex','bib'},
  -- 'do': ':TSUpdate'
  config=function()
    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = { "c", "lua", "latex","markdown"  },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      -- List of parsers to ignore installing (for "all")
      -- ignore_install = { "javascript" },

      ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
      -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

      highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        --
        -- disable = function(lang, buf)
          --     local max_filesize = 100 * 1024 -- 100 KB
          --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          --     if ok and stats and stats.size > max_filesize then
          --         return true
          --     end
          -- end,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  }

  local lsp={
    {
      "neovim/nvim-lspconfig",
      lazy=false,
      config=function()
        require'lspconfig'.texlab.setup{}
      end,
    },
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate" ,-- :MasonUpdate updates registry contents
      lazy=false,
      config=function()
        require("mason").setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗"
            }
          }
        })
        local DEFAULT_SETTINGS = {
          -- The directory in which to install packages.
          -- install_root_dir = path.concat { vim.fn.stdpath "data", "mason" },

          -- Where Mason should put its bin location in your PATH. Can be one of:
          -- - "prepend" (default, Mason's bin location is put first in PATH)
          -- - "append" (Mason's bin location is put at the end of PATH)
          -- - "skip" (doesn't modify PATH)
          ---@type '"prepend"' | '"append"' | '"skip"'
          -- PATH = "prepend",

          -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
          -- debugging issues with package installations.
          -- log_level = vim.log.levels.INFO,

          -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
          -- packages that are requested to be installed will be put in a queue.
          -- max_concurrent_installers = 4,

          -- [Advanced setting]
          -- The registries to source packages from. Accepts multiple entries. Should a package with the same name exist in
          -- multiple registries, the registry listed first will be used.
          registries = {
            "github:mason-org/mason-registry",
          },

          -- The provider implementations to use for resolving supplementary package metadata (e.g., all available versions).
          -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
          -- Builtin providers are:
          --   - mason.providers.registry-api  - uses the https://api.mason-registry.dev API
          --   - mason.providers.client        - uses only client-side tooling to resolve metadata
          providers = {
            "mason.providers.registry-api",
            "mason.providers.client",
          },

          github = {
            -- The template URL to use when downloading assets from GitHub.
            -- The placeholders are the following (in order):
            -- 1. The repository (e.g. "rust-lang/rust-analyzer")
            -- 2. The release version (e.g. "v0.3.0")
            -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
            download_url_template = "https://github.com/%s/releases/download/%s/%s",
          },

          pip = {
            -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
            upgrade_pip = false,

            -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
            -- and is not recommended.
            --
            -- Example: { "--proxy", "https://proxyserver" }
            install_args = {},
          },

          ui = {
            -- Whether to automatically check for new versions when opening the :Mason window.
            check_outdated_packages_on_open = true,

            -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
            border = "none",

            -- Width of the window. Accepts:
            -- - Integer greater than 1 for fixed width.
            -- - Float in the range of 0-1 for a percentage of screen width.
            width = 0.8,

            -- Height of the window. Accepts:
            -- - Integer greater than 1 for fixed height.
            -- - Float in the range of 0-1 for a percentage of screen height.
            height = 0.9,

            icons = {
              -- The list icon to use for installed packages.
              package_installed = "◍",
              -- The list icon to use for packages that are installing, or queued for installation.
              package_pending = "◍",
              -- The list icon to use for packages that are not installed.
              package_uninstalled = "◍",
            },

            keymaps = {
              -- Keymap to expand a package
              toggle_package_expand = "<CR>",
              -- Keymap to install the package under the current cursor position
              install_package = "i",
              -- Keymap to reinstall/update the package under the current cursor position
              update_package = "u",
              -- Keymap to check for new version for the package under the current cursor position
              check_package_version = "c",
              -- Keymap to update all installed packages
              update_all_packages = "U",
              -- Keymap to check which installed packages are outdated
              check_outdated_packages = "C",
              -- Keymap to uninstall a package
              uninstall_package = "X",
              -- Keymap to cancel a package installation
              cancel_installation = "<C-c>",
              -- Keymap to apply language filter
              apply_language_filter = "/",
            },
          },
        }

      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      lazy=false,
      config=function()
        require("mason-lspconfig").setup()
      end,
    },
  }




  local spec={
    tree,
    lsp,
  }

  return spec
