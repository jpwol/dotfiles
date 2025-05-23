local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "h", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
end

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings per nvim-tree docs
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- change color of arrows in tree
		vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

		--configure nvim-tree
		nvimtree.setup({
			on_attach = my_on_attach,
			view = {
				width = 30,
				side = "left",
			},
			-- change folder arrow icons
			renderer = {
				icons = {
					glyphs = {
						folder = {
							-- arrow_closed = "",
							-- arrow_open - "",
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		)
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
		keymap.set(
			"n",
			"<leader>ea",
			"<C-w>t",
			{ desc = "Move to file explorer if it is open, otherwise move to leftmost window" }
		)
	end,
}
