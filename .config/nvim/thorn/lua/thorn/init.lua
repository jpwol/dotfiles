local M = {}

if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

local colors = require("thorn.colors.thorn-dark")

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
	hi("Normal", { fg = colors.fg, bg = colors.bg })
	hi("EndOfBuffer", { fg = colors.bg })
	hi("Comment", { fg = colors.comment, italic = true })

	hi("Constant", { fg = colors.constant })
	hi("Function", { fg = colors.func })
	hi("@lsp.typemod.function.defaultLibrary", { fg = colors.func, italic = true })

	hi("Identifier", { fg = colors.identifier, italic = true })
	hi("Statement", { fg = colors.statement })
	hi("Keyword", { fg = colors.statement, italic = true })
	hi("Type", { fg = colors.types })

	hi("String", { fg = colors.str, italic = true })

	hi("@lsp.type.variable", {})

	hi("@type.builtin", { fg = colors.types })
	hi("@variable", { fg = colors.var })
	hi("@variable.member", { fg = colors.identifier })
	hi("@variable.parameter", { fg = colors.param })

	hi("Operator", { fg = colors.operator })

	hi("Delimiter", { fg = colors.delimiter })
	hi("@punctuation.delimiter", { fg = colors.special })
	hi("@string.escape", { fg = colors.delimiter })
	hi("@constructor", { fg = colors.special })
	hi("Special", { fg = colors.special })

	hi("MatchParen", { fg = colors.operator, bold = true })

	hi("PreProc", { fg = colors.special })
	hi("@annotation", { fg = colors.special })
	hi("CursorLine", { bg = colors.cursorline })
	hi("LineNr", { fg = "#444444", bg = colors.bg })
	hi("CursorLineNr", { fg = colors.constant, bg = colors.bg })

	hi("WinSeparator", { fg = colors.separator })

	--- NvimTree settings
	hi("NvimTreeNormal", { fg = colors.delimiter })
	hi("NvimTreeRootFolder", { fg = colors.str, bold = true })
	hi("NvimTreeFolderName", { fg = colors.str })
	hi("NvimTreeEmptyFolderName", { fg = colors.str })
	hi("NvimTreeOpenedFolderName", { fg = colors.str })
	hi("NvimTreeSymlinkFolderName", { fg = colors.str })

	hi("NvimTreeFolderIcon", { fg = colors.icon })

	hi("NvimTreeExecFile", { fg = colors.str })
	hi("NvimTreeImageFile", { fg = colors.delimiter })
	hi("NvimTreeSpecialFile", { fg = colors.delimiter })
	hi("NvimTreeSymFile", { fg = colors.delimiter })

	hi("NvimTreeEndOfBuffer", { fg = colors.bg })
end

return M
