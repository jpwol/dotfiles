return {
	"freddiehaddad/feline.nvim",
	config = function()
		-- constants for ease of reading component location
		local vi_mode = require("feline.providers.vi_mode")

		local LEFT = 1
		local MIDDLE = 2
		local RIGHT = 3

		-- vi mode color configuration
		local MODE_COLORS = {
			["NORMAL"] = "green",
			["COMMAND"] = "skyblue",
			["INSERT"] = "orange",
			["REPLACE"] = "red",
			["LINES"] = "violet",
			["VISUAL"] = "violet",
			["OP"] = "yellow",
			["BLOCK"] = "yellow",
			["V-REPLACE"] = "yellow",
			["ENTER"] = "yellow",
			["MORE"] = "yellow",
			["SELECT"] = "yellow",
			["SHELL"] = "yellow",
			["TERM"] = "yellow",
			["NONE"] = "yellow",
		}

		-- gruvbox theme
		local EVERFOREST = {
			fg = "#859289",
			bg = "#2e383c",
			black = "#343e44",
			skyblue = "#7fbbb3",
			cyan = "#83c092",
			green = "#a7c080",
			oceanblue = "#076678",
			blue = "#3a515d",
			magenta = "#d699b6",
			orange = "#e69875",
			red = "#e87e80",
			violet = "#d699b6",
			white = "#d3c6aa",
			yellow = "#dbbc7f",
			gray = "#859289",
			darkgreen = "#3d484d",
		}

		-- icons
		local icons = {
			lua = "",
			c = "󰙱",
			cpp = "",
			cs = "",
			js = "",
			py = "",
			rs = "",
			html = "",
			scss = "",
			sass = "",
		}

		-- functions for getting information

		-- get the filename
		function get_filename()
			local filename = vim.api.nvim_buf_get_name(0)
			local file_extension = vim.fn.fnamemodify(filename, ":e")
			local icon = icons[file_extension] or ""

			if filename == "" then
				filename = "[no name]"
			end

			return icon .. " " .. vim.fn.fnamemodify(filename, ":t")
		end

		-- get the filetype as a string
		function get_filetype()
			local filetype = vim.bo.filetype
			if filetype == "" then
				filetype = "[no type]"
			end
			return filetype:lower()
		end

		-- get the line the cursor is on
		function get_line_cursor()
			local cursor_line, cursor_column = unpack(vim.api.nvim_win_get_cursor(0))
			local file_length = vim.api.nvim_buf_line_count(0)
			local file_percent = cursor_line / file_length * 100
			return cursor_line .. ":" .. cursor_column .. " " .. math.floor(file_percent) .. "%%"
		end

		-- get the file's total lines
		-- function get_file_percent()
		-- 	return vim.api.nvim_buf_line_count(0)
		-- end

		-- wrapper functions to place components
		function no_wrap(string)
			return string
		end

		function wrap(string)
			return " " .. string .. " "
		end

		function wrap_left(string)
			return "" .. string .. " "
		end

		function wrap_right(string)
			return " " .. string .. ""
		end

		function wrapped_provider(provider, wrapper)
			return function(component, opts)
				return wrapper(provider(component, opts))
			end
		end

		-- providers for the wrapper
		function provide_filename(component, opts)
			return get_filename()
		end

		function provide_filetype(component, opts)
			return get_filetype()
		end

		function provide_linenumber(component, opts)
			return get_line_cursor()
		end

		function provide_mode(component, opts)
			return vi_mode.get_vim_mode()
		end

		local components = {
			active = {
				{},
				{},
				{},
			},
			inactive = {
				{},
				{},
				{},
			},
		}

		table.insert(components.active[LEFT], {
			name = "mode",
			provider = wrapped_provider(provide_mode, wrap),
			right_sep = {
				str = "right_filled",
				hl = function()
					return {
						bg = "darkgreen",
						fg = vi_mode.get_mode_color(),
					}
				end,
			},
			hl = function()
				return {
					fg = "black",
					bg = vi_mode.get_mode_color(),
					style = "bold",
				}
			end,
		})

		table.insert(components.active[LEFT], {
			name = "josh",
			provider = wrapped_provider(provide_filename, wrap),
			right_sep = "right_filled",
			hl = {
				fg = "green",
				bg = "darkgreen",
			},
		})

		table.insert(components.active[RIGHT], {
			name = "filetype",
			provider = wrapped_provider(provide_filetype, wrap),
			left_sep = "left_filled",
			hl = {
				bg = "darkgreen",
				fg = "white",
				style = "bold",
			},
		})

		table.insert(components.active[RIGHT], {
			name = "line_numbers",
			provider = wrapped_provider(provide_linenumber, wrap),
			left_sep = {
				str = "left_filled",
				hl = { fg = "cyan", bg = "darkgreen" },
			},
			hl = {
				bg = "cyan",
				fg = "black",
				style = "bold",
			},
		})

		-- table.insert(components.inactive[LEFT], {
		-- 	name = "inactive_filename",
		-- 	provider = wrapped_provider(provide_filename, wrap),
		-- 	right_sep = "right_filled",
		-- 	hl = { fg = "black", bg = "white" },
		-- })

		local feline = require("feline")
		feline.setup({
			theme = EVERFOREST,
			components = components,
			vi_mode_colors = MODE_COLORS,
		})
		feline.winbar.setup({})
		-- feline.statuscolumn.setup()
	end,
}
