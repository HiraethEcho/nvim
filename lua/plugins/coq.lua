if true then return {} end
local coq ={
  "ms-jpq/coq_nvim",
  branch = "coq",
  event="InsertEnter",
  dependencies = {
    {
      "ms-jpq/coq.artifacts",
      branch = "artifacts",
    },
    {
      "ms-jpq/coq.thirdparty",
      branch = "3p",
      config = function()
        require "coq_3p" {
          { src = "nvimlua", short_name = "", conf_only = false },

          { src = "vimtex",  short_name = "TEX" },
        }
      end,
    },
  },
  config = function()
    vim.g.coq_settings = {
      display = {
        icons = {
          mode = "short",
          spacing = 0,
        },
      },
      keymap = {
        recommended = false,
      },
    }
    local coq = require "coq"
    coq.Now() -- Start coq
    local remap = vim.api.nvim_set_keymap
    remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
    -- remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
    remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
    remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })
  end,
}
return coq
