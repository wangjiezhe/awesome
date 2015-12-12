-- Configure home path so you dont have too
home_path  = os.getenv('HOME') .. '/'

-- Standard lua library
local socket = require("socket")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- Powerline
-- package.path = package.path .. ';/usr/lib/python2.7/site-packages/powerline/bindings/awesome/powerline.lua'
-- require('powerline')

-- Revelation
local revelation = require("revelation")

-- Bashets
-- local bashets = require("bashets")
-- bashets.set_script_path = awful.util.getdir("config") .. "bashets"
-- bashets.set_temporary_path = "/dev/shm/tmp"

-- Naughty
naughty.config.presets.normal.opacity = 0.8
naughty.config.presets.low.opacity = 0.8
naughty.config.presets.critical.opacity = 0.8

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
-- gears.wallpaper.maximized("/usr/share/archlinux/wallpaper/archlinux-simplyblack.png", s, true)
beautiful.init( awful.util.getdir("config") .. "/themes/default/theme.lua" )

revelation.init()

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.magnifier,
    awful.layout.suit.floating,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
    names = { '|1.Term', '|2.WWW', '|3.Files', '|4.Edit', '|5.Entertainment', '|6.Wiki', '|7.Mail', '|8.Math', '|9.Others' },
    layouts = {}
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, layouts[2])
end
-- }}}

-- {{{ Autostart
-- awful.util.spawn_with_shell(terminal)
-- }}}


