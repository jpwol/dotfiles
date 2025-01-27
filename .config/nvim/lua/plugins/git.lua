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
			vim.keymap.set("n", "<leader>gg", "<cmd>Gitsigns<CR>", { desc = "Open Git menu" })
			vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Open the preview menu" })
			vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<CR>", { desc = "View next git hunk" })
			vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", { desc = "View previous git hunk" })
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
}
