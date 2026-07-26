-- paper: a warm, low-contrast colorscheme
-- feels like reading on real paper, easy on the eyes
-- supports light and dark backgrounds via vim.o.background

local style = vim.o.background or "light"

local colors

if style == "dark" then
  colors = {
    bg        = "#353538",
    bg_dark   = "#3a3a3d",
    bg_darker = "#404045",
    bg_float  = "#37373a",
    fg        = "#d8dee9",
    fg_dim    = "#c0c5ce",
    fg_subtle = "#8a9098",
    fg_faint  = "#5a6068",

    string    = "#a3be8c",
    keyword   = "#81a1c1",
    func      = "#88c0d0",
    number    = "#b48ead",
    type      = "#8fbcbb",
    constant  = "#a3be8c",
    special   = "#b48ead",
    operator  = "#81a1c1",

    border    = "#5a5a62",
    selection = "#424250",
    search    = "#4a5040",
    incsearch = "#606840",

    error     = "#bf616a",
    warn      = "#d08770",
    info      = "#81a1c1",
    hint      = "#8fbcbb",
    ok        = "#a3be8c",

    add       = "#283228",
    change    = "#323228",
    delete    = "#322828",
  }
else
  colors = {
    bg        = "#d3cfc8",
    bg_dark   = "#c8c4c0",
    bg_darker = "#c2beb9",
    bg_float  = "#d8d4cd",
    fg        = "#333028",
    fg_dim    = "#45403a",
    fg_subtle = "#656058",
    fg_faint  = "#908b82",

    string    = "#5a6a52",
    keyword   = "#4a5270",
    func      = "#5a4a3a",
    number    = "#6a5a3a",
    type      = "#3a5a6a",
    constant  = "#4a6a52",
    special   = "#5a526a",
    operator  = "#4a5a5a",

    border    = "#a09888",
    selection = "#c8c4ba",
    search    = "#d2ceb8",
    incsearch = "#c0b898",

    error     = "#723a3a",
    warn      = "#726a3a",
    info      = "#3a4a72",
    hint      = "#3a6a6a",
    ok        = "#3a6a3a",

    add       = "#cdd5c5",
    change    = "#d5d0c0",
    delete    = "#d5c5c5",
  }
end

local function hi(group, opts)
  local s = {}
  if opts.fg then s.fg = opts.fg end
  if opts.bg then s.bg = opts.bg end
  if opts.sp then s.sp = opts.sp end
  if opts.bold then s.bold = true end
  if opts.italic then s.italic = true end
  if opts.underline then s.underline = true end
  if opts.undercurl then s.undercurl = true end
  if opts.strikethrough then s.strikethrough = true end
  if opts.reverse then s.reverse = true end
  if opts.nocombine then s.nocombine = true end
  if opts.blend then s.blend = opts.blend end
  if opts.link then
    vim.api.nvim_set_hl(0, group, { link = opts.link })
  else
    vim.api.nvim_set_hl(0, group, s)
  end
end

-- cleanup
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "paper"
vim.o.background = style

local cursor_bg = style == "dark" and "#9098a0" or "#1a2028"

-- ── editor base ────────────────────────────────────────────
hi("Normal",       { fg = colors.fg, bg = colors.bg })
hi("NonText",      { fg = colors.fg_faint })
hi("SpecialKey",   { fg = colors.fg_faint })
hi("EndOfBuffer",  { fg = colors.bg })
hi("Conceal",      { fg = colors.fg_subtle })

-- cursor
hi("Cursor",       { fg = colors.bg, bg = cursor_bg })
hi("lCursor",      { fg = colors.bg, bg = cursor_bg })
hi("CursorIM",     { fg = colors.bg, bg = cursor_bg })
hi("TermCursor",   { reverse = true })
hi("TermCursorNC", { fg = colors.fg, bg = colors.bg_dark })

