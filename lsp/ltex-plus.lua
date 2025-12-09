local language_id_mapping = {
  bib = 'bibtex',
  -- pandoc = 'markdown',
  plaintex = 'tex',
  -- rnoweb = 'rsweave',
  -- rst = 'restructuredtext',
  tex = 'latex',
  text = 'plaintext',
}

---@type vim.lsp.Config
return {
  cmd = { 'ltex-ls-plus' },
  filetypes = {
    'bib',
    'context',
    'gitcommit',
    'html',
    'markdown',
    'org',
    'pandoc',
    'plaintex',
    'quarto',
    'mail',
    'mdx',
    'rmd',
    'rnoweb',
    'rst',
    'tex',
    'text',
    'typst',
    'xhtml',
  },
  root_markers = { '.git' },
  get_language_id = function(_, filetype)
    return language_id_mapping[filetype] or filetype
  end,
  settings = {
    ltex = {
      enabled = {
        'bib',
        'context',
        'gitcommit',
        'html',
        'markdown',
        'org',
        'pandoc',
        'plaintex',
        'quarto',
        'mail',
        'mdx',
        'rmd',
        'rnoweb',
        'rst',
        'tex',
        'latex',
        'text',
        'typst',
        'xhtml',
      },
    },
  },
}
