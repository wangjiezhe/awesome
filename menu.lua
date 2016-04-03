-- menu.lua

local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup.widget")

-- local hotkeys_vim = require("awful.hotkeys_popup.keys.vim")

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
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}
networkmenu = {
   { "&Chromium", "chromium" },
   { "&Firefox", "firefox" },
   { "&Yandex Browser", "yandex-browser-beta" },
   { "&Thunderbird", "thunderbird" },
   { "&Baidu Cloud", "bcloud-gui" },
   { "115 Pan", "115pan" },
   { "File&zilla", "filezilla" },
   { "&Pidgin", "pidgin" },
   { "&WeChat", "electronic-wechat" },
   { "&Linphone", "linphone" },
   { "Transmission", "transmission-gtk" },
   { "&MEGASync", "megasync" }
}
-- filemenu = {
--    { "&PCManFM", "pcmanfm" },
--    { "Ranger", terminal .. " -e ranger" }
-- }
-- maximamenu = {
--    { "Maxima", terminal .. " -e maxima" },
--    { "Xmaxima", "xmaxima" },
--    { "wxMaxima", "wxmaxima" }
-- }
mathmenu = {
   { "Sage", terminal .. " -e sage" },
   { "Sage(Notebook)", terminal .. " -e sage -notebook" },
   { "GAP", terminal .. " -e gap" },
   { "GP/PARI", terminal .. " -e gp" },
   { "&Maxiama", "wxmaxima" },
   { "GNU &Octave", "octave --force-gui" },
   { "Singular", terminal .. " -e Singular" },
   { "&RStudio", "rstudio-bin" },
   { "FriCAS", terminal .. " -e fricas -nosman" },
   { "Yacas", terminal .. " -e yacas" },
   { "Reduce" , terminal .. " -e redcsl" }
}
latexmenu = {
   { "&Gummi", "gummi" },
   { "Tex&Maker", "texmaker" },
   { "TeX&studio", "texstudio" },
   { "&Lyx", "lyx" },
   { "&TeXmacs", "texmacs" }
}
pythonmenu = {
   { "&PyCharm", "pycharm" },
   { "&Spyder", "spyder" },
   { "Spyder (python&3)", "spyder3"},
   { "&Dreampie", "dreampie" }
}
schememenu = {
   { "&GRacket", "gracket" },
   { "&DrRacket", "drracket" }
}
webmenu = {
   { "Blue&fish", "bluefish" },
   { "Blue&Griffon", "bluegriffon" }
}
wikimenu = {
   { "&Zim", "zim" },
   { "&WizNote", "WizNote" },
   { "&MediaWiki", "xdg-open http://localhost/mediawiki/" }
}
editormenu = {
   { "G&vim", "gvim" },
   { "Emacs", "emacs" },
   { "Emacs (client)", "emacsclient -c" },
   { "&LaTeX", latexmenu },
   { "&Python", pythonmenu },
   { "&Scheme", schememenu },
   { "&Web", webmenu },
   { "&Eclipse", "eclipse" },
   { "&Android Studio", "android-studio" },
   { "&PoEdit", "poedit" },
   { "Scribus", "scribus" },
   { "&OmegaT", "omegat" },
   { "&Wiki & Note", wikimenu }
}
libreofficemenu = {
   { "&Base", "lobase" },
   { "&Writer", "lowriter" },
   { "&Calc", "localc" },
   { "&Impress", "loimpress" },
   { "&Draw", "lodraw" },
   { "&Math", "lomath" }
}
wpsmenu = {
   { "&Writer", "wps" },
   { "&Spreadsheets", "et" },
   { "&Presentation", "wpp" }
}
officemenu = {
   { "&LibreOffice", libreofficemenu },
   { "&WPS Office", wpsmenu }
}
terminalmenu = {
   { "URxvt", "urxvt" },
   { "URxvt(client)", "urxvtc" },
   { "URxvt(tabbed)", "urxvt-tabbed" },
   { "Xterm", "xterm" },
   { "UXterm", "uxterm" },
   { "Roxterm", "roxterm" },
   { "Lxterminal", "lxterminal" }
}
graphicmenu = {
   { "&GIMP", "gimp" },
   { "&Inkscape", "inkscape" },
   { "Gee&qie", "geeqie" },
   { "Gcolor2", "gcolor2" }
}
pamenu = {
   { "&PulseAudio Manager", "paman" },
   { "Volume &Control", "pavucontrol" },
   { "Volume &Meter", "pavumeter" }
}
multimediamenu = {
   { "&FeelUOwn", "FeelUOwn" },
   { "&KW Player", "kwplayer" },
   { "&PulseAudio Control", pamenu },
   { "&Ario", "ario" },
   { "&Gmpc", "gmpc" },
   { "&Osdlyrics", "osdlyrics" },
   { "&Lenmus" , "lenmus" }
}
qtmenu = {
   { "Qt5 &Assistant", "assistant-qt5" },
   { "Qt4 Assistant", "assistant-qt4" },
   { "Qt5 &Designer", "designer-qt5" },
   { "Qt4 Designer", "designer-qt4" }
}
developmentmenu = {
   { "&Qt", qtmenu },
   { "&CMake", "cmake-gui" },
   -- { "&Astah", "astah" },
   { "&Devhelp", "devhelp" },
   { "Heimdall &Frontend", "heimdall-frontend" }
}
webtoolsmenu = {
   { "Zenmap", "zenmap" },
   { "&Zenmap (as root)", "gksudo zenmap" },
   { "&Wireshark", "wireshark" },
   { "&Burp Suite", "burpsuite" }
}
webcammenu = {
   { "&Guvcview", "guvcview" },
   { "&Cheese", "cheese" }
}
bridgemenu = {
   { "&Bridge Master 2000", "dex " .. home_path .. ".local/share/applications/'Bridge Master 2000.desktop'" },
   { "&Learn to Play Bridge", "dex " .. home_path .. ".local/share/applications/wine/Programs/'Bridge Base Inc'/'Learn to Play Bridge.desktop'" }
}
winemenu = {
   { "&QQ", "env LC_ALL=zh_CN.utf8 WINEPREFIX=" .. home_path .."QQLite WINEDEBUG=-all wine " .. home_path .. "QQLite/drive_c/'Program Files (x86)'/Tencent/QQLite/Bin/QQ.exe" },
   { "&RHWUD", "env LC_ALL=en_us.utf8 WINEPREFIX=" .. home_path .. ".wine WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/Program\\ Files\\ \\(x86\\)/Random\\ House,\\ Inc/Random\\ House\\ Webster\\'s\\ Unabridged\\ Dictionary/RHUD30.EXE" },
   { "&CAJViewer", "env LC_ALL=zh_CN.utf8 WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/'Program Files (x86)'/TTKN/'CAJViewer 7.2'/CAJVieweru.exe" },
   { "&SsReader", "env LC_ALL=zh_CN.utf8 WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/'Program Files (x86)'/SSREADER36/SsReader.exe" },
   { "&Bridge", bridgemenu }
}
gamemenu = {
   {"Super&tux2", "supertux2"},
   {"&mGBA", "mgba-qt" },
   {"&Steam", "steam" }
}
othermenu = {
   { "Shutter", "shutter" },
   { "&VirtualBox", "start-vbox" },
   { "File &Cleaner", "bleachbit" },
   { "Manage &Printing", "xdg-open http://localhost:631/"},
   { "&WebCam", webcammenu },
   { "&Bluetooth", "blueman-manager" },
   { "&Passwords and Keys", "seahorse" },
   { "&Font Editor", "fontforge" },
   { "Hardware Topology", "lstopo" },
   { "&Stellarium", "stellarium" }
}
powermenu = {
   { "Shutdown", "shutdown now" },
   { "Power Off", "systemctl poweroff" },
   { "Reboot", "systemctl reboot" },
   { "Suspend", "systemctl suspend" },
   { "Hibernate", "systemctl hibernate" },
   { "Hybrid Sleep", "systemctl hybrid-sleep" }
}
mymainmenu = awful.menu({ items = {
                             { "awesome", myawesomemenu, beautiful.awesome_icon },
                             { "&Network", networkmenu },
                             { "&Files", "pcmanfm" },
                             { "M&ath", mathmenu },
                             { "&Editor", editormenu },
                             { "&Office", officemenu },
                             { "&Image", graphicmenu },
                             { "&Multimedia", multimediamenu },
                             { "&Development", developmentmenu },
                             { "Web &Tools", webtoolsmenu },
                             { "&Wine", winemenu },
                             { "&Games", gamemenu },
                             { "Other&s", othermenu },
                             { "Terminal", terminalmenu, beautiful.menu_terminal },
                             { "Power", powermenu }
                             }})

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

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
