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
local hotkeys_popup = require("awful.hotkeys_popup").widget

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
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local theme = dofile(awful.util.get_themes_dir() .. "default/theme.lua")
theme.font = "dejavu sans mono 8"
theme.menu_height = 20
theme.menu_width = 170
theme.wallpaper = "/usr/share/archlinux/wallpaper/archlinux-simplyblack.png"
beautiful.init(theme)

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
awful.layout.layouts = {
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
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s in screen do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tag_t = {
    names = { '|1.Term', '|2.WWW', '|3.Files', '|4.Edit', '|5.Entertainment', '|6.Wiki', '|7.Mail', '|8.Math', '|9.Others' },
    layouts = {}
}
tags = {}
for s in screen do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tag_t.names, s, awful.layout.layouts[2])
end
-- }}}

-- {{{ Autostart
-- awful.spawn_with_shell(terminal)
-- }}}


-- {{{ Menu
-- Create a launcher widget and a main menu
local menu = require("menu")

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- app_folders = { "/usr/share/applications/", "~/.local/share/applications/" }
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock("%a %b %d %Y, %H:%M:%S", 1)

-- Spacer
spacer = wibox.widget.textbox()
spacer:set_markup(" ")

-- Volume widget
local volume = require("volume")

-- Ip widget
local ip = require("ip")

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
                                                      awful.tag.viewonly(c.first_tag)
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

for s in screen do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    -- mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Add widgets to the wibox
    mywibox[s]:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
        },
        mytasklist[s], -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            spacer,
            wibox.widget.systray(),
            -- spacer,
            net_wireless,
            net_wired,
            ip_widget,
            spacer,
            volume_widget,
            spacer,
            mytextclock,
            spacer,
            battery_widget,
            spacer,
            mylayoutbox[s],
        },
    }
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
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, "Shift"   }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey, "Shift"   }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ modkey            }, "e",      revelation,
       {description = "client control", group = "client"}),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey, "Shift"   }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control", "Shift" }, "q",
        function ()
            -- awful.spawn("killall sogou-qimpanel-watchdog")
            awesome.quit()
        end,
        {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.spawn("xlock -mode invert")   end,
       {description = "lock screen", group = "utils"}),
    -- awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end,
    --           {description = "increase master width factor", group = "layout"}),
    -- awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    --           {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[awful.screen.focused()]:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[awful.screen.focused()].widget,
                  awful.util.eval, nil,
                  awful.util.get_cache_dir() .. "/history_eval")
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),

    -- Screenshot
    awful.key({ }, "Print", function () awful.spawn("scrot -e 'mv $f ~/Pictures/Screenshots/ 2>/dev/null'") end,
       {description = "screenshot", group = "utils"}),

    -- Volume control
    awful.key({ }, "XF86AudioRaiseVolume", function () inc_volume(volume_widget) end,
       {description = "volume up -- Fn + F12", group = "audio"}),
    awful.key({ }, "XF86AudioLowerVolume", function () dec_volume(volume_widget) end,
       {description = "volume down -- Fn + F11", group = "audio"}),
    awful.key({ }, "XF86AudioMute", function () mute_volume(volume_widget) end,
       {description = "toggle mute -- Fn + F10", group = "audio"}),

    -- Media control
    awful.key({ }, "XF86AudioNext", function () awful.spawn("mpc next") end,
       {description = "next audio -- Fn + Right", group = "audio"}),
    awful.key({ }, "XF86AudioPrev", function () awful.spawn("mpc prev") end,
       {description = "previous audio -- Fn + Left", group = "audio"}),
    awful.key({ }, "XF86AudioStop", function () awful.spawn("mpc stop") end,
       {description = "stop audio -- Fn + Up", group = "audio"}),
    awful.key({ }, "XF86AudioPlay", function () awful.spawn("mpc toggle") end,
       {description = "play/pause audio -- Fn + Down", group = "audio"}),

    -- X backlight
    awful.key({ }, "XF86MonBrightnessUp", function () awful.spawn("xbacklight -inc 10") end,
       {description = "increase backlight of screen (no use now) -- Fn + F6", group = "screen"}),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn("xbacklight -dec 10") end,
       {description = "decrease backlight of screen (no use now) -- Fn + F5", group = "screen"}),

    -- Kbd backlight
    awful.key({ }, "XF86KbdBrightnessUp", function () awful.spawn("asus-kbd-backlight up") end,
       {description = "increase backlight of keyboard -- Fn + F4", group = "keyboard"}),
    awful.key({ }, "XF86KbdBrightnessDown", function () awful.spawn("asus-kbd-backlight down") end,
       {description = "decrease backlight of keyboard -- Fn + F3", group = "keyboard"}),

    -- WebCam
    awful.key({ }, "XF86WebCam", function () awful.spawn("cheese") end,
       {description = "webcam -- Fn + v", group = "utils"}),

    -- Calculator
    awful.key({ }, "XF86Calculator", function () awful.spawn("galculator") end,
       {description = "calculator", group = "utils"}),

    -- Quick Launch
    awful.key({ }, "XF86Launch6", function () awful.spawn("emacs") end,
       {description = "quick launch 6 (start emacs) -- Fn + Space", group = "utils"}),

    -- Touchpad toggle
    awful.key({ }, "XF86TouchpadToggle", function () awful.spawn(home_path .. "bin/touchpad_toggle.sh") end,
       {description = "toggle touchpad -- Fn + F9", group = "touchpad"}),

    -- Transparency
    awful.key({ modkey }, "Next", function (c) awful.spawn("transset-df --actual --inc 0.1") end,
       {description = "increase transparency", group = "screen"}),
    awful.key({ modkey }, "Prior", function (c) awful.spawn("transset-df --actual --dec 0.1") end,
       {description = "decrease transparency", group = "screen"}),

    -- Xkill
    awful.key({ modkey, "Control", "Shift" }, "x", function () awful.spawn("xkill") end,
       {description = "kill a client by its X resource", group = "utils"})
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),

    -- Toggle titlebar visibility
    awful.key({ modkey, "Shift" }, "t", function (c) awful.titlebar.toggle(c) end,
       {description = "toggle titlebar", group = "client"}),

    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
        -- Toggle tag.
