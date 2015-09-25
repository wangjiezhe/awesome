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
    { "Yandex Browser", "yandex-browser-beta" },
    { "Thunderbird", "thunderbird" },
    { "Baidu Cloud", "bcloud-gui" },
    { "115 Pan", "115pan" },
    { "Filezilla", "filezilla" },
    { "Pidgin", "pidgin" },
    { "Transmission", "transmission-gtk" },
    { "MEGASync", "megasync" }
}
filemenu = {
    { "PCManFM", "pcmanfm" },
    { "Ranger", terminal .. " -e ranger" }
}
maximamenu = {
    { "Maxima", terminal .. " -e maxima" },
    { "Xmaxima", "xmaxima" },
    { "wxMaxima", "wxmaxima" }
}
mathmenu = {
    { "Sage", terminal .. " -e sage" },
    { "Sage(Notebook)", terminal .. " -e sage -notebook" },
    { "GAP", terminal .. " -e gap" },
    { "GP/PARI", terminal .. " -e gp" },
    { "Maxiama", maximamenu },
    { "GNU Octave", "octave --force-gui" },
    { "Singular", terminal .. " -e Singular" },
    { "RStudio", "rstudio-bin" }
}
latexmenu = {
    { "Gummi", "gummi" },
    { "TexMaker", "texmaker" },
    { "TeXstudio", "texstudio" },
    { "TeXmacs", "texmacs" },
    { "Lyx", "lyx" }
}
pythonmenu = {
    { "PyCharm", "pycharm" },
    { "Spyder", "spyder" },
    { "Spyder (python3)", "spyder3"}
}
schememenu = {
    {"GRacket", "gracket" },
    { "DrRacket", "drracket" }
}
webmenu = {
    { "Bluefish", "bluefish" },
    { "BlueGriffon", "bluegriffon" }
}
editormenu = {
    { "Gvim", "gvim" },
    { "Emacs", "emacs" },
    { "LaTeX", latexmenu },
    { "Python", pythonmenu },
    { "Scheme", schememenu },
    { "Web", webmenu },
    { "Eclipse", "eclipse" },
    { "Android Studio", "android-studio" },
    { "PoEdit", "poedit" },
    { "OmegaT", "omegat" }
}
libreofficemenu = {
    { "Base", "lobase" },
    { "Writer", "lowriter" },
    { "Calc", "localc" },
    { "Impress", "loimpress" },
    { "Draw", "lodraw" },
    { "Math", "lomath" }
}
wpsmenu = {
    { "Writer", "wps" },
    { "Spreadsheets", "et" },
    { "Presentation", "wpp" }
}
officemenu = {
    { "LibreOffice", libreofficemenu },
    { "WPS Office", wpsmenu }
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
    { "Geeqie", "geeqie" },
    { "Gcolor2", "gcolor2" }
}
pamenu = {
    { "PulseAudio Manager", "paman" },
    { "Volume Control", "pavucontrol" },
    { "Volume Meter", "pavumeter" }
}
multimediamenu = {
    { "KW Player", "kwplayer" },
    { "PulseAudio Control", pamenu },
    { "Ario", "ario" },
    { "Gmpc", "gmpc" },
    { "Osdlyrics", "osdlyrics" }
}
qtmenu = {
    { "Qt5 Assistant", "assistant-qt5" },
    { "Qt4 Assistant", "assistant-qt4" },
    { "Qt5 Designer", "designer-qt5" },
    { "Qt4 Designer", "designer-qt4" }
}
developmentmenu = {
    { "Qt", qtmenu },
    { "CMake", "cmake-gui" },
    { "Devhelp", "devhelp" },
    { "Astah", "astah" }
}
webtoolsmenu = {
    { "Zenmap", "zenmap" },
    { "Zenmap (as root)", "/usr/share/zenmap/su-to-zenmap.sh" },
    { "Wireshark", "wireshark" }
}
webcammenu = {
    { "Guvcview", "guvcview" },
    { "Cheese", "cheese" }
}
winemenu = {
    { "RHWUD", "" }
}
othermenu = {
    { "Shutter", "shutter" },
    { "VirtualBox", "start-vbox" },
    { "File Cleaner", "bleachbit" },
    { "Manage Printing", "xdg-open http://localhost:631/"},
    { "WebCam", webcammenu },
    { "Bluetooth", "blueman-manager" },
    { "Passwords and Keys", "seahorse" },
    { "Font Editor", "fontforge" },
    { "Hardware Topology", "lstopo" }
}
powermenu = {
    { "Shutdown", "shutdown now" },
    { "Power Off", "systemctl poweroff" },
    { "Reboot", "systemctl reboot" },
    { "Suspend", "systemctl suspend" },
    { "Hibernate", "systemctl hibernate" },
    { "Hybrid Sleep", "systemctl hybrid-sleep" }
}
mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },
                                    -- { "&firefox", "firefox", awful.util.getdir("config") .. "/firefox.png" },
                                    { "Network", networkmenu },
                                    { "Files", filemenu },
                                    { "Math", mathmenu },
                                    { "Editor", editormenu },
                                    { "Office", officemenu },
                                    { "Graphic", graphicmenu },
                                    { "Multimedia", multimediamenu },
                                    { "Development", developmentmenu },
                                    { "Web Tools", webtoolsmenu },
                                    { "Wine", winemenu },
                                    { "Others", othermenu },
                                    { "Terminal", terminalmenu, beautiful.menu_terminal },
                                    { "Power", powermenu }
                                  }
                        })

-- Xdg_menu
-- xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu >~/.config/awesome/archmenu.lua
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
