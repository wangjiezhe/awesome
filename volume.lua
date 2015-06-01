-- Volume.lua

local awful = require("awful")
local wibox = require("wibox")

volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")

function update_volume(widget)
	local fd = io.popen("echo -n $(pamixer --get-volume)")
	local volume = fd:read("*all")
	fd:close()

	local fd = io.popen("echo -n $(pamixer --get-mute)")
	local mute = fd:read("*all")
	fd:close()

	if mute == "false" then
		volume_text = "Vol:" .. volume .. "%"
	else
		volume_text = "Vol:" .. volume .. "M"
	end

	widget:set_markup(volume_text)
end

function inc_volume(widget)
	awful.util.spawn("pamixer --allow-boost --increase 1")
	update_volume(widget)
end

function dec_volume(widget)
	awful.util.spawn("pamixer --allow-boost --decrease 1")
	update_volume(widget)
end

function mute_volume(widget)
	awful.util.spawn("pamixer --toggle-mute")
	update_volume(widget)
end

update_volume(volume_widget)

volume_timer = timer({ timeout = 1 })
volume_timer:connect_signal("timeout", function () update_volume(volume_widget) end)
volume_timer:start()