--        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
--                  function ()
--                      if client.focus then
--                          local tag = awful.tag.gettags(client.focus.screen)[i]
--                          if tag then
--                              awful.client.toggletag(tag)
--                          end
--                      end
--                  end,
--                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
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
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          -- "copyq",  -- Includes session name in class.
        },
        class = {
           "feh"
          -- "Arandr",
          -- "Gpick",
          -- "Kruler",
          -- "MessageWin",  -- kalarm.
          -- "Sxiv",
          -- "Wpa_gui",
          -- "pinentry",
          -- "veromix",
          -- "xtightvncviewer"
        },
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
    }, properties = { floating = true }},

    -- Maximized clients.
    { rule_any = {
         class = {
            "URxvt",
            "Gvim",
            "Lxterminal",
            "Roxterm"
         }
    }, properties = { maximized = true }},

    -- Tagged clients.
    { rule_any = {
         class = {
            "XTerm",
            "UXTerm",
            "Lxterminal",
            "Roxterm"
         }
    }, properties = { tag = tags[1], switchtotag = true }},

    { rule_any = {
         class = {
            "Firefox",
            "chromium",
            "yandex-browser-beta"
         }
    }, properties = { tag = tags[screen[1]][2], switchtotag = true }},

    { rule_any = {
         class = {
            "Pcmanfm",
            "File-roller",
            "Filezilla",
            "Bleachbit",
            "CAJVieweru.exe",
            "SsReader.exe",
            "RHUD30.EXE"
         }
    }, properties = { tag = tags[screen[1]][3], switchtotag = true }},

    { rule_any = {
         instance = {
            "libreoffice"
         },
         name = {
            "LibreOffice"
         },
         class = {
            "Wps", "Et", "Wpp",
            "Texmacs.bin",
            "Gummi", "TexMaker", "TeXstudio", "Lyx",
            "Gracket", "DrRacket",
            "Poedit",
            "Java", "Eclipse", "jetbrains-studio",
            "jetbrains-pycharm", "Spyder", "Dreampie",
            "Astah",
            "assistant", "Assistant-qt4", "assistant-qt5", "Designer", "Designer-qt4",
            "fontforge",
            "cmake-gui",
            "Bluefish", "Bluegriffon",
            "Scribus",
            "OmegaT"
         }
    }, properties = { tag = tags[screen[1]][4], switchtotag = true }},

    { rule_any = {
         class = {
            "Gimp", "Inkscape", "Gcolor2",
            "Geeqie",
            "mpv", "MPlayer", "Kwplayer", "Ario", "Gmpc", "FeelUOwn",
            "Paman", "Pavucontrol", "Pavumeter",
            "Lenmus",
            "Cheese", "guvcview",
            "Steam", "supertux2", "mGBA", "bm2000.exe", "ltpb.exe",
            "stellarium",
            "Solfege", "TuxGuitar",
            "Ardour-4.6.0"
         }
    }, properties = { tag = tags[screen[1]][5], switchtotag = true }},

    { rule_any = {
         class = {
            "VirtualBox",
            "Zenmap", "Wireshark",
            "Shutter",
            "WizNote", "Wiz"
         }
    }, properties = { tag = tags[screen[1]][6], switchtotag = true }},

    { rule_any = {
         name = {
            "Electronic WeChat"
         },
         class = {
            "Thunderbird",
            "Pidgin",
            "QQ.exe",
            "Linphone", "Ekiga"
         }
    }, properties = { tag = tags[screen[1]][7], switchtotag = true }},

    { rule_any = {
         name = {
            "^sage$",
            "gp", "^gap$", "Singular", "fricas", "yacas",
            "reduce", "redcsl", "HyperDoc",
            "Xmaxima", "Wxmaxima",
            "Octave-gui",
            "^R$", "RStudio",
            "GeoGebra"
         },
         class = {

         }
    }, properties = { tag = tags[screen[1]][8], switchtotag = true }},

    { rule_any = {
         name = {
            "Wine"
         },
         class = {
            "Transmission-gtk",
            "115pan",
            "Bcloud-gui",
            "Seahorse"
         }
    }, properties = { tag = tags[screen[1]][9], switchtotag = true }},

    -- Semi transparent clients.
    { rule = { class = "URxvt" },
      properties = { opacity = 0.8 }}
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    if not awesome.startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they do not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    elseif not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
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

        awful.titlebar(c) : setup {
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal
            },
            { -- Middle
                { -- Title
                    align  = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            { -- Right
                awful.titlebar.widget.floatingbutton (c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton   (c),
                awful.titlebar.widget.ontopbutton    (c),
                awful.titlebar.widget.closebutton    (c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end
end)

-- Enable sloppy focus
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
