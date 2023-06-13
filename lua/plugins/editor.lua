local tex = {
  "lervag/vimtex",
  ft= {"bib","tex"},
  config = function ()
    vim.g.vimtex_view_general_viewer = 'sioyek'
    vim.g.vimtex_view_general_options = ''
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


local md = {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  ft = { "markdown" },
  config=function()
    -- vim.g.mkdp_browser = 'surf'
    -- vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. '/colors/markdown.css'
    -- vim.g.mkdp_theme = 'dark'
    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_page_title = '「${name}」'
    vim.g.mkdp_filetypes = {'markdown','md'}
  end,
}

local knapnvim={
  -- lazy = false,
  ft={"latex","tex"},
  cmd="KnapProcess",
  "frabjous/knap",
  config=function ()
    local gknapsettings = {
      textopdfviewerlaunch= "sioyek --new-window %outputfile%",
      mdoutputext = "html",
      textopdfforwardjump= "sioyek --reuse-window --forward-search-file %srcfile% --forward-search-line %line% %outputfile%",
      texoutputext = "pdf",
      textopdf = "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
      textopdfviewerrefresh = "kill -HUP %pid%",
      htmltohtmlviewerlaunch= "live-server --quiet --browser=surf --open=%outputfile% --watch=%outputfile% --wait=800",
      htmltohtmlviewerrefresh= "none",
      -- mdtohtmlviewerlaunch= "live-server --quiet --browser=microsoft-edge-beta --open=%outputfile% --watch=%outputfile% --wait=800",
      mdtohtmlviewerrefresh= "none",
    }
    vim.g.knap_settings = gknapsettings

    vim.api.nvim_create_user_command('KnapProcess',require('knap').process_once,{})
    vim.api.nvim_create_user_command('KnapCloseViewer',require('knap').close_viewer,{})
    vim.api.nvim_create_user_command('KnapToggleAutoPreviewing', require('knap').toggle_autopreviewing,{})
    vim.api.nvim_create_user_command('KnapJumpForward',require('knap').forward_jump,{})
  end
}

local spec={
  tex,
  md,
  knapnvim,
}
return spec
