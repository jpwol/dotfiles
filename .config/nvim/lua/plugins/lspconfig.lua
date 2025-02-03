return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function() -- import mason
			local mason = require("mason")

			-- import mason-lspconfig
			local mason_lspconfig = require("mason-lspconfig")

			local mason_tool_installer = require("mason-tool-installer")

			-- enable mason and configure icons
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_lspconfig.setup({
				-- list of servers for mason to install
				automatic_installation = true,
				ensure_installed = {
					"html",
					"cssls",
					"jsonls",
					"lua_ls",
					"basedpyright",
					"clangd",
					"zls",
					"bashls",
					"cmake",
					"texlab",
					"gopls",
					"jdtls",
					"marksman",
					"taplo",
					"vala_ls",
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier", -- prettier formatter
					"jsonlint",
					"stylua", -- lua formatter
					"black", -- python formatter
					"pylint", -- python linter
					"debugpy", -- python debugger
					"eslint_d", -- javascript linter (HATE)
					"luacheck", -- lua linter
					"cpplint", -- c, c++ linter
					"codelldb", -- c, c++, rust, zig debugger
					"cmakelang",
					"cmakelint",
					"trivy",
					"shellcheck",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/lazydev.nvim", opts = {} },
		},
		config = function()
			-- import lspconfig plugin
			local lspconfig = require("lspconfig")

			-- import mason_lspconfig plugin
			local mason_lspconfig = require("mason-lspconfig")

			-- import cmp-nvim-lsp plugin
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local keymap = vim.keymap -- for conciseness

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf, silent = true }

					-- set keybinds
					opts.desc = "Show LSP references"
					keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

					opts.desc = "Go to declaration"
					keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

					opts.desc = "Show LSP definitions"
					keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

					opts.desc = "Show LSP implementations"
					keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations opts.desc = "Show LSP type definitions" keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

					opts.desc = "See available code actions"
					keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

					opts.desc = "Smart rename"
					keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

					opts.desc = "Show buffer diagnostics"
					keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

					opts.desc = "Show line diagnostics"
					keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

					opts.desc = "Go to previous diagnostic"
					keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

					opts.desc = "Go to next diagnostic"
					keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

					opts.desc = "Show documentation for what is under cursor"
					keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

					opts.desc = "Restart LSP"
					keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
				end,
			})

			-- used to enable autocompletion (assign to every lsp server config)
			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Change the Diagnostic symbols in the sign column (gutter)
			-- (not in youtube nvim video)
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			local handlers = {
				function(server_name)
					lspconfig[server_name].setup({})
				end,

				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								runtime = {
									version = "Lua 5.4",
									path = {
										"?.lua",
										"?/init.lua",
										"?/?.lua",
										"/usr/share/lua/5.4/?.lua",
										"/usr/share/lua/5.4/?/init.lua",
										vim.fn.expand("~/.luarocks/lib/lua/5.4/"),
									},
								},
								workspace = {
									library = {
										"?.lua",
										"/home/josh/.luarocks/share/lua/5.4",
										"/home/josh/.luarocks/lib/lua/5.4",
										vim.fn.expand("$VIMRUNTIME/lua"),
										vim.api.nvim_get_runtime_file("", true),
									},
									checkThirdParty = false,
								},
								diagnostics = {
									globals = { "vim" },
								},
							},
						},
					})
				end,
				["clangd"] = function()
					lspconfig.clangd.setup({
						cmd = { "clangd", "--fallback-style=Google" },
						capabilities = capabilities,
						filetypes = { "c", "cpp" },
						settings = {
							clangd = {
								fallbackFlags = {},
							},
						},
					})
				end,
				["basedpyright"] = function()
					lspconfig.basedpyright.setup({
						capabilities = capabilities,
						filetypes = { "python" },
						settings = {
							basedpyright = {
								analysis = {
									diagnosticMode = "openFilesOnly",
									diagnosticSeverityOverrides = {
										reportUnusedImport = false,
										reportMissingTypeStubs = false,
										reportUnknownArgumentType = false,
										reportUnknownMemberType = false,
										reportUnknownVariableType = false,
										reportUnusedCallResult = false,
									},
									inlayHints = {
										callArgumentNames = true,
									},
								},
							},
						},
					})
				end,
				["zls"] = function()
					lspconfig.zls.setup({
						capabilities = capabilities,
						cmd = { "zls" },
						filetypes = { "zig", "zir" },
						root_dir = lspconfig.util.root_pattern("zls.json", "build.zig", ".git"),
						settings = {
							zls = {
								Zls = {
									enableAutofix = true,
									enable_snippets = true,
									enable_ast_check_diagnostics = true,
									enable_autofix = true,
									enable_import_embedfile_argument_completions = true,
									warn_style = true,
									enable_semantic_tokens = true,
									enable_inlay_hints = true,
									inlay_hints_hide_redundant_param_names = true,
									inlay_hints_hide_redundant_param_names_last_token = true,
									operator_completions = true,
									include_at_in_builtins = true,
									max_detail_length = 1048576,
								},
							},
						},
					})
				end,
				["gopls"] = function()
					lspconfig.gopls.setup({
						capabilities = capabilities,
						cmd = { "gopls" },
						filetypes = { "go" },
					})
				end,
				["jsonls"] = function()
					lspconfig.jsonls.setup({
						capabilities = capabilities,
						filetypes = { "json", "jsonc" },
						settings = {
							json = {
								validate = { enable = true },
								format = { enable = true },
								schemas = {},
								allowComments = true,
								trailingCommas = "ignore",
							},
						},
					})
				end,
				["jdtls"] = function()
					lspconfig.jdtls.setup({
						capabilities = capabilities,
						filetypes = { "java" },
						cmd = { "jdtls" },
					})
				end,
				["marksman"] = function()
					lspconfig.marksman.setup({
						capabilities = capabilities,
						filetypes = { "markdown" },
						cmd = { "marksman" },
					})
				end,
				["taplo"] = function()
					lspconfig.taplo.setup({
						capabilities = capabilities,
						filetypes = { "toml" },
					})
				end,
				["bashls"] = function()
					lspconfig.bashls.setup({
						capabilities = capabilities,
						filetypes = { "bash", "zsh", "sh" },
						cmd = { "bash-language-server", "start" },
						settings = {
							bashIde = {
								logLevel = "error",
								enableSourceErrorDiagnostics = false,
							},
						},
					})
				end,
			}
			mason_lspconfig.setup_handlers(handlers)

			require("lazydev").setup()
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				json = { "jsonlint" },
				jsonc = { "jsonlint" },
				python = { "pylint" },
				c = { "cpplint" },
				cpp = { "cpplint" },
				cs = { "trivy" },
				lua = { "luacheck" },
				cmake = { "cmakelint" },
				bash = { "shellcheck" },
			}

			local eslint = lint.linters.eslint_d
			local cpplint = lint.linters.cpplint
			local luacheck = lint.linters.luacheck
			local pylint = lint.linters.pylint

			eslint.args = {
				"--no-warn-ignored",
				"--format",
				"json",
				"ts",
				"js",
				"--stdin",
				"--stdin-filename",
				vim.fn.expand("%:p"),
				"--debug",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
			}

			cpplint.args = {
				"--filter=-legal/copyright",
			}

			luacheck.args = {
				"global = false",
			}

			pylint.args = {
				"-f",
				"json",
				"--from-stdin",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
				"--disable=C0114,C0116,W0611,E0401",
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>tl", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"onsails/lspkind.nvim",
			"L3MON4D3/LuaSnip", -- snippet engine
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			"rafamadriz/friendly-snippets", -- useful snippets
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			-- load vs-code like snippets from plugins (e.g. friendly-snippets)
			luasnip.setup({
				enable_autosnippets = true,
			})
			luasnip.config.set_config({
				region_check_events = "InsertEnter",
				delete_check_events = "InsertLeave",
			})
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/snippets/" } })

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				-- mapping = cmp.mapping.preset.insert({
				-- 	["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				-- 	["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				-- 	["<C-b>"] = cmp.mapping.scroll_docs(-4),
				-- 	["<C-f>"] = cmp.mapping.scroll_docs(4),
				-- 	["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				-- 	["<C-e>"] = cmp.mapping.abort(), -- close completion window
				-- 	["<CR>"] = cmp.mapping.confirm({ select = false }),
				-- }),
				-- sources for autocompletion
				sources = cmp.config.sources({
					{ name = "luasnip" }, -- snippets
					{ name = "nvim_lsp" }, -- lsp
					{ name = "buffer" }, -- text within current buffer
					{ name = "path" }, -- file system paths
				}),
				--configure lspkind for vs-code like icons
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
}
