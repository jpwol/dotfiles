return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				background = "hard",
				italics = true,
				sign_column_background = "none",
				ui_contrast = "low",
				dim_inactive_windows = false,
				diagnostic_text_highlight = true,
				spell_foreground = false,
			})
			vim.cmd([[colorscheme everforest]])
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
		opts = {
			style = "night",
		},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			variant = "main",
		},
	},
}
