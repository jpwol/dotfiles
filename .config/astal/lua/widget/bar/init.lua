local Clock = require("lua.widget.bar.clock")
local Tray = require("lua.widget.bar.tray")
local ActiveClient = require("lua.widget.bar.activeclient")
local Workspaces = require("lua.widget.bar.workspaces")
local Indicators = require("lua.widget.bar.indicators")
local Menu = require("lua.widget.bar.menu")

local Anchor = require("astal.gtk3").Astal.WindowAnchor

return function(monitor)
	return Widget.Window({
		monitor = monitor,
		class_name = "bar",
		anchor = Anchor.TOP + Anchor.LEFT + Anchor.RIGHT,
		exclusivity = "EXCLUSIVE",
		Widget.CenterBox({
			class_name = "bar-centerbox",
			Widget.Box({
				halign = "START",
			}),
			Widget.Box({
				spacing = 5,
				Workspaces(),
				Clock(),
				Indicators(),
			}),
			Widget.Box({
				halign = "END",
				-- Wifi(),
				Tray(),
				Menu(),
			}),
		}),
	})
end