-- line / column
hi("CursorLine",       { bg = colors.bg_dark })
hi("CursorLineNr",     { fg = colors.fg, bg = colors.bg_dark, bold = true })
hi("CursorLineSign",   { bg = colors.bg_dark })
hi("CursorLineFold",   { bg = colors.bg_dark })
hi("CursorColumn",     { bg = colors.bg_dark })
hi("ColorColumn",      { bg = colors.bg_dark })
hi("LineNr",           { fg = colors.fg_faint })
hi("LineNrAbove",      { fg = colors.fg_faint })
hi("LineNrBelow",      { fg = colors.fg_faint })
hi("SignColumn",       { bg = colors.bg })

-- folding
hi("Folded",       { fg = colors.fg_subtle, bg = colors.bg_darker })
hi("FoldColumn",   { fg = colors.fg_subtle })

-- visual / selection
hi("Visual",       { bg = colors.selection })
hi("VisualNOS",    { bg = colors.selection })

-- search
hi("Search",       { bg = colors.search })
hi("IncSearch",    { bg = colors.incsearch, bold = true })
hi("CurSearch",    { bg = colors.incsearch, bold = true })

-- status / tabline
hi("StatusLine",        { fg = colors.fg, bg = colors.bg_darker })
hi("StatusLineNC",      { fg = colors.fg_subtle, bg = colors.bg_darker })
hi("StatusLineTerm",    { link = "StatusLine" })
hi("StatusLineTermNC",  { link = "StatusLineNC" })
hi("TabLine",           { fg = colors.fg_subtle, bg = colors.bg_darker })
hi("TabLineSel",        { fg = colors.fg, bg = colors.bg })
hi("TabLineFill",       { bg = colors.bg_darker })
hi("MsgArea",           { fg = colors.fg })
hi("MsgSeparator",      { fg = colors.fg_subtle })
hi("ModeMsg",           { fg = colors.fg, bold = true })
hi("MoreMsg",           { fg = colors.info })
hi("WarningMsg",        { fg = colors.warn })
hi("Question",          { fg = colors.info })
hi("Title",             { fg = colors.keyword, bold = true })
hi("Directory",         { fg = colors.keyword })

-- windows / splits
hi("VertSplit",    { fg = colors.border, bg = colors.bg })
hi("WinSeparator", { fg = colors.border })
hi("WinBar",       { fg = colors.fg_dim, bg = colors.bg_dark })
hi("WinBarNC",     { fg = colors.fg_subtle, bg = colors.bg_darker })

-- floating windows
hi("NormalFloat",        { fg = colors.fg, bg = colors.bg_float })
hi("FloatBorder",        { fg = colors.border })
hi("FloatTitle",         { fg = colors.keyword, bold = true })
hi("FloatShadow",        { bg = colors.bg_darker, blend = 80 })
hi("FloatShadowThrough", { bg = colors.bg_darker, blend = 99 })

-- popup / completion
hi("Pmenu",           { fg = colors.fg, bg = colors.bg_float })
hi("PmenuSel",        { fg = colors.fg, bg = colors.bg_dark, bold = true })
hi("PmenuSbar",       { bg = colors.bg_darker })
hi("PmenuThumb",      { bg = colors.fg_subtle })
hi("PmenuKind",       { fg = colors.keyword })
hi("PmenuKindSel",    { fg = colors.keyword })
hi("PmenuExtra",      { fg = colors.fg_subtle })
hi("PmenuExtraSel",   { fg = colors.fg_subtle })
hi("PmenuMatch",      { bold = true })
hi("PmenuMatchSel",   { bold = true })
hi("WildMenu",        { fg = colors.fg, bg = colors.bg_dark, bold = true })

-- misc
hi("MatchParen",   { bg = colors.bg_darker, bold = true })
hi("QuickFixLine", { bg = colors.bg_dark })
hi("Substitute",   { bg = colors.bg_darker })
hi("Whitespace",   { fg = colors.fg_faint })
hi("Ignore",       { fg = colors.fg_faint })

-- spelling
hi("SpellBad",   { sp = colors.error, undercurl = true })
hi("SpellCap",   { sp = colors.warn, undercurl = true })
hi("SpellRare",  { sp = colors.info, undercurl = true })
hi("SpellLocal", { sp = colors.hint, undercurl = true })