-- {{{ Menu
-- Create a laucher widget and a main menu
local menu = require("menu")

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
app_folders = { "/usr/share/applications/", "~/.local/share/applications/" }
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock("%a %b %d %Y, %H:%M:%S", 1)

-- Spacer
spacer = wibox.widget.textbox()
spacer:set_markup(" ")

-- Volume widget
local volume = require("volume")

-- Ip widget
ip_widget = wibox.widget.textbox()
ip = socket.dns.toip(socket.dns.gethostname())
ip_widget:set_markup(ip)

-- Battery widget
local battery = require("battery")

-- Net widget
local net_widgets = require("net_widgets")
net_wireless = net_widgets.wireless({
    interface="wlp4s0",
    indent=1,
    font="dejavu sans mono 8",
    })
net_wired = net_widgets.indicator({
    interfaces = {"enp5s0"},
    font="dejavu sans mono 8",
    })

-- bashets.start()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    -- mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(menu_launcher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(spacer)
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(net_wireless)
    right_layout:add(spacer)
    right_layout:add(net_wired)
    right_layout:add(spacer)
    right_layout:add(ip_widget)
    right_layout:add(spacer)
    right_layout:add(volume_widget)
    right_layout:add(spacer)
    right_layout:add(mytextclock)
    right_layout:add(spacer)
    right_layout:add(battery_widget)
    right_layout:add(spacer)
    right_layout:add(mylayoutbox[s])
    -- right_layout:add(powerline-widget)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    -- awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey            }, "e",      revelation),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",
        function ()
            -- awful.util.spawn("killall sogou-qimpanel-watchdog")
            awesome.quit()
        end),

    awful.key({ modkey,           }, "l",     function () awful.util.spawn("xlock") end),
    -- awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),

    -- Screenshot
    awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/Pictures/Screenshots/ 2>/dev/null'") end),

    -- Volume control
    awful.key({ }, "XF86AudioRaiseVolume", function () inc_volume(volume_widget) end),
    awful.key({ }, "XF86AudioLowerVolume", function () dec_volume(volume_widget) end),
    awful.key({ }, "XF86AudioMute", function () mute_volume(volume_widget) end),

    -- Media control
    awful.key({ }, "XF86AudioNext", function () awful.util.spawn("mpc next") end),
    awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("mpc prev") end),
    awful.key({ }, "XF86AudioStop", function () awful.util.spawn("mpc stop") end),
    awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("mpc toggle") end),

    -- X backlight
    awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 10") end),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 10") end),

    -- Kbd backlight
    awful.key({ }, "XF86KbdBrightnessUp", function () awful.util.spawn("asus-kbd-backlight up") end),
    awful.key({ }, "XF86KbdBrightnessDown", function () awful.util.spawn("asus-kbd-backlight down") end),

    -- WebCam
    awful.key({ }, "XF86WebCam", function () awful.util.spawn("guvcview") end),

    -- Touchpad toggle
    awful.key({ }, "XF86TouchpadToggle", function () awful.util.spawn(home_path .. "bin/touchpad_toggle.sh") end),

    -- Transparency
    awful.key({ modkey }, "Next", function (c) awful.util.spawn("transset-df --actual --inc 0.1") end),
    awful.key({ modkey }, "Prior", function (c) awful.util.spawn("transset-df --actual --dec 0.1") end),

    -- Xkill
    awful.key({ modkey, "Control", "Shift" }, "x", function () awful.util.spawn("xkill") end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),

    -- Toggle titlebar visibility
    awful.key({ modkey, "Shift" }, "t", function (c) awful.titlebar.toggle(c) end),

    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     size_hints_honor = false,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    -- { rule = { class = "MPlayer" },
    --   properties = { floating = true } },
    -- { rule = { class = "pinentry" },
    --   properties = { floating = true } },
    -- { rule = { class = "gimp" },
    --   properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
    { rule = { class = "URxvt" },
      properties = { maximized_vertical = true, maximized_horizontal = true, opacity = 0.8 }},
    { rule = { class = "Gvim" },
      properties = { maximized_vertical = true, maximized_horizontal = true } },
    { rule = { class = "Emacs" },
      properties = { maximized_vertical = true, maximized_horizontal = true }},
    { rule = { class = "xterm" },
      properties = { floating = true, tag = tags[1][1] }},
    { rule = { class = "Lxterminal" },
      properties = { maximized_vertical = true, maximized_horizontal = true, tag = tags[1][1] }},
    { rule = { class = "Firefox" },
      properties = { floating=true, tag = tags[1][2], switchtotag = true }},
    { rule = { class = "chromium" },
      properties = { tag = tags[1][2], switchtotag = true }},
    { rule = { class = "Yandex-browser-beta" },
      properties = { tag = tags[1][2], switchtotag = true }},
    { rule = { class = "Pidgin" },
      properties = { tag = tags[1][7], switchtotag = true }},
    { rule = { class = "Pcmanfm" },
      properties = { floating = true, tag = tags[1][3], switchtotag = true }},
    { rule = { class = "File-roller" },
      properties = { floating = true }},
    { rule = { class = "Filezilla" },
      properties = { floating = true, tag = tags[1][3], switchtotag = true }},
    { rule = { class = "Bleachbit" },
      properties = { floating = true, tag = tags[1][3], switchtotag = true }},
    { rule = { instance = "libreoffice" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Wps" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Et" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Wpp" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Lyx" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Texmacs.bin" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "TexMaker" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Gummi" },
      properties = { tag = tags[1][4], switchtotag = true }},
    { rule = { class = "DrRacket" },
      properties = { flaoting=true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Gracket" },
      properties = { floating=true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Poedit" },
      properties = { flaoting=true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "TeXstudio" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Spyder" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Eclipse" },
      properties = { tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Java" },
      properties = { tag = tags[1][4], switchtotag = true }},
    { rule = { class = "jetbrains-pycharm" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Astah" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "jetbrains-studio" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "assistant" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Assistant-qt4" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "assistant-qt5" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Designer" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Designer-qt4" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "fontforge" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { instance = "cmake-gui" },
      properties = { floating = true, tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Bluefish" },
      properties = { tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Bluegriffon" },
      properties = { tag = tags[1][4], switchtotag = true }},
    { rule = { class = "OmegaT" },
      properties = { tag = tags[1][4], switchtotag = true }},
    { rule = { class = "Gimp" },
      properties = { tag = tags[1][5], switchtotag = true }},
    { rule = { class = "Inkscape" },
      properties = { tag = tags[1][5], switchtotag = true }},
    { rule = { class = "Geeqie" },
      properties = { tag = tags[1][3], switchtotag = true }},
    { rule = { class = "Gcolor2" },
      properties = { tag = tags[1][5], switchtotag = true }},
    { rule = { class = "feh" },
      properties = { floating = true }},
    { rule = { class = "mpv" },
      properties = { floating = true, tag = tags[1][5], switchtotag = true }},
    { rule = { class = "Mplayer" },
      properties = { floating = true, tag = tags[1][5], switchtotag = true }},
    { rule = { class = "Kwplayer" },
      properties = { tag = tags[1][5], switchtotag = true }},
    { rule = { class = "Ario" },
      properties = { floating = true, tag = tags[1][5], switchtotag = true }},
    { rule = { class = "Gmpc" },
      properties = { floating = true, tag = tags[1][5], switchtotag = true }},
    { rule = { class = "Paman" },
      properties = { floating = true, tag = tags[1][5], switchtotag = true }},
    { rule = { class = "Pavucontrol" },
      properties = { floating = true, tag = tags[1][5], switchtotag = true }},
    { rule = { class = "Pavumeter" },
      properties = { floating = true, tag = tags[1][5], switchtotag = true }},
    { rule = { class = "Cheese" },
      properties = { floating = true, tag = tags[1][5], switchtotag = true }},
    { rule = { class = "Steam" },
      properties = { floating = true, tag = tags[1][5], switchtotag = true }},
    { rule = { instance = "guvcview" },
      properties = { floating = true, tag = tags[1][5], switchtotag = true }},
    { rule = { instance = "VirtualBox" },
      properties = { floating = true, tag = tags[1][6], switchtotag = true }},
    { rule = { class = "Zenmap" },
      properties = { floating = true, tag = tags[1][6], switchtotag = true }},
    { rule = { class = "Wireshark" },
      properties = { floating = true, tag = tags[1][6], switchtotag = true }},
    { rule = { class = "Shutter" },
      properties = { floating = true, tag = tags[1][6], switchtotag = true }},
    { rule = { class = "Thunderbird" },
      properties = { floating = true, tag = tags[1][7], switchtotag = true }},
    { rule = { name = "^sage$" },
      properties = { floating = true, tag = tags[1][8], switchtotag = true }},
    { rule = { name = "gp" },
      properties = { floating = true, tag = tags[1][8], switchtotag = true }},
    { rule = { name = "gap" },
      properties = { floating = true, tag = tags[1][8], switchtotag = true }},
    { rule = { name = "Singular" },
      properties = { floating = true, tag = tags[1][8], switchtotag = true }},
    { rule = { name = "^R$" },
      properties = { floating = true, tag = tags[1][8], switchtotag = true }},
    { rule = { class = "Xmaxima" },
      properties = { floating = true, tag = tags[1][8], switchtotag = true }},
    { rule = { class = "Wxmaxima" },
      properties = { floating = true, tag = tags[1][8], switchtotag = true }},
    { rule = { class = "Octave-gui" },
      properties = { tag = tags[1][8], switchtotag = true }},
    { rule = { class = "RStudio" },
      properties = { floating = true, tag = tags[1][8], switchtotag = true }},
    { rule = { class = "Transmission-gtk" },
      properties = { floating = true, tag = tags[1][9], switchtotag = true }},
    { rule = { class = "Bcloud-gui" },
      properties = { floating=true, tag = tags[1][9], switchtotag = true }},
    { rule = { class = "115pan" },
      properties = { floating = true, tag = tags[1][9], switchtotag = true }},
    { rule = { class = "Seahorse" },
      properties = { floating = true, tag = tags[1][9], switchtotag = true }},
    { rule = { class = "QQ.exe" },
      properties = { floating = true, tag = tags[1][9], switchtotag = true }},
    { rule = { class = "RHUD30.EXE" },
      properties = { floating = true, tag = tags[1][9], switchtotag = true }},
    { rule = { class = "CAJVieweru.exe" },
      properties = { floating = true, tag = tags[1][3], switchtotag = true }},
    { rule = { class = "SsReader.exe" },
      properties = { floating = true, tag = tags[1][3], switchtotag = true }},
    { rule = { class = "Wine" },
      properties = { floating = true, tag = tags[1][9], switchtotag = true }}
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- client.connect_signal("exit", function () awful.util.spawn("exit.sh") end)
-- }}}
