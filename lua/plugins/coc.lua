return {
  "neoclide/coc.nvim",
  -- event = "InsertEnter",
  lazy = false,
  keys = {
    { "<leader>ce", ":CocCommand explorer<CR>" },
    { "<leader>cl", ":<C-u>CocList<cr>" },
    -- { "<leader>cle", ":<C-u>CocList extensions<cr>" },
    -- { "<leader>ly" , ":<C-u>CocList yank<cr>"                     } ,
  },
  branch = "release",
  config = function()
    vim.g.coc_global_extensions = {
      "coc-snippets",
      "coc-pairs",
      -- "coc-yank",
      "coc-lists",
      "coc-marketplace",
      "coc-json",
      "coc-explorer",
      -- "coc-highlight",
      -- "coc-lightbulb",
      -- "coc-vimtex",
      -- "coc-texlab",
    }
    local keyset = vim.keymap.set
    function _G.check_back_space()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
    keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
    keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
    -- Make <CR> to accept selected completion item or notify coc.nvim to format
    -- <C-g>u breaks current undo, please make your own choice
    keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
    keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
    keyset("v", "<BS>", "<Plug>(coc-snippets-select)")
    -- keyset("i", "<cr>", "<Plug>(coc-snippets-expand)")
    -- Use <c-space> to trigger completion
    keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })
    -- Use `[g` and `]g` to navigate diagnostics
    -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
    keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
    keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

    -- GoTo code navigation
    keyset("n", "cgd", "<Plug>(coc-definition)", { silent = true })
    keyset("n", "cgy", "<Plug>(coc-type-definition)", { silent = true })
    keyset("n", "cgi", "<Plug>(coc-implementation)", { silent = true })
    keyset("n", "cgr", "<Plug>(coc-references)", { silent = true })


    -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
    vim.api.nvim_create_augroup("CocGroup", {})
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "CocGroup",
      command = "silent call CocActionAsync('highlight')",
      desc = "Highlight symbol under cursor on CursorHold"
    })



    -- Formatting selected code
    keyset("x", "<leader>F", "<Plug>(coc-format-selected)", { silent = true })
    keyset("n", "<leader>F", "<Plug>(coc-format-selected)", { silent = true })


    -- Setup formatexpr specified filetype(s)
    vim.api.nvim_create_autocmd("FileType", {
      group = "CocGroup",
      pattern = "lua,json",
      command = "setl formatexpr=CocAction('formatSelected')",
      desc = "Setup formatexpr specified filetype(s)."
    })

    -- Update signature help on jump placeholder
    vim.api.nvim_create_autocmd("User", {
      group = "CocGroup",
      pattern = "CocJumpPlaceholder",
      command = "call CocActionAsync('showSignatureHelp')",
      desc = "Update signature help on jump placeholder"
    })

    -- Apply codeAction to the selected region
    -- Example: `<leader>aap` for current paragraph
    local opts = { silent = true, nowait = true }
    keyset("x", "<leader>ca", "<Plug>(coc-codeaction-selected)", opts)
    keyset("n", "<leader>ca", "<Plug>(coc-codeaction-selected)", opts)

    -- Remap keys for apply code actions at the cursor position.
    keyset("n", "<leader>cac", "<Plug>(coc-codeaction-cursor)", opts)
    -- Remap keys for apply source code actions for current file.
    keyset("n", "<leader>cas", "<Plug>(coc-codeaction-source)", opts)
    -- Apply the most preferred quickfix action on the current line.
    keyset("n", "<leader>cqf", "<Plug>(coc-fix-current)", opts)

    -- Remap keys for apply refactor code actions.
    keyset("n", "<leader>cre", "<Plug>(coc-codeaction-refactor)", { silent = true })
    keyset("x", "<leader>cr", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
    keyset("n", "<leader>cr", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

    -- Run the Code Lens actions on the current line
    keyset("n", "<leader>ccl", "<Plug>(coc-codelens-action)", opts)


    -- Map function and class text objects
    -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
    -- keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
    -- keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
    -- keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
    -- keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
    -- keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
    -- keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
    -- keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
    -- keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


    -- Remap <C-f> and <C-b> to scroll float windows/popups
    ---@diagnostic disable-next-line: redefined-local
    local opts = { silent = true, nowait = true, expr = true }
    keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
    keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
    keyset("i", "<C-f>",
      'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
    keyset("i", "<C-b>",
      'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
    keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
    keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


    -- Use CTRL-S for selections ranges
    -- Requires 'textDocument/selectionRange' support of language server
    -- keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
    -- keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })


    -- Add `:Format` command to format current buffer
    vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

    -- " Add `:Fold` command to fold current buffer
    vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

    -- Add `:OR` command for organize imports of the current buffer
    vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

    -- Add (Neo)Vim's native statusline support
    -- NOTE: Please see `:h coc-status` for integrations with external plugins that
    -- provide custom statusline: lightline.vim, vim-airline
    -- vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

    -- Mappings for CoCList
    -- code actions and coc stuff
    ---@diagnostic disable-next-line: redefined-local
    local opts = { silent = true, nowait = true }
    keyset("n", "<space>cll", ":<C-u>CocList<cr>", opts)
    -- Show all diagnostics
    keyset("n", "<space>cla", ":<C-u>CocList diagnostics<cr>", opts)
    -- Manage extensions
    keyset("n", "<space>cle", ":<C-u>CocList extensions<cr>", opts)
    -- Show commands
    keyset("n", "<space>clc", ":<C-u>CocList commands<cr>", opts)
    -- Find symbol of current document
    keyset("n", "<space>clo", ":<C-u>CocList outline<cr>", opts)
    -- Search workspace symbols
    keyset("n", "<space>cls", ":<C-u>CocList -I symbols<cr>", opts)
    -- Do default action for next item
    keyset("n", "<space>cj", ":<C-u>CocNext<cr>", opts)
    -- Do default action for previous item
    keyset("n", "<space>ck", ":<C-u>CocPrev<cr>", opts)
    -- Resume latest coc list
    keyset("n", "<space>cp", ":<C-u>CocListResume<cr>", opts)
  end,
}
