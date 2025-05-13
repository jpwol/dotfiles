local App = require("astal.gtk3.app")
local Tray = astal.require("AstalTray")
local tray = Tray.get_default()
local map = require("lua.lib").map

return function()
	return Widget.Box({
		spacing = 5,
		bind(tray, "items"):as(function(items)
			return map(items, function(item)
				return Widget.MenuButton({
					tooltip_markup = bind(item, "tooltip_markup"),
					use_popover = false,
					valign = "CENTER",
					halign = "CENTER",
					menu_model = bind(item, "menu-model"),
					action_group = bind(item, "action-group"):as(function(ag)
						return { "dbusmenu", ag }
					end),
					Widget.Icon({
						g_icon = bind(item, "gicon"),
					}),
				})
			end)
		end),
	})
end
