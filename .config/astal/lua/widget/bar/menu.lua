local App = require("astal.gtk3.app")
local Network = astal.require("AstalNetwork")
local Wp = astal.require("AstalWp")
local Anchor = require("astal.gtk3").Astal.WindowAnchor
local map = require("lua.lib").map

return function()
	local menu_revealed = Variable(false)

	local wifi = Network.get_default().wifi
	local speaker = Wp.get_default().audio

	local connections = wifi.get_access_points(wifi)

	local menu = Widget.Window({
		name = "menu",
		class_name = "menu-box",
		anchor = Anchor.TOP + Anchor.RIGHT,
		visible = menu_revealed(),
		Widget.Box({
			vertical = true,
			valign = "START",
			Widget.Button({
				class_name = "menu-button",
				label = wifi.ssid,
				on_click = function()
					os.execute("notify-send 'clicked'")
				end,
			}),
		}),
	})

	local toggle_button = Widget.Button({
		class_name = "menu-button",
		halign = "CENTER",
		valign = "CENTER",
		hexpand = true,
		on_click = function()
			connections = wifi.get_access_points(wifi)
			menu_revealed:set(not menu_revealed:get())
			wifi.scan(wifi)
			-- for _, i in ipairs(connections) do
			-- 	if i.ssid ~= nil then
			-- 		print(i.ssid)
			-- 	end
			-- end
			map(connections, function(cn)
				print(cn.ssid)
			end)
		end,
		Widget.Icon({
			icon = "circle-symbolic",
			class_name = "menu-toggle",
			valign = "CENTER",
			halign = "CENTER",
			hexpand = true,
		}),
	})

	return {
		toggle_button,
		menu,
	}
end
