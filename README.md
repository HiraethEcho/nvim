# NVIM
Hello, world!

> [tips] 

what a hell
## Usage

I'm using nvim as a code editor, mainly for latex and markdown.

### general

### latex

using `vimtex` and `texlab`

### markdown

### lsp

## Detail Configure

### options

### plugins

I am using lazy.nvim as my plugins manager. Plugins are divided in serval classes, and following are some of mostly used plugins:

- edit: enhance for editing
  - [mini.surround](https://github.com/echasnovski/mini.surround),
  - [mini.align](https://github.com/echasnovski/mini.align),
  - [mini.splitjoin](https://github.com/echasnovski/mini.splitjoin),
  - [fcitx.nvim](https://github.com/smartding/fcitx.nvim), 中文输入自动切换
  - [nvim-autopairs](https://github.com/windwp/nvim-autopairs),
  - [zen-mode.nvim](https://github.com/folke/zen-mode.nvim), zen mode, focus on editing
  - [undotree](https://github.com/mbbill/undotree), like a temporary git
  - [vim-translator](https://github.com/voldikss/vim-translator), translate words
  - [hop.nvim](https://github.com/phaazon/hop.nvim), jump anywhere
- cmp: my completion
  - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp),
  - [ultisnips](https://github.com/SirVer/ultisnips), snippets
  - [cmp-nvim-ultisnips](https://github.com/quangnguyen30192/cmp-nvim-ultisnips), commute ultisnips with cmp
  - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp), lsp source
  - [cmp-buffer](https://github.com/hrsh7th/cmp-buffer), source from other buffers
  - [copilot.lua](https://github.com/zbirenbaum/copilot.lua), copilot source
  - [cmp-path](https://github.com/hrsh7th/cmp-path), path source
- editor: enhance for latex and markdown
  - [vimtex](https://github.com/lervag/vimtex), for latex
  - ~~[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim), preview md in browser~~
  - ~~[markview.nvim](https://github.com/OXY2DEV/markview.nvim)~~ [render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim), view md in nvim
  - [mkdnflow.nvim](https://github.com/jakewvincent/mkdnflow.nvim), help edit list, table etc in nvim
- git: using git in nvim
  - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), show git status at left, jump by hunks
  - [diffview.nvim](https://github.com/sindrets/diffview.nvim), show diff with history files
- lsp:
  - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), Configure lsp
  - [mason.nvim](https://github.com/williamboman/mason.nvim), install lsp
  - [glance.nvim](https://github.com/dnlhc/glance.nvim), jump by definitions, references etc
  - [outline.nvim](https://github.com/hedyhli/outline.nvim) and [navbuddy](https://github.com/SmiteshP/nvim-navbuddy), jump by symbols etc
- file explorer:
  - [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim), file tree
  - [yazi.nvim](https://github.com/mikavilpas/yazi.nvim), yazi (tui file manager) in float terminal
- telescope: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim), fozzy finder
- ui:
  - [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim), my theme
  - [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua), show color like `#123dfe`
  - [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim), modeline, bufferline etc
  - [hlchunk.nvim](https://github.com/shellRaining/hlchunk.nvim), show indent line etc
- enhance native functions:
  - [lazy.nvim](https://github.com/folke/lazy.nvim), plugin manager
  - [wilder.nvim](https://github.com/gelguy/wilder.nvim), `:` cmd and `/` search
  - [which-key.nvim](https://github.com/folke/which-key.nvim), show leader key sequence
  - [nvim-spectre](https://github.com/nvim-pack/nvim-spectre), search and replace
  - [vim-startuptime](https://github.com/dstein64/vim-startuptime), show start up time
  - [suda.vim](https://github.com/lambdalisue/suda.vim), sudo write files

## miscellanea

### windows and linux

### callouts

> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.

### some icons

```lua
{
ActiveLSP = "",
ActiveTS = "",
ArrowLeft = "",
ArrowRight = "",
Bookmarks = "",
BufferClose = "󰅖",
DapBreakpoint = "",
DapBreakpointCondition = "",
DapBreakpointRejected = "",
DapLogPoint = ".>",
DapStopped = "󰁕",
Debugger = "",
DefaultFile = "󰈙",
Diagnostic = "󰒡",
DiagnosticError = "",
DiagnosticHint = "󰌵",
DiagnosticInfo = "󰋼",
DiagnosticWarn = "",
Ellipsis = "…",
FileNew = "",
FileModified = "",
FileReadOnly = "",
FoldClosed = "",
FoldOpened = "",
FoldSeparator = " ",
FolderClosed = "",
FolderEmpty = "",
FolderOpen = "",
Git = "󰊢",
GitAdd = "",
GitBranch = "",
GitChange = "",
GitConflict = "",
GitDelete = "",
GitIgnored = "◌",
GitRenamed = "➜",
GitSign = "▎",
GitStaged = "✓",
GitUnstaged = "✗",
GitUntracked = "★",
LSPLoaded = "",
LSPLoading1 = "",
LSPLoading2 = "󰀚",
LSPLoading3 = "",
MacroRecording = "",
Package = "󰏖",
Paste = "󰅌",
Refresh = "",
Search = "",
Selected = "❯",
Session = "󱂬",
Sort = "󰒺",
Spellcheck = "󰓆",
Tab = "󰓩",
TabClose = "󰅙",
Terminal = "",
Window = "",
WordFile = "󰈭",
Array = " ",
Boolean = " ",
Class = " ",
Color = " ",
Constant = " ",
Constructor = " ",
Copilot = " ",
Enum = " ",
EnumMember = " ",
Event = " ",
Field = " ",
File = " ",
Folder = " ",
Function = " ",
Interface = " ",
Key = " ",
Keyword = " ",
Method = " ",
Module = " ",
Namespace = " ",
Null = " ",
Number = " ",
Object = " ",
Operator = " ",
Package = " ",
Property = " ",
Reference = " ",
Snippet = " ",
String = " ",
Struct = " ",
Text = " ",
TypeParameter = " ",
Unit = " ",
Value = " ",
Variable = " ",
}
```
