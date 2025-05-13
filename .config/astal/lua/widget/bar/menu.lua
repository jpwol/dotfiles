local App = require("astal.gtk3.app")
local Network = astal.require("AstalNetwork")
local Wp = astal.require("AstalWp")
local Anchor = require("astal.gtk3").Astal.WindowAnchor
local map = require("lua.lib").map

return function()
	local revealed = Variable(false)
	local wifi = Network.get_default().wifi
	local speaker = Wp.get_default().audio

	local connections = {}

	local menu = Widget.Window({
		name = "menu",
		class_name = "menu-box",
		anchor = Anchor.TOP + Anchor.RIGHT,
		visible = revealed(),
		child = Widget.Box({
			children = map(connections, function(cn)
				print(cn.ssid)
				return Widget.Button({
					label = cn.ssid,
				})
			end),
		}),
	})

	local toggle_button = Widget.Button({
		Widget.Icon({
			icon = "circle-symbolic",
			class_name = "symbolic",
			valign = "CENTER",
		}),
		on_click = function()
			connections = wifi.get_access_points(wifi)
			revealed:set(not revealed:get())
			wifi.scan(wifi)
			for _, i in ipairs(connections) do
				if i.ssid ~= nil then
					print(i.ssid)
				end
			end
		end,
	})

	return {
		toggle_button,
		menu,
	}
end
