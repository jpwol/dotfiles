local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.cursorline = true

opt.wrap = true

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard = "unnamedplus"

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

vim.filetype.add({
	extension = {
		vs = "glsl",
		fs = "glsl",
		frag = "glsl",
		vert = "glsl",
	},
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("term-open", { clear = true }),
	callback = function()
		opt.number = false
		opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "",
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	end,
})
