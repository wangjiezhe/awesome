-- battery.lua

local awful = require("awful")
local wibox = require("wibox")

battery_widget = wibox.widget.textbox()
battery_widget:set_align("right")

local ac_adapter = "AC0"
local bat_adapter = "BAT0"

function show_battery (widget)
    local fac = io.open("/sys/class/power_supply/" .. ac_adapter .. "/online")
    local fful = io.open("/sys/class/power_supply/" .. bat_adapter .. "/energy_full")
    local fcur = io.open("/sys/class/power_supply/" .. bat_adapter .. "/energy_now")
    local fsta = io.open("/sys/class/power_supply/" .. bat_adapter .. "/status")
    local ac = fac:read()
    local ful = fful:read()
    local cur = fcur:read()
    local sta = fsta:read()
    fac:close()
    fful:close()
    fcur:close()
    fsta:close()

    local battery = math.floor(cur * 100 / ful)

    if ac:match("0") then
        dir = "v"
        if battery <= 10 then
            naughty.notify({ title = "Battery Waring",
                             text = "Batter low! Only ".. battery .. "% left!",
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

    sur = 100 - battery
    fg = gradient(0, 100, sur)

    battery_text = "Bat: " .. dir .. battery .. "%" .. dir
    battery_markup = "<span foreground='" .. fg .. "' background='black'>" .. battery_text .. "</span>"

    widget:set_markup(battery_markup)
end

show_battery(battery_widget)

battery_timer = timer({ timeout = 10 })
battery_timer:connect_signal("timeout", function () show_battery(battery_widget) end)
battery_timer:start()
