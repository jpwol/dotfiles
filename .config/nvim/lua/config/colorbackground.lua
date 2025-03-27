local is_transparent = true
local bg_color = "#222435"

local function color_background()
	if is_transparent then
		vim.api.nvim_set_hl(0, "Normal", { bg = bg_color })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = bg_color })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg_color })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		is_transparent = false
	else
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		is_transparent = true
	end
end

vim.api.nvim_create_user_command("ColorBackground", color_background, {})

vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "",
	callback = color_background,
})

vim.keymap.set("n", "<leader>bb", "<cmd>ColorBackground<CR>")
