local M = {}

if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

local c = require("thorn.colors.dark")

-- Helper function to set highlights
local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- clear highlights on theme application
function M.load(opts)
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.background = "dark"
  vim.g.colors_name = "thorn"

  -- Set basic highlight groups
  hi("Normal", { fg = c.fg, bg = c.bg })
  hi("EndOfBuffer", { fg = c.bg })
  hi("Comment", { fg = c.green, italic = true })

  hi("Constant", { fg = c.yellow })
  hi("Function", { fg = c.pink })
  hi("@lsp.typemod.function.defaultLibrary", { fg = c.pink, italic = true })

  hi("Identifier", { fg = c.lightblue, italic = true })
  hi("Statement", { fg = c.orange })
  hi("Keyword", { fg = c.orange, italic = true })
  hi("Type", { fg = c.cyan })

  hi("String", { fg = c.lightgreen, italic = true })

  hi("@lsp.type.variable", {})

  hi("@type.builtin", { fg = c.cyan })
  hi("@variable", { fg = c.white })
  hi("@variable.member", { fg = c.lightblue })
  hi("@variable.parameter", { fg = c.yellow })

  hi("Operator", { fg = c.red })

  hi("Delimiter", { fg = c.gray })
  hi("@punctuation.delimiter", { fg = c.lightblue })
  hi("@string.escape", { fg = c.gray })
  hi("@constructor", { fg = c.lightblue })
  hi("Special", { fg = c.lightblue })

  hi("MatchParen", { fg = c.red, bold = true })

  hi("PreProc", { fg = c.lightblue })
  hi("@annotation", { fg = c.lightblue })
  hi("CursorLine", { bg = c.cursorline })
  hi("LineNr", { fg = "#444444", bg = c.bg })
  hi("CursorLineNr", { fg = c.yellow, bg = c.bg })

  hi("WinSeparator", { fg = c.separator })

  --- NvimTree settings
  hi("NvimTreeNormal", { fg = c.gray })
  hi("NvimTreeRootFolder", { fg = c.lightgreen, bold = true })
  hi("NvimTreeFolderName", { fg = c.lightgreen })
  hi("NvimTreeEmptyFolderName", { fg = c.lightgreen })
  hi("NvimTreeOpenedFolderName", { fg = c.lightgreen })
  hi("NvimTreeSymlinkFolderName", { fg = c.lightgreen })

  hi("NvimTreeFolderIcon", { fg = c.lightblue })

  hi("NvimTreeExecFile", { fg = c.lightgreen })
  hi("NvimTreeImageFile", { fg = c.gray })
  hi("NvimTreeSpecialFile", { fg = c.gray })
  hi("NvimTreeSymFile", { fg = c.gray })

  hi("NvimTreeEndOfBuffer", { fg = c.bg })
end

return M
