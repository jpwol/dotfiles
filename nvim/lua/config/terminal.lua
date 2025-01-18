local terminal_buf = nil

function setTerm()
	local os_name = vim.loop.os_uname().sysname
	if os_name == "Windows_NT" then
		vim.opt.shell = "pwsh"
	elseif os_name == "Linux" then
		vim.opt.shell = "/bin/fish"
	end
end

setTerm()

vim.api.nvim_create_user_command("ToggleTerminal", function()
	if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
		local win_ids = vim.fn.win_findbuf(terminal_buf)
		if #win_ids > 0 then
			vim.api.nvim_win_close(win_ids[1], true)
		else
			vim.api.nvim_command("botright split")
			vim.api.nvim_win_set_buf(0, terminal_buf)
			vim.api.nvim_win_set_height(0, 10)
		end
	else
		vim.api.nvim_command("botright split")
		terminal_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_win_set_buf(0, terminal_buf)
		vim.fn.termopen(vim.o.shell)
		vim.api.nvim_win_set_height(0, 10)
	end
end, {})

vim.keymap.set("n", "<leader>st", "<cmd>ToggleTerminal<CR>")