-- ── syntax ─────────────────────────────────────────────────
hi("Comment",        { fg = colors.fg_subtle, italic = true })

hi("Constant",       { fg = colors.constant })
hi("String",         { fg = colors.string })
hi("Character",      { fg = colors.string })
hi("Number",         { fg = colors.number })
hi("Boolean",        { fg = colors.constant })
hi("Float",          { fg = colors.number })

hi("Identifier",     { fg = colors.fg })
hi("Function",       { fg = colors.func })

hi("Statement",      { fg = colors.keyword })
hi("Conditional",    { fg = colors.keyword })
hi("Repeat",         { fg = colors.keyword })
hi("Label",          { fg = colors.keyword })
hi("Operator",       { fg = colors.operator })
hi("Keyword",        { fg = colors.keyword, bold = true })
hi("Exception",      { fg = colors.keyword })

hi("PreProc",        { fg = colors.special })
hi("Include",        { fg = colors.keyword })
hi("Define",         { fg = colors.special })
hi("Macro",          { fg = colors.special })
hi("PreCondit",      { fg = colors.special })

hi("Type",           { fg = colors.type })
hi("StorageClass",   { fg = colors.type })
hi("Structure",      { fg = colors.type })
hi("Typedef",        { fg = colors.type })

hi("Special",        { fg = colors.special })
hi("SpecialChar",    { fg = colors.special })
hi("Tag",            { fg = colors.keyword })
hi("Delimiter",      { fg = colors.fg })
hi("SpecialComment", { fg = colors.fg_subtle, italic = true })
hi("Debug",          { fg = colors.special })

hi("Underlined",     { underline = true })
hi("Error",          { fg = colors.error })
hi("Todo",           { fg = colors.warn, bg = colors.bg_dark, bold = true })

-- ── diff ───────────────────────────────────────────────────
hi("DiffAdd",    { bg = colors.add })
hi("DiffChange", { bg = colors.change })
hi("DiffDelete", { bg = colors.delete })
hi("DiffText",   { bg = colors.change, bold = true })

-- ── diagnostic ─────────────────────────────────────────────
hi("DiagnosticError",             { fg = colors.error })
hi("DiagnosticWarn",              { fg = colors.warn })
hi("DiagnosticInfo",              { fg = colors.info })
hi("DiagnosticHint",              { fg = colors.hint })
hi("DiagnosticOk",                { fg = colors.ok })
hi("DiagnosticUnderlineError",    { sp = colors.error, undercurl = true })
hi("DiagnosticUnderlineWarn",     { sp = colors.warn, undercurl = true })
hi("DiagnosticUnderlineInfo",     { sp = colors.info, undercurl = true })
hi("DiagnosticUnderlineHint",     { sp = colors.hint, undercurl = true })
hi("DiagnosticUnderlineOk",       { sp = colors.ok, undercurl = true })
hi("DiagnosticVirtualTextError",  { fg = colors.error })
hi("DiagnosticVirtualTextWarn",   { fg = colors.warn })
hi("DiagnosticVirtualTextInfo",   { fg = colors.info })
hi("DiagnosticVirtualTextHint",   { fg = colors.hint })
hi("DiagnosticVirtualTextOk",     { fg = colors.ok })
hi("DiagnosticSignError",         { fg = colors.error })
hi("DiagnosticSignWarn",          { fg = colors.warn })
hi("DiagnosticSignInfo",          { fg = colors.info })
hi("DiagnosticSignHint",          { fg = colors.hint })
hi("DiagnosticSignOk",            { fg = colors.ok })
hi("DiagnosticFloatingError",     { fg = colors.error })
hi("DiagnosticFloatingWarn",      { fg = colors.warn })
hi("DiagnosticFloatingInfo",      { fg = colors.info })
hi("DiagnosticFloatingHint",      { fg = colors.hint })

