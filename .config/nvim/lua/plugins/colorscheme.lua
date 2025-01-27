return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		-- config = function()
		-- 	require("everforest").setup({
		-- 		background = "hard",
		-- 		italics = true,
		-- 		sign_column_background = "none",
		-- 		ui_contrast = "low",
		-- 		dim_inactive_windows = false,
		-- 		diagnostic_text_highlight = true,
		-- 		spell_foreground = false,
		-- 	})
		-- end,
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
		opts = function()
			require("tokyonight").setup({
				style = "night",
				styles = {
					keywords = { italic = true },
				},
				on_highlights = function(hl, c)
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
}
