return {
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
		end,
	},
	{
		dir = vim.fn.stdpath("config") .. "/thorn",
		name = "thorn",
		lazy = false,
		priority = 1000,
	},
}
