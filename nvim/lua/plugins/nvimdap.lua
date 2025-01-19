return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			dap.configurations.java = {
				{
					type = "java-debug-adapter",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					javaPath = function()
						return "/usr/bin/java"
					end,
				},
			}
			vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>")
			vim.keymap.set("n", "<leader>dr", "<cmd>DapContinue<CR>", { desc = "Start or continue the debugger" })
			vim.keymap.set("n", "<leader>dpr", function()
				require("dap-python").test_method()
			end)
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
	},
}
