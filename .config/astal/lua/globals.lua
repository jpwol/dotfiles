lgi = require("lgi")
astal = require("astal")
GLib = astal.require("GLib")
Gtk = lgi.require("Gtk", "3.0")
Gdk = astal.Gdk
Gio = astal.require("Gio")
GdkPixbuf = astal.require("GdkPixbuf", "2.0")

Astal = astal.Astal
Widget = require("astal.gtk3.widget")
Widget.GtkMenu = Widget.astalify(Gtk.Menu)
Widget.GtkMenuItem = Widget.astalify(Gtk.MenuItem)
Widget.GtkRevealer = Widget.astalify(Gtk.Revealer)
bind = astal.bind

Variable = astal.Variable
GlobalBus = nil

Gio.bus_get(Gio.BusType.SESSION, nil, function(_, task)
	GlobalBus = Gio.bus_get_finish(task)
end)

switch = function(element)
	local Table = {
		["Value"] = element,
		["DefaultFunction"] = nil,
		["Functions"] = {},
	}

	Table.case = function(...)
		local args = { ... }
		assert(type(args[#args]) == "function")
		local callback = table.remove(args, #args)
		for _, arg in ipars(args) do
			Table.Functions[arg] = callback
		end
		return Table
	end

	Table.default = function(callback)
		Table.DefaultFunction = callback
		return Table
	end

	Table.process = function()
		local Case = Table.Functions[Table.Value]
		if Case then
			return Case(Table.Value)
		elseif Table.DefaultFunction then
			return Table.DefaultFunction()
		end
	end

	return Table
end

local tb_override = function(target, source)
	for key, value in pairs(source) do
		target[key] = value
	end
	return target
end

lookup_icon = function(args)
	if type(args) == "string" then
		return lookup_icon({ icon_name = args })
	elseif type(args) == "table" then
		local path = nil
		if #args >= 1 and not args.icon_name then
			for _, value in ipairs(args) do
				path = lookup_icon(value)
				if path then
					return path
				end
			end
			return
		elseif args.icon_name and type(args.icon_name) == "table" then
			for _, value in ipairs(args.icon_name) do
				path = lookup_icon({
					icon_name = value,
					size = args.size,
					path = args.path,
				})
				if path then
					return path
				end
			end
			return
		end
	end

	if not args or not args.icon_name then
		return
	end

	args = tb_override({
		icon_name = "",
		size = 128,
		path = true,
	}, args)

	local theme = Gtk.IconTheme.get_default()
	local icon_info, path

	for _, name in ipairs({
		args.icon_name,
		args.icon_name:lower(),
		args.icon_name:upper(),
	}) do
		icon_info = theme:lookup_icon(name, args.size, "USE_BUILTIN")

		if icon_info then
			path = icon_info:get_filename()

			if path then
				if args.path then
					return string.match(path, ".*/(.+)%.[^%.]+$")
					-- return name
				else
					return icon_info:load_icon()
				end
			end
		end
	end
end

ternary = function(condition, if_true, if_false)
	if condition then
		return if_true
	else
		return if_false
	end
end

rem = function(px)
	return px / 16
end

if not table.unpack then
	table.unpack = unpack
end
