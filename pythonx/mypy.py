import string, vim, re
texMathZones = ['texMathZone'+x for x in ['A', 'AS', 'B', 'BS', 'C', 'CS', 'D', 'DS', 'E', 'ES', 'F', 'FS', 'G', 'GS', 'H', 'HS', 'I', 'IS', 'J', 'JS', 'K', 'KS', 'L', 'LS', 'DS', 'V', 'W', 'X', 'Y', 'Z']]

texIgnoreMathZones = ['texMathText']

texMathZoneIds = vim.eval('map('+str(texMathZones)+", 'hlID(v:val)')")
texIgnoreMathZoneIds = vim.eval('map('+str(texIgnoreMathZones)+", 'hlID(v:val)')")

ignore = texIgnoreMathZoneIds[0]

def pymath():
    synstackids = vim.eval("synstack(line('.'), col('.') - (col('.')>=2 ? 1 : 0))")
    try:
        first = next(i for i in reversed(synstackids) if i in texIgnoreMathZoneIds or i in texMathZoneIds)
        return first != ignore
    except StopIteration:
        return False
# from https://github.com/CaesarOG/Vim-Latex-Zathura

def math():
    return vim.eval('vimtex#syntax#in_mathzone()') == '1'

def get_comment_format():
  """ Returns a 4-element tuple (first_line, middle_lines, end_line, indent)
  representing the comment format for the current file.

  It first looks at the 'commentstring', if that ends with %s, it uses that.
  Otherwise it parses '&comments' and prefers single character comment
  markers if there are any.
  """
  commentstring = vim.eval("&commentstring")
  if commentstring.endswith("%s"):
    c = commentstring[:-2]
    return (c.rstrip(), c.rstrip(), c.rstrip(), "")
  comments = _parse_comments(vim.eval("&comments"))
  for c in comments:
    if c[0] == "SINGLE_CHAR":
      return c[1:]
  return comments[0][:]

def make_box(twidth, bwidth=None):
  b, m, e, i = (s.strip() for s in get_comment_format())
  m0 = m[0] if m else ''
  bwidth_inner = bwidth - 3 - max(len(b), len(i + e)) if bwidth else twidth + 2
  sline = b + m + bwidth_inner * m0 + 2 * m0
  nspaces = (bwidth_inner - twidth) // 2
  mlines = i + m + " " + " " * nspaces
  mlinee = " " + " "*(bwidth_inner - twidth - nspaces) + m
  eline = i + m + bwidth_inner * m0 + 2 * m0 + e
  return sline, mlines, mlinee, eline

def foldmarker():
  "Return a tuple of (open fold marker, close fold marker)"
  return vim.eval("&foldmarker").split(",")

def display_width(str):
  """Return the required over-/underline length for str."""
  try:
    # Respect &ambiwidth and &tabstop, but old vim may not support this
    return vim.strdisplaywidth(str)
  except AttributeError:
    # Fallback
    from unicodedata import east_asian_width
    result = 0
    for c in str:
      result += 2 if east_asian_width(c) in ('W', 'F') else 1
    return result

