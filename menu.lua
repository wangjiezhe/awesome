-- menu.lua

local awful = require("awful")
local beautiful = require("beautiful")

-- FreeDesktop
-- require('freedesktop.utils')
-- require('freedesktop.menu')
-- freedesktop.utils.icon_theme = 'gnome'
-- menu_items = freedesktop.menu.new()
-- myawesomemenu = {
--     { "manual", terminal .. " -e man awesome", freedesktop.utils.lookup_icon({ icon = 'system-help' }) },
--     { "edit config", editor_cmd .. " " .. awesome.conffile, freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
--     { "restart", awesome.restart, freedesktop.utils.lookup_icon({ icon = 'system-shutdown' }) },
--     { "quit", awesome.quit, freedesktop.utils.lookup_icon({ icon = 'system-shutdown' }) }
-- }
-- table.insert(menu_items, { "Awesome", myawesomemenu, beautiful.awesome_icon })
-- table.insert(menu_items, { "Wallpaper", wallmenu, freedesktop.utils.lookup_icon({ icon = 'gnome-settings-background' })})
-- mymainmenu = awful.menu({ items = menu_items, width = 250 })

-- Manually
myawesomemenu = {
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", awesome.quit }
}
networkmenu = {
    { "Chromium", "chromium" },
    { "Firefox", "firefox" },
    { "Thunderbird", "thunderbird" },
    { "Baidu Yun", "bcloud-gui" },
    { "Transmission", "transmission-gtk"}
}
mathmenu = {
    { "Sagemath", "sage -notebook" },
    { "Gap", "gap" },
    { "Maxima", "maxima" },
    { "XMaxima", "xmaxima" },
    { "R", "R" }
}
editormenu = {
    { "Gvim", "gvim" },
    { "Emacs", "emacs" }
}
libreofficemenu = {
    { "Base", "lobase" },
    { "Writer", "lowriter" },
    { "Calc", "localc" },
    { "Impress", "loimpress" },
    { "Draw", "lodraw" },
    { "Math", "lomath" }
}
terminalmenu = {
    { "URxvt", "urxvt" },
    { "URxvt(client)", "urxvtc" },
    { "URxvt(tabbed)", "urxvt-tabbed" },
    { "Xterm", "xterm" },
    { "UXterm", "uxterm" },
    { "Lxterminal", "lxterminal" }
}
graphicmenu = {
    { "GIMP", "gimp" },
    { "Inkscape", "inkscape" },
    { "Geeqie", "geeqie" }
}
latexmenu = {
    { "TeXmacs", "texmacs" },
    { "Lyx", "lyx" }
}
wpsmenu = {
    { "Writer", "wps" },
    { "Spreadsheets", "et" },
    { "Presentation", "wpp" }
}
mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },
                                    -- { "&firefox", "firefox", awful.util.getdir("config") .. "/firefox.png" },
                                    { "Network", networkmenu },
                                    { "Files", "pcmanfm" },
                                    { "Math", mathmenu },
                                    { "Editor", editormenu },
                                    { "LibreOffice", libreofficemenu },
                                    { "WPS Office", wpsmenu },
                                    { "LaTeX", latexmenu },
                                    { "Graphic", graphicmenu },
                                    { "Terminal", terminalmenu, beautiful.menu_terminal }
                                  }
                        })

-- Xdg_menu
-- xdg_menu = require("archmenu")
-- myawesomemenu = {
--     { "manual", terminal .. " -e man awesome" },
--     { "edit config", editor_cmd .. " " .. awesome.conffile },
--     { "restart", awesome.restart },
--     { "quit", awesome.quit }
-- }
-- mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
--                                     { "Applications", xdgmenu },
--                                     { "open terminal", terminal }
--                                   }
--                         })

menu_launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                        menu = mymainmenu })
