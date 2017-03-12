-- battery.lua

local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local color = require("color")

battery_widget = wibox.widget.textbox()
battery_widget:set_align("right")

local ac_adapter = "AC0"
local bat_adapter = "BAT0"
local timeout = 1

function show_battery (widget)
   local function get_output (file)
      local fd = io.open(file)
      local ret = fd:read()
      fd:close()
      return ret
   end

   local ac = get_output("/sys/class/power_supply/" .. ac_adapter .. "/online")
   -- local ful = get_output("/sys/class/power_supply/" .. bat_adapter .. "/energy_full")
   -- local cur = get_output("/sys/class/power_supply/" .. bat_adapter .. "/energy_now")
   local sta = get_output("/sys/class/power_supply/" .. bat_adapter .. "/status")

   -- local bat = math.floor(cur * 100 / ful)
   local bat = get_output("/sys/class/power_supply/" .. bat_adapter .. "/capacity")
   bat = tonumber(bat)

   if ac:match("0") then
      dir = "v"
      if bat <= 10 then
         naughty.notify({ title = "Battery Waring",
                          text = "Batter low! Only ".. bat .. "% left!",
                          timeout = 5,
                          fg = beautiful.fg_focus,
                          bg = beautiful.bg_focus})
      end
   elseif ac:match("1") then
      if sta:match("Discharging") then
         dir = "="
      elseif sta:match("Charging") then
         dir = "^"
      end
   end

   sur = 100 - bat
   fg = gradient(0, 100, sur)

   battery_text = "Bat: " .. dir .. bat .. "%" .. dir
   battery_markup = "<span foreground='" .. fg .. "' background='black'>" .. battery_text .. "</span>"

   widget:set_markup(battery_markup)
end

show_battery(battery_widget)

local timer = gears.timer.start_new(timeout, function () show_battery(battery_widget)
                                       return true end)