-- ── lsp ────────────────────────────────────────────────────
hi("LspReferenceText",             { bg = colors.bg_dark })
hi("LspReferenceRead",             { bg = colors.bg_dark })
hi("LspReferenceWrite",            { bg = colors.bg_dark })
hi("LspCodeLens",                  { fg = colors.fg_subtle, italic = true })
hi("LspCodeLensSeparator",         { fg = colors.fg_faint })
hi("LspInlayHint",                 { fg = colors.fg_faint, bg = colors.bg_dark })
hi("LspSignatureActiveParameter",  { bold = true })

-- ── treesitter ─────────────────────────────────────────────
hi("@text.literal",       { link = "Comment" })
hi("@text.reference",     { fg = colors.keyword })
hi("@text.uri",           { fg = colors.info, underline = true })
hi("@text.title",         { fg = colors.keyword, bold = true })
hi("@text.emphasis",      { italic = true })
hi("@text.strong",        { bold = true })
hi("@text.underline",     { underline = true })
hi("@text.strike",        { strikethrough = true })
hi("@text.todo",          { link = "Todo" })
hi("@text.note",          { link = "DiagnosticInfo" })
hi("@text.warning",       { link = "DiagnosticWarn" })
hi("@text.danger",        { link = "DiagnosticError" })
hi("@text.diff.add",      { link = "DiffAdd" })
hi("@text.diff.delete",   { link = "DiffDelete" })

hi("@punctuation.bracket",   { fg = colors.fg })
hi("@punctuation.delimiter", { fg = colors.operator })
hi("@punctuation.special",   { fg = colors.special })

hi("@string",            { link = "String" })
hi("@string.escape",     { fg = colors.special })
hi("@string.regex",      { fg = colors.string })
hi("@string.special",    { fg = colors.special })

hi("@character",         { link = "Character" })
hi("@character.special", { fg = colors.special })

hi("@boolean",           { link = "Boolean" })
hi("@number",            { link = "Number" })
hi("@float",             { link = "Float" })

hi("@function",          { link = "Function" })
hi("@function.builtin",  { fg = colors.func })
hi("@function.call",     { link = "Function" })
hi("@function.macro",    { fg = colors.special })
hi("@method",            { link = "Function" })
hi("@method.call",       { link = "Function" })
hi("@constructor",       { fg = colors.func })

hi("@parameter",           { fg = colors.fg, italic = true })
hi("@parameter.reference", { fg = colors.fg })

hi("@keyword",              { link = "Keyword" })
hi("@keyword.function",     { fg = colors.keyword, bold = true })
hi("@keyword.operator",     { fg = colors.operator })
hi("@keyword.return",       { fg = colors.keyword })
hi("@keyword.conditional",  { link = "Conditional" })
hi("@keyword.repeat",       { link = "Repeat" })
hi("@keyword.exception",    { link = "Exception" })
hi("@keyword.import",       { link = "Include" })
hi("@keyword.directive",    { link = "PreProc" })
hi("@keyword.debug",        { link = "Debug" })

hi("@conditional",  { link = "Conditional" })
hi("@repeat",       { link = "Repeat" })
hi("@label",        { link = "Label" })
hi("@include",      { link = "Include" })
hi("@exception",    { link = "Exception" })

hi("@type",            { link = "Type" })
hi("@type.builtin",    { fg = colors.type })
hi("@type.definition", { fg = colors.type })
hi("@type.qualifier",  { fg = colors.keyword })
hi("@storageclass",    { link = "StorageClass" })

hi("@attribute",          { fg = colors.special })
hi("@field",              { fg = colors.fg })
hi("@property",           { fg = colors.fg })
hi("@variable",           { fg = colors.fg })
hi("@variable.builtin",   { fg = colors.special, italic = true })
hi("@variable.parameter", { link = "@parameter" })
hi("@variable.member",    { link = "@field" })

hi("@constant",         { link = "Constant" })
hi("@constant.builtin", { fg = colors.constant, bold = true })
hi("@constant.macro",   { fg = colors.constant })

hi("@module",    { fg = colors.keyword })
hi("@namespace", { fg = colors.type })

