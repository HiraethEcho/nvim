local tex={
  "lervag/vimtex",
  ft= {"bib","tex"},
  config = function ()
    -- vim.g.vimtex_view_general_viewer = 'sioyek'
    -- vim.g.vimtex_view_general_options = ''
    vim.g.tex_comment_nospell = 1
    vim.g.vimtex_fold_enabled = 1
    -- g:vimtex_mappings_prefix
    -- vim.g.vimtex_quickfix_enabled = 0
    vim.g.vimtex_toc_config = {
      name        =  'TOC',
      layers      =  {'label', 'todo', 'include'},
      split_width =  30,
      todo_sorted =  1,
      show_help   =  1,
      show_numbers=  2,
    }
    vim.g.vimtex_quickfix_ignore_filters = {
      'Underfull \\\\hbox',
      'Overfull \\\\hbox',
      'LaTeX Warning:  float specifier changed to',
      'LaTeX Warning: The counter will not be printed',
      'LaTeX Warning: Marginpair on page ',
      'LaTeX Font Warning: Font shape ',
      'LaTeX hooks Warning',
      'Package siunitx Warning: Detected the "physics" package:',
      'Package hyperref Warning: Token not allowed in a PDF string',
    }
    -- let g:vimtex_view_general_viewer = 'sioyek'
  end,
}

local wiki={
  "vimwiki/vimwiki",
  ft={"md"},
}
-- TODO: markdown preview and editor
local md={
  -- use({ 'toppair/peek.nvim', run = 'deno task --quiet build:fast' })
  "toppair/peek.nvim",
  enabled = false,
  build ="deno task --quiet build:fast",
  ft="md",
  lazy=false,
  config = function()
    require('peek').setup({
      auto_load = false,         -- whether to automatically load preview when
      -- entering another markdown buffer
      close_on_bdelete = true,  -- close preview window on buffer delete
      syntax = true,            -- enable syntax highlighting, affects performance
      theme = 'dark',           -- 'dark' or 'light'
      update_on_change = true,
      app = 'browser',          -- 'webview', 'browser', string or a table of strings
      -- explained below
      filetype = { 'markdown' } -- list of filetypes to recognize as markdown
      -- relevant if update_on_change is true
      -- throttle_at = 200000,     -- start throttling when file exceeds this
      -- amount of bytes in size
      -- throttle_time = 'auto',   -- minimum amount of time in milliseconds
      -- that has to pass before starting new render
    })
    vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
  end,
}
local spec={tex}

return spec
