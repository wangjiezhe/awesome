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
    { "115 Pan", "115pan" },
    { "Filezilla", "filezilla" },
    { "Pidgin", "pidgin" },
    { "Transmission", "transmission-gtk" }
}
sciencemenu = {
    { "Spyder", "spyder" },
    { "Spyder (python3)", "spyder3"}
}
maximamenu = {
    { "Maxima", terminal .. " -e maxima" },
    { "Xmaxima", "xmaxima" },
    { "wxMaxima", "wxmaxima" }
}
mathmenu = {
    { "Sage", terminal .. " -e sage" },
    { "Sage(Notebook)", terminal .. " -e sage -notebook" },
    { "Science", sciencemenu },
    { "GAP", terminal .. " -e gap" },
    { "GP/PARI", terminal .. " -e gp"},
    { "Maxiama", maximamenu },
    { "R", terminal .. " -e R" }
}
editormenu = {
    { "Gvim", "gvim" },
    { "Emacs", "emacs" },
    { "PyCharm", "pycharm" },
    { "Eclipse", "eclipse" },
    { "Android Studio", "android-studio" }
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
    { "TexMaker", "texmaker" },
    { "TeXmacs", "texmacs" },
    { "Lyx", "lyx" }
}
wpsmenu = {
    { "Writer", "wps" },
    { "Spreadsheets", "et" },
    { "Presentation", "wpp" }
}
multimediamenu = {
    { "Ario", "ario" },
    { "Gmpc", "gmpc" },
    { "Osdlyrics", "osdlyrics" }
}
qtmenu = {
    { "Qt5 Assistant", "assistant-at5" },
    { "Qt4 Assistant", "assistant-qt4" },
    { "Qt5 Designer", "designer-qt5" },
    { "Qt4 Designer", "designer-qt4" }
}
pamenu = {
    { "PulseAudio Manager", "paman" },
    { "Volume Control", "pavucontrol" },
    { "Volume Meter", "pavumeter" }
}
othermenu = {
    { "Qt", qtmenu },
    { "CMake", "cmake-gui" },
    { "File Cleaner", "bleachbit" },
    { "Manage Printing", "xdg-open http://localhost:631/"},
    { "PulseAudio Control", pamenu },
    { "Passwords and Keys", "seahorse" },
    { "Font Editor", "fontforge" }
}
powermenu = {
    { "Power Off", "poweroff" },
    { "Reboot", "reboot" },
    { "Suspend", "pm-suspend" },
    { "Hibernate", "pm-hibernate" },
    { "Hybrid Suspend", "pm-suspend-hybrid" }
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
                                    { "Multimedia", multimediamenu },
                                    { "Others", othermenu },
                                    { "Terminal", terminalmenu, beautiful.menu_terminal },
                                    { "Power", powermenu }
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