hi("@tag",           { link = "Tag" })
hi("@tag.attribute", { fg = colors.special })
hi("@tag.delimiter", { link = "Delimiter" })

-- ── markdown ───────────────────────────────────────────────
hi("@markup.heading.1", { fg = colors.func, bold = true })
hi("@markup.heading.2", { fg = colors.type, bold = true })
hi("@markup.heading.3", { fg = colors.keyword, bold = true })
hi("@markup.heading.4", { fg = colors.constant, bold = true })
hi("@markup.heading.5", { fg = colors.number, bold = true })
hi("@markup.heading.6", { fg = colors.string, bold = true })

hi("@markup.link",       { fg = colors.info, underline = true })
hi("@markup.link.label", { fg = colors.info })
hi("@markup.link.url",   { fg = colors.fg_subtle, underline = true })

hi("@markup.list",           { fg = colors.special })
hi("@markup.list.checked",   { fg = colors.ok })
hi("@markup.list.unchecked", { fg = colors.fg_subtle })
hi("@markup.raw",            { fg = colors.constant, bg = colors.bg_dark })
hi("@markup.quote",          { fg = colors.fg_subtle, italic = true })

hi("@markup.math",              { fg = colors.special })
hi("@markup.environment",       { fg = colors.special })
hi("@markup.environment.name",  { fg = colors.keyword })

-- ── blink.cmp ──────────────────────────────────────────────
hi("BlinkCmpMenu",            { fg = colors.fg, bg = style == "dark" and "#3e3e42" or "#c5c0b8" })
hi("BlinkCmpMenuBorder",      { fg = colors.border })
hi("BlinkCmpMenuSelection",   { fg = colors.fg, bg = style == "dark" and "#4c4c52" or "#b5b0a8", bold = true })
hi("BlinkCmpLabel",           { fg = colors.fg })
hi("BlinkCmpLabelMatch",      { fg = colors.keyword, bold = true })
hi("BlinkCmpLabelDescription",{ fg = colors.fg_dim })
hi("BlinkCmpLabelDetail",     { fg = colors.fg_dim })
hi("BlinkCmpKind",            { fg = colors.fg_dim })
hi("BlinkCmpDoc",             { fg = colors.fg, bg = colors.bg_float })
hi("BlinkCmpDocBorder",       { fg = colors.border })
hi("BlinkCmpSignatureHelp",   { fg = colors.fg, bg = colors.bg_float })
hi("BlinkCmpGhostText",       { fg = colors.fg_subtle })
hi("BlinkCmpKindDefault",     { fg = colors.fg_dim })
hi("BlinkCmpKindKeyword",     { fg = colors.keyword })
hi("BlinkCmpKindFunction",    { fg = colors.func })
hi("BlinkCmpKindMethod",      { fg = colors.func })
hi("BlinkCmpKindClass",       { fg = colors.type })
hi("BlinkCmpKindInterface",   { fg = colors.type })
hi("BlinkCmpKindStruct",      { fg = colors.type })
hi("BlinkCmpKindModule",      { fg = colors.keyword })
hi("BlinkCmpKindVariable",    { fg = colors.fg })
hi("BlinkCmpKindField",       { fg = colors.fg })
hi("BlinkCmpKindProperty",    { fg = colors.fg })
hi("BlinkCmpKindConstant",    { fg = colors.constant })
hi("BlinkCmpKindEnum",        { fg = colors.type })
hi("BlinkCmpKindUnit",        { fg = colors.type })
hi("BlinkCmpKindValue",       { fg = colors.constant })
hi("BlinkCmpKindText",        { fg = colors.string })
hi("BlinkCmpKindSnippet",     { fg = colors.special })
hi("BlinkCmpKindColor",       { fg = colors.special })
hi("BlinkCmpKindFile",        { fg = colors.info })
hi("BlinkCmpKindFolder",      { fg = colors.type })
hi("BlinkCmpKindReference",   { fg = colors.keyword })
hi("BlinkCmpKindOperator",    { fg = colors.operator })
hi("BlinkCmpKindTypeParameter",{ fg = colors.special })

