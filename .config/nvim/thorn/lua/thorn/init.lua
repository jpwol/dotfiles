-- ~/.config/nvim/colors/thorn.lua

local M = {}

-- Clear existing highlights
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

-- Set colorscheme name and background
vim.o.background = "dark"
vim.g.colors_name = "thorn"

-- Define your palette
local colors = {
	bg = "#152326",
	fg = "#ffffff",

	white = "#D9D3CE",
	gray = "#91A4AD",
	green = "#568270",
	yellow = "#FFCF99",
	orange = "#F9ADA0",
	lightblue = "#BBDBD1",
	lightgreen = "#95C2A1",
	pink = "#D9ADD4",
	cyan = "#79C2B6",
	red = "#D2696C",

	comment = "#568270",
	statement = "#F9ADA0",
	identifier = "#BBDBD1",
	special = "#BBDBD1",
	delimiter = "#91A4AD",
	constant = "#FFCF99",
	str = "#95C2A1",
	func = "#D9ADD4",
	types = "#79C2B6",
	operator = "#D2696C",
	var = "#D9D3CE",
	param = "#FFCF99",

	cursorline = "#263338",
	separator = "#0B1213",
}

-- Helper function to set highlights
local function hi(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

-- Set basic highlight groups
function M.load()
	hi("Normal", { fg = colors.fg, bg = colors.bg })
	hi("Comment", { fg = colors.comment, italic = true })
	hi("Constant", { fg = colors.constant })

	hi("Function", { fg = colors.func })
	hi("@lsp.typemod.function.defaultLibrary", { fg = colors.func, italic = true })

	hi("Identifier", { fg = colors.identifier, italic = true })
	hi("Statement", { fg = colors.statement })
	hi("Keyword", { fg = colors.statement, italic = true })
	hi("Type", { fg = colors.types })

	hi("String", { fg = colors.str, italic = true })

	hi("@type.builtin", { fg = colors.types })
	hi("@variable", { fg = colors.var })
	hi("@variable.parameter", { fg = colors.param })

	hi("Operator", { fg = colors.operator })

	hi("Delimiter", { fg = colors.delimiter })
	hi("Special", { fg = colors.special })

	hi("PreProc", { fg = colors.special })
	hi("CursorLine", { bg = colors.cursorline })
	hi("LineNr", { fg = "#444444", bg = colors.bg })
	hi("CursorLineNr", { fg = colors.constant, bg = colors.bg })

	hi("WinSeparator", { fg = colors.separator })

	--- NvimTree settings
	hi("NvimTreeRootFolder", { fg = colors.str, bold = true })
	hi("NvimTreeFolderName", { fg = colors.str })
	hi("NvimTreeEmptyFolderName", { fg = colors.str })
	hi("NvimTreeOpenedFolderName", { fg = colors.str })
	hi("NvimTreeSymlinkFolderName", { fg = colors.str })

	hi("NvimTreeEndOfBuffer", { fg = colors.bg })

	hi("NvimTreeFolderIcon", { fg = colors.lightblue })
end

return M
