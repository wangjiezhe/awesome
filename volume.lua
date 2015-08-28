-- Volume.lua

local awful = require("awful")
local wibox = require("wibox")
local color = require("color")

volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")
volume_widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() awful.util.spawn("pamixer --toggle-mute") end)
    ))

function update_volume(widget)
	local fd = io.popen("echo -n $(pamixer --get-volume)")
	local volume = fd:read("*all")
	fd:close()

	local fd = io.popen("echo -n $(pamixer --get-mute)")
	local mute = fd:read("*all")
	fd:close()

	if mute == "false" then
		volume_text = "Vol:" .. volume .. "%"
        bg = "black"
	else
		volume_text = "Vol:" .. volume .. "M"
        bg = "grey"
	end

    fg = gradient(0, 100, tonumber(volume))

    volume_markup = "<span foreground='" .. fg .. "' background='".. bg .. "'>" .. volume_text .. "</span>"

	widget:set_markup(volume_markup)
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