-- ── gitsigns ───────────────────────────────────────────────
hi("GitSignsAdd",          { fg = colors.ok })
hi("GitSignsChange",       { fg = colors.warn })
hi("GitSignsDelete",       { fg = colors.error })
hi("GitSignsAddInline",    { bg = colors.add })
hi("GitSignsChangeInline", { bg = colors.change })
hi("GitSignsDeleteInline", { bg = colors.delete })

-- ── which-key ──────────────────────────────────────────────
hi("WhichKey",          { fg = colors.keyword })
hi("WhichKeyDesc",      { fg = colors.fg })
hi("WhichKeySeparator", { fg = colors.fg_faint })
hi("WhichKeyGroup",     { fg = colors.type })
hi("WhichKeyFloat",     { fg = colors.fg, bg = style == "dark" and "#303035" or "#e8e5e0" })
hi("WhichKeyBorder",    { fg = colors.border })

-- ── lualine ────────────────────────────────────────────────
if style == "dark" then
  -- dark: onedark/nord-inspired blues and greens
  hi("lualine_a_normal",      { fg = colors.bg, bg = "#61afef" })
  hi("lualine_b_normal",      { fg = colors.fg, bg = "#444447" })
  hi("lualine_c_normal",      { fg = colors.fg, bg = "#3d3d40" })

  hi("lualine_a_insert",      { fg = colors.bg, bg = "#98c379" })
  hi("lualine_b_insert",      { fg = colors.fg, bg = "#444447" })
  hi("lualine_c_insert",      { fg = colors.fg, bg = "#3d3d40" })

  hi("lualine_a_visual",      { fg = colors.bg, bg = "#61afef" })
  hi("lualine_b_visual",      { fg = colors.fg, bg = "#444447" })
  hi("lualine_c_visual",      { fg = colors.fg, bg = "#3d3d40" })

  hi("lualine_a_replace",     { fg = colors.bg, bg = "#e06c75" })
  hi("lualine_b_replace",     { fg = colors.fg, bg = "#444447" })
  hi("lualine_c_replace",     { fg = colors.fg, bg = "#3d3d40" })

  hi("lualine_a_command",     { fg = colors.bg, bg = "#56b6c2" })
  hi("lualine_b_command",     { fg = colors.fg, bg = "#444447" })
  hi("lualine_c_command",     { fg = colors.fg, bg = "#3d3d40" })

  hi("lualine_a_terminal",    { fg = colors.bg, bg = "#8fbcbb" })
  hi("lualine_b_terminal",    { fg = colors.fg, bg = "#444447" })
  hi("lualine_c_terminal",    { fg = colors.fg, bg = "#3d3d40" })

  hi("lualine_a_inactive",    { fg = colors.fg_subtle, bg = colors.bg_darker })
  hi("lualine_b_inactive",    { fg = colors.fg_subtle, bg = colors.bg_darker })
  hi("lualine_c_inactive",    { fg = colors.fg_subtle, bg = colors.bg_darker })

  hi("lualine_transitional_a_normal", { fg = "#61afef", bg = "#444447" })
  hi("lualine_transitional_b_normal", { fg = colors.fg, bg = "#3d3d40" })
