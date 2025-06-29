return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true },

			ensure_installed = {
				"lua",
				"vim",
				"c",
				"cpp",
				"json",
				"jsonc",
				"javascript",
				"typescript",
				"css",
				"html",
				"vimdoc",
				"python",
				"bash",
				"cmake",
				"comment",
				"make",
				"dockerfile",
				"gitignore",
				"query",
				"markdown",
				"markdown_inline",
				"tmux",
				"zig",
				"go",
				"sql",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			vim.filetype.add({
				pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
			}),
		})
	end,
}
