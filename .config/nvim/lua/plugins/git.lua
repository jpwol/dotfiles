return {
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = false,
		priority = 1000,
		config = function()
			require("gitsigns").setup()
			vim.keymap.set("n", "<leader>gs", "<cmd>Gitsigns<CR>", { desc = "Open Git menu" })
			vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Open the preview menu" })
			vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<CR>", { desc = "View next git hunk" })
			vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", { desc = "View previous git hunk" })
		end,
	},
}