else
  -- light: brighter paper tones
  hi("lualine_a_normal",      { fg = colors.bg, bg = colors.fg_dim })
  hi("lualine_b_normal",      { fg = colors.fg, bg = "#d8d6d0" })
  hi("lualine_c_normal",      { fg = colors.fg, bg = "#e0ded8" })

  hi("lualine_a_insert",      { fg = colors.bg, bg = "#4a7a52" })
  hi("lualine_b_insert",      { fg = colors.fg, bg = "#d8d6d0" })
  hi("lualine_c_insert",      { fg = colors.fg, bg = "#e0ded8" })

  hi("lualine_a_visual",      { fg = colors.bg, bg = "#526088" })
  hi("lualine_b_visual",      { fg = colors.fg, bg = "#d8d6d0" })
  hi("lualine_c_visual",      { fg = colors.fg, bg = "#e0ded8" })

  hi("lualine_a_replace",     { fg = colors.bg, bg = "#884a4a" })
  hi("lualine_b_replace",     { fg = colors.fg, bg = "#d8d6d0" })
  hi("lualine_c_replace",     { fg = colors.fg, bg = "#e0ded8" })

  hi("lualine_a_command",     { fg = colors.bg, bg = "#4a5a88" })
  hi("lualine_b_command",     { fg = colors.fg, bg = "#d8d6d0" })
  hi("lualine_c_command",     { fg = colors.fg, bg = "#e0ded8" })

  hi("lualine_a_terminal",    { fg = colors.bg, bg = "#4a6a6a" })
  hi("lualine_b_terminal",    { fg = colors.fg, bg = "#d8d6d0" })
  hi("lualine_c_terminal",    { fg = colors.fg, bg = "#e0ded8" })

  hi("lualine_a_inactive",    { fg = colors.fg_subtle, bg = colors.bg_darker })
  hi("lualine_b_inactive",    { fg = colors.fg_subtle, bg = colors.bg_darker })
  hi("lualine_c_inactive",    { fg = colors.fg_subtle, bg = colors.bg_darker })

  hi("lualine_transitional_a_normal", { fg = colors.fg_dim, bg = "#d8d6d0" })
  hi("lualine_transitional_b_normal", { fg = colors.fg, bg = "#e0ded8" })
end

-- ── mini.starter ───────────────────────────────────────────
hi("MiniStarterHeader",   { fg = colors.keyword, bold = true })
hi("MiniStarterItem",     { fg = colors.fg })
hi("MiniStarterItemPrefix",{ fg = colors.warn })
hi("MiniStarterQuery",    { fg = colors.info })
hi("MiniStarterFooter",   { fg = colors.fg_subtle })

-- ── snacks picker ──────────────────────────────────────────
hi("SnacksPicker",        { link = "NormalFloat" })
hi("SnacksPickerBorder",  { link = "FloatBorder" })
hi("SnacksPickerTitle",   { link = "FloatTitle" })
hi("SnacksPickerDir",     { fg = colors.fg_subtle })
hi("SnacksPickerMatch",   { bold = true })

-- ── snacks explorer ────────────────────────────────────────
hi("SnacksExplorerNormal", { link = "NormalFloat" })
hi("SnacksExplorerBorder", { link = "FloatBorder" })
hi("SnacksExplorerTitle",  { link = "FloatTitle" })
hi("SnacksExplorerIndent", { fg = colors.fg_faint })
hi("SnacksExplorerGitAdded",    { fg = colors.ok })
hi("SnacksExplorerGitModified", { fg = colors.warn })
hi("SnacksExplorerGitDeleted",  { fg = colors.error })
hi("SnacksExplorerGitRenamed",  { fg = colors.info })

-- ── yazi ───────────────────────────────────────────────────
if style == "dark" then
  hi("YaziNormal",  { link = "NormalFloat" })
  hi("YaziBorder",  { link = "FloatBorder" })
  hi("YaziTitle",   { link = "FloatTitle" })
else
  hi("YaziNormal",  { fg = colors.fg, bg = colors.bg_darker })
  hi("YaziBorder",  { fg = colors.border })
  hi("YaziTitle",   { fg = colors.keyword, bold = true })
end

-- ── custom highlights from plugin/highlight.lua ────────────
hi("RainbowRed",    { fg = "#E06C75" })
hi("RainbowYellow", { fg = "#E5C07B" })
hi("RainbowBlue",   { fg = "#61AFEF" })
hi("RainbowOrange", { fg = "#D19A66" })
hi("RainbowGreen",  { fg = "#98C379" })
hi("RainbowViolet", { fg = "#C678DD" })
hi("RainbowCyan",   { fg = "#56B6C2" })
hi("SearchCountVirtualText", { fg = "#688af4", bold = true })
