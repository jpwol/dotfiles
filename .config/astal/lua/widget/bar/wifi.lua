local astal = require("astal")
local bind = astal.bind

local Network = astal.require("AstalNetwork")
local Widget = require("astal.gtk3.widget")

return function()
	local network = Network.get_default()
	local wifi = bind(network, "wifi")

	return Widget.Box({
		visible = wifi:as(function(v)
			return v ~= nil
		end),
		wifi:as(function(w)
			return Widget.Icon({
				tooltip_text = bind(w, "ssid"):as(tostring),
				class_name = "Wifi",
				icon = bind(w, "icon-name"),
			})
		end),
	})
end
