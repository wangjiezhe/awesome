-- ip.lua

local wibox = require("wibox")
local socket = require("socket")

local s = socket.udp()
local ret = s:setpeername("202.141.176.93", 80)
local ip = ""

if ret ~= nil then
   ip, _ = s:getsockname()
else
   ip = socket.dns.toip(socket.dns.gethostname())
end

ip_widget = wibox.widget.textbox()
ip_widget:set_markup(ip)
