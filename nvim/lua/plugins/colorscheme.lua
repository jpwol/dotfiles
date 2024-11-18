return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				background = "medium",
				italics = true,
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
