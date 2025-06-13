return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				background = "soft",
				italics = true,
				sign_column_background = "none",
				ui_contrast = "low",
				dim_inactive_windows = false,
				diagnostic_text_highlight = false,
				diagnostic_line_highlight = false,
				spell_foreground = false,
				-- transparent_background_level = 2,
				on_highlights = function(hl, palette)
					hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.none }
					hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.none }
					hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.none }
					hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.none }
					hl.DiagnosticUnderlineWarn.undercurl = false
					hl.DiagnosticUnderlineWarn.underline = true
					hl.DiagnosticUnderlineError.undercurl = false
					hl.DiagnosticUnderlineError.underline = true
					hl.DiagnosticUnderlineHint.undercurl = false
					hl.DiagnosticUnderlineHint.underline = true
					hl.DiagnosticUnderlineInfo.undercurl = false
					hl.DiagnosticUnderlineInfo.underline = true
				end,
			})
			-- vim.cmd([[colorscheme everforest]])
		end,
	},
	{
		"shaunsingh/nord.nvim",
		lazy = false,
	},
	{
		"navarasu/onedark.nvim",
		lazy = false,
		opts = {
			style = "darker",
			ending_tildes = false,

			code_style = {
				comments = "italic,bold",
				keywords = "none",
				functions = "bold",
				strings = "italic",
				variables = "none",
				types = "italic",
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		config = function()
			require("tokyonight").setup({
				style = "moon",
				styles = {
					keywords = { italic = true },
					sidebars = "transparent",
					-- floats = "transparent",
				},
				on_highlights = function(hl, c)
					-- hl.DiagnosticUnderlineWarn.undercurl = false
					-- hl.DiagnosticUnderlineWarn.underline = true
					-- hl.DiagnosticUnderlineError.undercurl = false
					-- hl.DiagnosticUnderlineError.underline = true
					-- hl.DiagnosticUnderlineHint.undercurl = false
					-- hl.DiagnosticUnderlineHint.underline = true
					-- hl.DiagnosticUnderlineInfo.undercurl = false
					-- hl.DiagnosticUnderlineInfo.underline = true
				end,
			})
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			variant = "main",
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
	},
	{
		"rmehri01/onenord.nvim",
	},
}
