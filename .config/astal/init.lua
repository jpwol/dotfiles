require("lua.globals")

pcall(require, "luarocks.loaders")

local App = require("astal.gtk3.app")
local Bar = require("lua.widget.bar.init")

local scss = "./style.scss"
local css = "/tmp/style.css"
local icons = "./icons"

astal.exec(string.format("sassc %s %s", scss, css))

App:start({
	icons = icons,
	css = css,
	instance_name = "astal-lua",
	main = function()
		Bar(0)
	end,
})
