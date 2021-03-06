-- Volume.lua

local awful = require("awful")
local wibox = require("wibox")
local color = require("color")
local gears = require("gears")

local pulse = true
local timeout = 1

function update_volume (widget)
   local function isempty (s)
      return s == nil or s == ''
   end

   local function get_output (cmd)
      local fd = io.popen(cmd)
      local ret = fd:read()
      fd:close()
      return ret
   end

   local volume = get_output("echo -n $(pamixer --get-volume)")

   if isempty(volume) then
      pulse = false
      local volume = get_output("echo -n $(amixer get Master | grep 'Front Left:' | grep -o -E '\\[[[:digit:]]+%\\]') | grep -o -E '[[:digit:]]+' | tr -d '\n'")
   end

   local mute = get_output("echo -n $(pamixer --get-mute)")

   if isempty(mute) then
      pulse = false
      local status = get_output("echo -n $(amixer get Master | grep 'Front Left:' | grep -o '\\[on\\]\\|\\[off\\]') | grep -o -E '[[:alpha:]]+' | tr -d '\n'")
      if status == "on" then
         mute = "false"
      else
         mute = "true"
      end
   end

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

function inc_volume (widget)
   awful.spawn("pamixer --allow-boost --increase 1")
   update_volume(widget)
end

function dec_volume (widget)
   awful.spawn("pamixer --allow-boost --decrease 1")
   update_volume(widget)
end

function mute_volume (widget)
   awful.spawn("pamixer --toggle-mute")
   update_volume(widget)
end

volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")
volume_widget:buttons(
   gears.table.join(
      awful.button({}, 1, function () mute_volume(volume_widget) end),
      awful.button({}, 4, function () inc_volume(volume_widget) end),
      awful.button({}, 5, function () dec_volume(volume_widget) end)))

update_volume(volume_widget)

local timer = gears.timer.start_new(timeout, function () update_volume(volume_widget)
                                       return true end)
