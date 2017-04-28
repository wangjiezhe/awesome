-- menu.lua

local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup.widget")

local app16 = "/usr/share/icons/hicolor/16x16/apps/"
local app16g = "/usr/share/icons/gnome/16x16/apps/"
local app32 = "/usr/share/icons/hicolor/32x32/apps/"
local app48 = "/usr/share/icons/hicolor/48x48/apps/"
local app64 = "/usr/share/icons/hicolor/64x64/apps/"
local app128 = "/usr/share/icons/hicolor/128x128/apps/"
local app256 = "/usr/share/icons/hicolor/256x256/apps/"
local app512 = "/usr/share/icons/hicolor/512x512/apps/"
local apps = "/usr/share/icons/hicolor/scalable/apps/"
local dev16g = "/usr/share/icons/gnome/16x16/devices/"
local act16g = "/usr/share/icons/gnome/16x16/actions/"
local mime16 = "/usr/share/icons/hicolor/16x16/mimetypes/"
local pixmaps = "/usr/share/pixmaps/"

-- FreeDesktop
-- require('freedesktop.utils')
-- require('freedesktop.menu')
-- freedesktop.utils.icon_theme = 'gnome'
-- menu_items = freedesktop.menu.new()
-- myawesomemenu = {
--     { "manual", terminal .. " -e man awesome", freedesktop.utils.lookup_icon({ icon = 'system-help' }) },
--     { "edit config", editor_cmd .. " " .. awesome.conffile, freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
--     { "restart", awesome.restart, freedesktop.utils.lookup_icon({ icon = 'system-shutdown' }) },
--     { "quit", fuction() awesome.quit() end, freedesktop.utils.lookup_icon({ icon = 'system-shutdown' }) }
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
   { "quit", function() awesome.quit() end },
}
networkmenu = {
   -- { "&Chromium", "chromium", app16 .. "chromium.png" },
   { "&Chromium Dev", "chromium-dev", app16 .. "chromium-dev.png" },
   { "&Firefox", "firefox", app16 .. "firefox.png" },
   { "&Yandex Browser", "yandex-browser-beta", app16 .. "yandex-browser-beta.png" },
   { "&Thunderbird", "thunderbird", app16 .. "thunderbird.png" },
   { "&Baidu Cloud", "bcloud-gui", app16 .. "bcloud.png" },
   { "115 Pan", "115pan", pixmaps .. "115pan.png" },
   { "File&zilla", "filezilla", app16 .. "filezilla.png" },
   { "&Pidgin", "pidgin", app16 .. "pidgin.png" },
   { "&WeChat", "electronic-wechat", "/usr/share/electronic-wechat/assets/icon.png" },
   { "&Linphone", "linphone", app48 .. "linphone.png" },
   { "&Ekiga Softphone", "ekiga", app16 .. "ekiga.png" },
   { "He&xchat", "hexchat", app48 .. "hexchat.png" },
   { "&ScudCloud", "scudcloud", pixmaps .. "scudcloud.png" },
   { "Sl&ack", "slack", pixmaps .. "slack.png" },
   { "&Rocket.Chat+", "/opt/Rocket.Chat+/rocketchat", app512 .. "rocketchat.png" },
   { "Tra&nsmission", "transmission-gtk", app16 .. "transmission.png" },
   { "&MEGASync", "megasync", app16 .. "mega.png" },
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
   { "GAP", terminal .. " -e gap" },
   { "GP/PARI", terminal .. " -e gp" },
   { "CoCoA", terminal .. " -e cocoa5" },
   { "&Maxiama", "wxmaxima", pixmaps .. "wxmaxima.png" },
   { "M&atlab", "optirun matlab -desktop", pixmaps .. "matlab.png" },
   { "Ma&thematica", "optirun Mathematica", app32 .. "wolfram-mathematica.png" },
   { "Ma&ple", "optirun xmaple", "/opt/maple2016/bin/Maple2016.png" },
   { "GNU &Octave", "octave --force-gui", app16 .. "octave.png" },
   { "Singular", terminal .. " -e Singular" },
   { "&RStudio", "rstudio-bin", app16 .. "rstudio.png" },
   { "FriCAS", terminal .. " -e fricas -nosman" },
   { "Yacas", terminal .. " -e yacas" },
   { "&Qreduce", "qreduce", "/usr/share/qreduce/Bumblebee.png" },
   { "JG&EX", "jgex", "/opt/jgex0_80/gexicon.gif" },
   { "&GeoGebra", "geogebra", apps .. "geogebra.svg" },
   { "&CoqIde", "coqide", "/usr/share/coq/coq.png" },
}
latexmenu = {
   { "&Gummi", "gummi", pixmaps .. "gummi.png" },
   { "TeX&works", "texworks", pixmaps .. "TeXworks.png" },
   { "Tex&Maker", "texmaker", pixmaps .. "texmaker.png" },
   { "TeX&studio", "texstudio", app16 .. "texstudio.png" },
   { "&Lyx", "lyx", app48 .. "lyx.png" },
   { "&TeXmacs", "texmacs", pixmaps .. "TeXmacs.xpm" },
}
pythonmenu = {
   { "&PyCharm", "pycharm", pixmaps .. "pycharm.png" },
   { "&Spyder", "spyder", pixmaps .. "spyder.png" },
   { "Spyder (python&3)", "spyder3", pixmaps .. "spyder3.png" },
   { "&Dreampie", "dreampie", pixmaps .. "dreampie.png" },
}
webmenu = {
   { "Blue&fish", "bluefish", app16 .. "bluefish.png" },
   { "Blue&Griffon", "bluegriffon", app16 .. "bluegriffon.png" },
}
wikimenu = {
   { "&Zim", "zim", pixmaps .. "zim.png" },
   { "&WizNote", "WizNote", app16 .."wiznote.png" },
   { "&MediaWiki", "xdg-open http://localhost/mediawiki/" },
}
markdownmenu = {
   { "&Retext", "retext", app16 .. "retext.png" },
   { "&Marp", "marp", pixmaps .. "marp.png" },
}
pdfmenu = {
   { "Master PDF Editor", "masterpdfeditor4", "/opt/master-pdf-editor-4/masterpdfeditor4.png" },
   { "  PDF Editor", "pdfedit", "/usr/share/pdfedit/icon/pdfedit_logo.png" },
   { "Crop PDF files", "krop", act16g .. "edit-cut.png" },
   { "PDFsam", "pdfsam", pixmaps .. "pdfsam.png" },
}
editormenu = {
   { "Atom", "atom", app16 .. "atom.png" },
   { "G&vim", "gvim", app48 .. "gvim.png" },
   { "Emacs", "env LC_CTYPE=zh_CN.UTF8 emacs", app16 .. "emacs.png" },
   { "&LaTeX", latexmenu },
   { "PD&F", pdfmenu },
   { "&GVEdit", "gvedit" },
   { "&Markdown", markdownmenu },
   { "&Python", pythonmenu },
   { "Dr&Racket", "drracket", app16 .. "drracket.png" },
   { "&Web", webmenu },
   { "&CLion", "clion", pixmaps .. "clion.svg" },
   { "&Eclipse", "eclipse", app16 .. "eclipse.png" },
   { "&IntelliJ IDEA", "intellij-idea-ultimate-edition", pixmaps .. "intellij-idea-ultimate-edition.png" },
   { "&Android Studio", "android-studio", pixmaps .. "android-studio.png" },
   { "&QtCreator", "qtcreator", app16 .. "QtProject-qtcreator.png" },
   { "Li&teIDE", "liteide", pixmaps .. "liteide.png" },
   { "PoE&dit", "poedit", app16 .. "poedit.png" },
   { "Scribus", "scribus", app32 .. "scribus.png" },
   { "&OmegaT", "omegat", pixmaps .. "omegat.svg" },
   { "Wiki & &Note", wikimenu },
}
libreofficemenu = {
   { "&Base", "env LANG=zh_CN.UTF8 lobase", app16 .. "libreoffice-base.png" },
   { "&Writer", "env LANG=zh_CN.UTF8 lowriter", app16 .. "libreoffice-writer.png" },
   { "&Calc", "env LANG=zh_CN.UTF8 localc", app16 .. "libreoffice-calc.png" },
   { "&Impress", "env LANG=zh_CN.UTF8 loimpress", app16 .. "libreoffice-impress.png" },
   { "&Draw", "env LANG=zh_CN.UTF8 lodraw", app16 .. "libreoffice-draw.png" },
   { "&Math", "env LANG=zh_CN.UTF8 lomath", app16 .. "libreoffice-math.png" },
}
wpsmenu = {
   { "&Writer", "wps", app48 .. "wps-office-wpsmain.png" },
   { "&Spreadsheets", "et", app48 .. "wps-office-etmain.png" },
   { "&Presentation", "wpp", app48 .. "wps-office-wppmain.png" },
}
officemenu = {
   { "&LibreOffice", libreofficemenu, app16 .. "libreoffice-main.png" },
   { "&WPS Office", wpsmenu, app16 .. "wps-office-kingsoft.png" },
   { "&Evince", "evince", app16 .. "evince.png" },
   { "Calibre", "calibre --detach", app16 .. "calibre-gui.png" },
   { "Ok&ular", "okular", app16 .. "okular.png" },
   { "&GnuCash", "gnucash", app16 .. "gnucash-icon.png"},
   { "&FBReader", "FBReader", pixmaps .. "FBReader.png" },
   { "Kee&PassXC", "keepassxc", app16 .. "keepassxc.png"},
   { "&Zotero", "zotero", app16 .. "zotero.png" },
   { "&Mendeley Desktop", "mendeleydesktop", app16 .. "mendeleydesktop.png" },
}
terminalmenu = {
   { "&URxvt", "urxvt", app16g .. "terminal.png" },
   { "Xterm", "xterm", pixmaps .. "xterm-color_48x48.xpm" },
   { "UXterm", "uxterm", pixmaps .. "xterm-color_48x48.xpm" },
   { "&Roxterm", "roxterm", apps .. "roxterm.svg" },
   { "&Lxterminal", "lxterminal", app128 .. "lxterminal.png" },
   { "Termini&x", "terminix", app16 .. "com.gexperts.Terminix.png" },
   { "&Terminator", "terminator", app16 .. "terminator.png" },
}
colormenu = {
   { "G&color2", "gcolor2", pixmaps .. "gcolor2/icon.png" },
   { "G&pick", "gpick", app48 .. "gpick.png"}
}
graphicmenu = {
   { "&GIMP", "env LANG=zh_CN.UTF8 optirun gimp", app16 .. "gimp.png" },
   { "&Inkscape", "optirun inkscape", app16 .. "inkscape.png" },
   { "K&rita", "optirun krita", app16 .. "calligrakrita.png" },
   { "&Blender", "optirun blender", app16 .. "blender.png" },
   { "&OBS", "optirun obs", app256 .. "obs.png" },
   { "&FreeCAD", "optirun freecad", app16 .. "freecad.png" },
   { "&OpenSCAD", "optirun openscad", pixmaps .. "openscad.png" },
   { "&Darktable", "optirun darktable", app16 .. "darktable.png" },
   { "Gee&qie", "geeqie", pixmaps .. "geeqie.png" },
   { "g&thumb", "Gthumb", app16 .. "gthumb.png" },
   { "&Shotwell", "shotwell", app16 .. "shotwell.png" },
   { "&Color", colormenu },
}
pamenu = {
   { "&PulseAudio Manager", "paman", dev16g .. "audio-card.png" },
   { "Volume &Control", "pavucontrol", app16g .. "multimedia-volume-control.png" },
   { "Volume &Meter", "pavumeter", dev16g .."audio-input-microphone.png" },
}
multimediamenu = {
   { "&FeelUOwn", "feeluown", pixmaps .. "feeluown.png" },
   { "&NetEase Cloud Music", "netease-cloud-music", apps .. "netease-cloud-music.svg" },
   { "K&W Player", "kwplayer", app16 .. "kwplayer.png" },
   { "&PulseAudio Control", pamenu },
   { "&Ario", "ario", app16 .. "ario.png" },
   { "&Gmpc", "gmpc", app16 .. "gmpc.png" },
   { "&Lollypop", "lollypop", app16 .. "org.gnome.Lollypop.png" },
   { "&Osdlyrics", "osdlyrics", app64 .. "osdlyrics.png" },
   { "Len&mus" , "lenmus", pixmaps .. "lenmus.png" },
   { "Kid3", "kid3-qt", app16 .. "kid3-qt.png" },
   { "Audacity", "audacity", app16 .. "audacity.png" },
}
qtmenu = {
   { "Qt5 &Assistant", "assistant-qt5", app32 .. "assistant.png" },
   { "Qt4 Assistant", "assistant-qt4", app32 .. "assistant-qt4.png" },
   { "Qt5 &Designer", "designer-qt5", app128 .. "QtProject-designer.png" },
   { "Qt4 Designer", "designer-qt4", app128 .. "designer-qt4.png" },
}
sqlmenu = {
   { "&Sqliteman", "sqliteman", "/usr/share/icons/hicolor/sqliteman.png" },
   { "&Navicat", "navicat", "/opt/navicat/Navicat/help/img/icon_navicat.png" },
}
developmentmenu = {
   { "&Qt", qtmenu },
   { "&Sql", sqlmenu },
   { "&CMake", "cmake-gui", app32 .. "CMakeSetup.png" },
   { "&Genymotion", "genymotion", "/opt/genymotion/icons/icon.png" },
   -- { "&Astah", "astah" },
   { "&Devhelp", "devhelp", app16 .. "devhelp.png" },
   { "Heimdall &Frontend", "heimdall-frontend", pixmaps .. "heimdall.png" },
   { "&BeanShell", "/usr/lib/jvm/java-7-openjdk/bin/java -jar /usr/share/java/bsh.jar" },
   { "H&opper Disassembler v4", "/opt/hopper-v4/bin/hopper-launcher.sh", app16 .. "hopper-disassembler-v4.png" },
   { "&IDA Demo", "/opt/ida-demo/idaq", app64 .. "ida.png" },
}
webtoolsmenu = {
   { "Zenmap", "zenmap", "/usr/share/zenmap/pixmaps/zenmap.png" },
   { "&Zenmap (as root)", "gksudo zenmap", "/usr/share/zenmap/pixmaps/zenmap.png" },
   { "&Wireshark", "wireshark-gtk", app16 .. "wireshark.png" },
   { "&Burp Suite", "burpsuite", pixmaps .. "burpsuite.png" },
   { "Charles", "charles", app16 .. "charles.png" },
}
webcammenu = {
   { "&Guvcview", "guvcview", pixmaps .. "guvcview/guvcview.png" },
   { "&Cheese", "cheese", app16 .. "org.gnome.Cheese.png" },
}
bridgemenu = {
   { "&Bridge Master 2000", "dex " .. home_path .. ".local/share/applications/'Bridge Master 2000.desktop'" },
   { "&Learn to Play Bridge", "dex " .. home_path .. ".local/share/applications/wine/Programs/'Bridge Base Inc'/'Learn to Play Bridge.desktop'" },
}
winemenu = {
   { "&QQ", "env LANG=zh_CN.utf8 WINEPREFIX=" .. home_path .."QQLite WINEDEBUG=-all wine " .. home_path .. "QQLite/drive_c/'Program Files (x86)'/Tencent/QQLite/Bin/QQ.exe", app16 .. "im-qq.png" },
   { "&RHWUD", "env WINEPREFIX=" .. home_path .. ".wine WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/Program\\ Files\\ \\(x86\\)/Random\\ House,\\ Inc/Random\\ House\\ Webster\\'s\\ Unabridged\\ Dictionary/RHUD30.EXE" },
   { "&CAJViewer", "env LANG=zh_CN.UTF8 WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/'Program Files (x86)'/TTKN/'CAJViewer 7.2'/CAJVieweru.exe" },
   { "&SsReader", "env LANG=zh_CN.UTF8 WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/'Program Files (x86)'/SSREADER36/SsReader.exe" },
   { "&Bridge", bridgemenu },
}
gamemenu = {
   { "Super&tux2", "optirun supertux2", pixmaps .. "supertux.png"},
   { "&OpenRA", "optirun openra", app16 .. "openra.png" },
   { "&mGBA", "mgba-qt", app16 .. "mgba.png" },
   { "&Fceux", "fceux", pixmaps .. "fceux.png" },
   { "Hi&gan", "higan", pixmaps .. "higan.png" },
   { "&Steam", "optirun steam", app16 .. "steam.png" },
}
othermenu = {
   { "Shutter", "shutter", app16 .. "shutter.png" },
   { "&VirtualBox", "virtualbox", mime16 .. "virtualbox.png" },
   { "File &Cleaner", "bleachbit", pixmaps .. "bleachbit.png" },
   { "Manage &Printing", "xdg-open http://localhost:631/", app16 .. "cups.png" },
   { "&WebCam", webcammenu },
   { "&Bluetooth", "blueman-manager", app16 .. "blueman.png" },
   { "&Passwords and Keys", "seahorse", app16 .. "seahorse.png" },
   { "&Font Editor", "fontforge", app16 .. "fontforge.png" },
   { "Hardware Topology", "lstopo" },
   { "&Stellarium", "stellarium", app16 .. "stellarium.png" },
}
powermenu = {
   { "Shutdown", "shutdown -P now" },
   { "Power Off", "systemctl poweroff" },
   { "Reboot", "systemctl reboot" },
   { "Suspend", "systemctl suspend" },
   { "Hibernate", "systemctl hibernate" },
   { "Hybrid Sleep", "systemctl hybrid-sleep" },
}
mymainmenu = awful.menu({ items = {
                             { "awesome", myawesomemenu, beautiful.awesome_icon },
                             { "&Network", networkmenu },
                             { "&Files", "pcmanfm", "/usr/share/icons/gnome/16x16/places/gtk-directory.png" },
                             { "M&ath", mathmenu },
                             { "&Editor", editormenu },
                             { "&Office", officemenu },
                             { "G&raphic", graphicmenu },
                             { "&Multimedia", multimediamenu },
                             { "&Development", developmentmenu },
                             { "We&b Tools", webtoolsmenu },
                             { "&Wine", winemenu },
                             { "&Games", gamemenu },
                             { "Other&s", othermenu },
                             { "&Terminal", terminalmenu },
                             { "Power", powermenu },
                             }})

-- Xdg_menu
-- xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu | awk -F, '{if (a!=$1) print $a; a=$1}' >~/.config/awesome/archmenu.lua
-- xdg_menu = require("archmenu")
-- myawesomemenu = {
--     { "manual", terminal .. " -e man awesome" },
--     { "edit config", editor_cmd .. " " .. awesome.conffile },
--     { "restart", awesome.restart },
--     { "quit", function() awesome.quit() end }
-- }
-- mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
--                                     { "Applications", xdgmenu },
--                                     { "open terminal", terminal }
--                                   }
--                         })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
