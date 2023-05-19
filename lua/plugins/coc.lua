if true then return {} end

return{
  'neoclide/coc.nvim',
  event="InsertEnter",
  -- lazy=false,
  keys ={
    -- {"<Leader>ef" , ":CocCommand explorer --preset floating<CR>"  } ,
    -- {"<Leader>ed" , ":CocCommand explorer --preset Documents<CR>" } ,
    -- {"<Leader>eg" , ":CocCommand explorer --preset github<CR>"    } ,
    -- {"<Leader>ep" , ":CocCommand explorer --preset Projects<CR>"  } ,
    -- {"<Leader>eh" , ":CocCommand explorer --preset hiraeth<CR>"   } ,
    -- {"<leader>en" , ":CocCommand explorer --preset nvim<CR>"      } ,
    -- { "<leader>ee" , ":CocCommand explorer<CR>"                   } ,
    { "<leader>ll" , ":<C-u>CocList<cr>"                          } ,
    { "<leader>le" , ":<C-u>CocList extensions<cr>"               } ,
    -- { "<leader>ly" , ":<C-u>CocList yank<cr>"                     } ,
  },
  event=BufRead,
  branch='release',
  config=function()
    vim.g.coc_global_extensions = {
      "coc-snippets",
      "coc-yank",
      "coc-lists",
      "coc-marketplace",
      "coc-json",
      -- "coc-explorer",
      -- "coc-webview",
      -- "coc-typos",
      -- "coc-git",
      -- "coc-highlight",
      -- "coc-lightbulb",
      -- "coc-cmake",
      -- "coc-vimtex",
      -- "coc-pyright",
      -- "coc-texlab",
    }
    vim.g.coc_node_path = "D:/Downloads/apps/nodejs/current/node.exe"
    function _G.check_back_space()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end
    vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', {silent = true, noremap = true, expr = true, replace_keycodes = false})
    vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], {silent = true, noremap = true, expr = true, replace_keycodes = false})
    vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], {silent = true, noremap = true, expr = true, replace_keycodes = false})
  end,
}
