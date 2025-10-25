return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = true },
		indent = {
			enabled = true,
			animate = { enabled = false },
		},
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		-- scroll = { enabled = true },
		statuscolumn = { enabled = true },
		-- words = { enabled = true },
	},
  -- stylua: ignore
	keys = {
    -- Picker and Explorer
		{ "<leader>,", function() Snacks.picker() end, desc = "open picker", },
		{ "<leader>ee", function() Snacks.picker.explorer() end, desc = "Toggle Explorer", },

    -- Files and Buffers
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "open picker", },
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File", },
		{ "<leader>fs", function() Snacks.picker.grep() end, desc = "Grep string", },
		{ "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep word", },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Files", },

    -- Lsp
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
    { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

    -- git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },

    -- Diagnostics
    { "<leader>xw", function() Snacks.picker.diagnostics() end, desc = "Diagnostics", },
    { "<leader>xb", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics", },

    -- Other
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

		{ "<leader>fi", function() Snacks.picker.icons() end, desc = "Icons", },

		{ "<leader>f<leader>", function() Snacks.picker.colorschemes() end, desc = "Colorschemes", },
	},
}
