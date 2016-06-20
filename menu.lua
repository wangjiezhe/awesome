-- menu.lua

local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup.widget")

local app16 = "/usr/share/icons/hicolor/16x16/apps/"
local app32 = "/usr/share/icons/hicolor/32x32/apps/"
local app48 = "/usr/share/icons/hicolor/48x48/apps/"
local pixmaps = "/usr/share/pixmaps/"

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
   { "&Chromium", "chromium", app16 .. "chromium.png" },
   { "&Firefox", "firefox", app16 .. "firefox.png" },
   { "&Yandex Browser", "yandex-browser-beta", app16 .. "yandex-browser-beta.png" },
   { "&Thunderbird", "thunderbird", app16 .. "thunderbird.png" },
   { "&Baidu Cloud", "bcloud-gui", app16 .. "bcloud.png" },
   { "115 Pan", "115pan", pixmaps .. "115pan.png" },
   { "File&zilla", "filezilla", app16 .. "filezilla.png" },
   { "&Pidgin", "pidgin", app16 .. "pidgin.png" },
   { "&WeChat", "electronic-wechat", "/usr/share/electronic-wechat/assets/icon.png" },
   { "&Linphone", "linphone", app48 .. "linphone.png" },
   { "He&xchat", "hexchat", app48 .. "hexchat.png" },
   { "&Slack", "scudcloud", pixmaps .. "scudcloud.png" },
   { "Transmission", "transmission-gtk", app16 .. "transmission.png" },
   { "&MEGASync", "megasync", app16 .. "mega.png" }
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
   { "&Maxiama", "wxmaxima", pixmaps .. "wxmaxima.png" },
   { "GNU &Octave", "octave --force-gui", app16 .. "octave.png" },
   { "Singular", terminal .. " -e Singular" },
   { "&RStudio", "rstudio-bin", app16 .. "rstudio.png" },
   { "FriCAS", terminal .. " -e fricas -nosman" },
   { "Yacas", terminal .. " -e yacas" },
   { "Reduce" , terminal .. " -e redcsl" }
}
latexmenu = {
   { "&Gummi", "gummi", pixmaps .. "gummi.png" },
   { "Tex&Maker", "texmaker", pixmaps .. "texmaker.png" },
   { "TeX&studio", "texstudio", "/usr/share/icons/hicolor/scalable/apps/texstudio.svg" }, -- TODO: Fix for find_icon
   { "&Lyx", "lyx", app48 .. "lyx.png" },
   { "&TeXmacs", "texmacs", pixmaps .. "TeXmacs.xpm" }
}
pythonmenu = {
   { "&PyCharm", "pycharm", pixmaps .. "pycharm.png" },
   { "&Spyder", "spyder", pixmaps .. "spyder.png" },
   { "Spyder (python&3)", "spyder3", pixmaps .. "spyder3.png" },
   { "&Dreampie", "dreampie", pixmaps .. "dreampie.png" }
}
webmenu = {
   { "Blue&fish", "bluefish", app16 .. "bluefish.png" },
   { "Blue&Griffon", "bluegriffon", app16 .. "bluegriffon.png" }
}
wikimenu = {
   { "&Zim", "zim", pixmaps .. "zim.png" },
   { "&WizNote", "WizNote", app16 .."wiznote.png" },
   { "&MediaWiki", "xdg-open http://localhost/mediawiki/" }
}
editormenu = {
   { "G&vim", "gvim", pixmaps .. "gvim.png" },
   { "Emacs", "env LC_CTYPE=zh_CN.UTF8 emacs", app16 .. "emacs.png" },
   { "&LaTeX", latexmenu },
   { "&Python", pythonmenu },
   { "&DrRacket", "drracket", app16 .. "drracket.png" },
   { "&Web", webmenu },
   { "&Eclipse", "eclipse", app16 .. "eclipse.png" },
   { "&IntelliJ IDEA", "intellij-idea-ultimate-edition" },
   { "&Android Studio", "android-studio", pixmaps .. "android-studio.png" },
   { "&PoEdit", "poedit", app16 .. "poedit.png" },
   { "Scribus", "scribus", app32 .. "scribus.png" },
   { "&OmegaT", "omegat", pixmaps .. "omegat.png" },
   { "Wiki & &Note", wikimenu }
}
libreofficemenu = {
   { "&Base", "env LANG=zh_CN.UTF8 lobase", app16 .. "libreoffice-base.png" },
   { "&Writer", "env LANG=zh_CN.UTF8 lowriter", app16 .. "libreoffice-writer.png" },
   { "&Calc", "env LANG=zh_CN.UTF8 localc", app16 .. "libreoffice-calc.png" },
   { "&Impress", "env LANG=zh_CN.UTF8 loimpress", app16 .. "libreoffice-impress.png" },
   { "&Draw", "env LANG=zh_CN.UTF8 lodraw", app16 .. "libreoffice-draw.png" },
   { "&Math", "env LANG=zh_CN.UTF8 lomath", app16 .. "libreoffice-math.png" }
}
wpsmenu = {
   { "&Writer", "wps", app48 .. "wps-office-wpsmain.png" },
   { "&Spreadsheets", "et", app48 .. "wps-office-etmain.png" },
   { "&Presentation", "wpp", app48 .. "wps-office-wppmain.png" }
}
officemenu = {
   { "&LibreOffice", libreofficemenu, app16 .. "libreoffice-main.png" },
   { "&WPS Office", wpsmenu, app16 .. "wps-office-kingsoft.png" }
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
   { "&GIMP", "env LANG=zh_CN.UTF8 gimp" },
   { "&Inkscape", "env LANG=zh_CN.UTF8 inkscape" },
   { "K&rita", "krita" },
   { "&Blender", "blender" },
   { "&Darktable", "optirun darktable" },
   { "Gee&qie", "geeqie" },
   { "g&thumb", "Gthumb" },
   { "&Shotwell", "shotwell" },
   { "G&color2", "gcolor2" }
}
pamenu = {
   { "&PulseAudio Manager", "paman" },
   { "Volume &Control", "pavucontrol" },
   { "Volume &Meter", "pavumeter" }
}
multimediamenu = {
   { "&FeelUOwn", "feeluown" },
   { "K&W Player", "kwplayer" },
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
   { "&Genymotion", "genymotion" },
   -- { "&Astah", "astah" },
   { "&Devhelp", "devhelp" },
   { "Heimdall &Frontend", "heimdall-frontend" }
}
webtoolsmenu = {
   { "Zenmap", "zenmap" },
   { "&Zenmap (as root)", "gksudo zenmap" },
   { "&Wireshark", "wireshark-gtk" },
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
   { "&QQ", "env LANG=zh_CN.utf8 WINEPREFIX=" .. home_path .."QQLite WINEDEBUG=-all wine " .. home_path .. "QQLite/drive_c/'Program Files (x86)'/Tencent/QQLite/Bin/QQ.exe" },
   { "&RHWUD", "WINEPREFIX=" .. home_path .. ".wine WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/Program\\ Files\\ \\(x86\\)/Random\\ House,\\ Inc/Random\\ House\\ Webster\\'s\\ Unabridged\\ Dictionary/RHUD30.EXE" },
   { "&CAJViewer", "env LANG=zh_CN.UTF8 WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/'Program Files (x86)'/TTKN/'CAJViewer 7.2'/CAJVieweru.exe" },
   { "&SsReader", "env LANG=zh_CN.UTF8 WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/'Program Files (x86)'/SSREADER36/SsReader.exe" },
   { "&Bridge", bridgemenu }
}
gamemenu = {
   { "Super&tux2", "supertux2"},
   { "&OpenRA", "openra" },
   { "&mGBA", "mgba-qt" },
   { "&Fceux", "fceux" },
   { "Hi&gan", "higan" },
   { "&Steam", "steam" }
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
   { "Shutdown", "shutdown -P now" },
   { "Power Off", "systemctl poweroff" },
   { "Reboot", "systemctl reboot" },
   { "Suspend", "systemctl suspend" },
   { "Hibernate", "systemctl hibernate" },
   { "Hybrid Sleep", "systemctl hybrid-sleep" }
}
mymainmenu = awful.menu({ items = {
                             { "awesome", myawesomemenu, beautiful.awesome_icon },
                             { "&Network", networkmenu },
                             { "&Files", "pcmanfm", "/usr/share/icons/gnome/16x16/places/gtk-directory.png" },
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
