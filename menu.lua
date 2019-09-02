-- menu.lua

local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup.widget")

local app16 = "/usr/share/icons/hicolor/16x16/apps/"
local app32 = "/usr/share/icons/hicolor/32x32/apps/"
local app48 = "/usr/share/icons/hicolor/48x48/apps/"
local app64 = "/usr/share/icons/hicolor/64x64/apps/"
local app128 = "/usr/share/icons/hicolor/128x128/apps/"
local app256 = "/usr/share/icons/hicolor/256x256/apps/"
local app512 = "/usr/share/icons/hicolor/512x512/apps/"
local apps = "/usr/share/icons/hicolor/scalable/apps/"
local app48g = "/usr/share/icons/gnome/48x48/apps/"
local dev48g = "/usr/share/icons/gnome/48x48/devices/"
local act48g = "/usr/share/icons/gnome/48x48/actions/"
local mime48 = "/usr/share/icons/hicolor/48x48/mimetypes/"
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
   { "&Google Chrome", "google-chrome-stable", app48 .. "google-chrome.png" },
   { "&Chromium", "chromium", app48 .. "chromium.png" },
   { "Chromium &Dev", "chromium-dev", app48 .. "chromium-dev.png" },
   { "&Firefox", "firefox", app48 .. "firefox.png" },
   { "Firef&ox Developer", "firefox-developer-edition", app48 .. "firefox-developer-edition.png" },
   { "&Vivaldi", "vivaldi-stable", app48 .. "vivaldi.png" },
   { "&Yandex Browser", "yandex-browser-beta", app48 .. "yandex-browser-beta.png" },
   { "&Qutebrowser (webkit)", "qutebrowser --backend webkit", app48 .. "qutebrowser.png" },
   { "Q&utebrowser (webengine)", "qutebrowser --backend webengine" , app48 .. "qutebrowser.png" },
   { "&Thunderbird", "thunderbird", app48 .. "thunderbird.png" },
   { "&Baidu Cloud", "bcloud-gui", app48 .. "bcloud.png" },
   { "115 Pan", "115pan", pixmaps .. "115pan.png" },
   { "File&zilla", "filezilla", app48 .. "filezilla.png" },
   { "&Pidgin", "pidgin", app48 .. "pidgin.png" },
   { "Telegram", "telegram-desktop", app48 .. "telegram.png" },
   { "Electron &WeChat", "electronic-wechat", app48 .. "electronic-wechat.png" },
   { "&Linphone", "linphone", app48 .. "linphone.png" },
   { "&Ekiga Softphone", "ekiga", app48 .. "ekiga.png" },
   { "He&xchat", "hexchat", app48 .. "hexchat.png" },
   { "&ScudCloud", "scudcloud", pixmaps .. "scudcloud.png" },
   { "Sl&ack", "slack", pixmaps .. "slack.png" },
   { "&Rocket.Chat+", "rocketchat-desktop", app512 .. "rocketchat-desktop.png" },
   { "Tra&nsmission", "transmission-gtk", app48 .. "transmission.png" },
   { "&MEGASync", "megasync", app48 .. "mega.png" },
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
   { "&Sage", terminal .. " -e sage" },
   { "GAP", terminal .. " -e gap" },
   { "GP/PAR&I", terminal .. " -e gp" },
   { "CoCoA", terminal .. " -e cocoa5" },
   { "&Maxiama", "wxmaxima", pixmaps .. "io.github.wxmaxima_developers.wxMaxima.png" },
   -- { "M&atlab", "matlab -desktop", pixmaps .. "matlab.png" },
   -- { "Ma&thematica", "Mathematica", app64 .. "wolfram-mathematica.png" },
   { "Ma&ple", "xmaple", "/opt/maple2016/bin/Maple2016.png" },
   { "GNU &Octave", "octave --force-gui", app48 .. "octave.png" },
   { "Singular", terminal .. " -e Singular" },
   { "&RStudio", "rstudio-bin", app48 .. "rstudio.png" },
   { "FriCAS", terminal .. " -e fricas -nosman" },
   { "&Yacas", "yacas-gui", pixmaps .. "yacas-gui.png" },
   { "&Qreduce", "qreduce", "/usr/share/qreduce/Bumblebee.png" },
   { "JG&EX", "jgex", "/opt/jgex0_80/gexicon.gif" },
   { "&GeoGebra", "geogebra", apps .. "geogebra.svg" },
   { "&CoqIde", "coqide", "/usr/share/coq/coq.png" },
}
latexmenu = {
   { "&Gummi", "gummi", pixmaps .. "gummi.png" },
   { "TeX&works", "texworks", pixmaps .. "TeXworks.png" },
   { "Tex&Maker", "texmaker", pixmaps .. "texmaker.png" },
   { "TeX&studio", "texstudio", app48 .. "texstudio.png" },
   { "&Lyx", "lyx", app48 .. "lyx.png" },
   { "&TeXmacs", "texmacs", pixmaps .. "TeXmacs.xpm" },
}
pythonmenu = {
   { "&PyCharm", "pycharm", pixmaps .. "pycharm.png" },
   { "Spyder2", "spyder2", apps .. "spyder2.svg" },
   { "&Spyder3", "spyder3", apps .. "spyder3.svg" },
   { "&Dreampie", "dreampie", pixmaps .. "dreampie.png" },
}
webmenu = {
   { "&WebStorm", "webstorm", pixmaps .. "webstorm.svg" },
   { "Blue&fish", "bluefish", app48 .. "bluefish.png" },
   { "Blue&Griffon", "bluegriffon", app48 .. "bluegriffon.png" },
}
wikimenu = {
   { "&Zim", "zim", pixmaps .. "zim.png" },
   { "&WizNote", "WizNote", app48 .."wiznote.png" },
   { "&MediaWiki", "xdg-open http://localhost/mediawiki/" },
}
markdownmenu = {
   { "&Typora", "typora", app64 .. "typora.png" },
   { "&Retext", "retext", app48 .. "retext.png" },
   { "&Marp", "marp", pixmaps .. "marp.png" },
}
pdfmenu = {
   { "Master PDF Editor", "masterpdfeditor5", "/opt/master-pdf-editor-5/masterpdfeditor5.png" },
   { "   PDF Editor", "pdfedit", "/usr/share/pdfedit/icon/pdfedit_logo.png" },
   { "Crop PDF files", "krop", act48g .. "edit-cut.png" },
   { "PDFsam", "pdfsam", pixmaps .. "pdfsam.png" },
}
editormenu = {
   { "Atom", "atom", app48 .. "atom.png" },
   { "G&vim", "gvim", app48 .. "gvim.png" },
   { "&Emacs", "env LC_CTYPE=zh_CN.UTF8 emacs", app48 .. "emacs.png" },
   { "&LaTeX", latexmenu },
   { "PD&F", pdfmenu },
   { "&GVEdit", "gvedit" },
   { "&Markdown", markdownmenu },
   { "&Python", pythonmenu },
   { "Dr&Racket", "drracket", app48 .. "drracket.png" },
   { "&Web", webmenu },
   { "&CLion", "clion", pixmaps .. "clion.svg" },
   { "Anjuta", "anjuta", app48 .. "anjuta.png" },
   { "Eclip&se", "eclipse", app48 .. "eclipse.png" },
   { "&IntelliJ IDEA", "intellij-idea-ultimate-edition", pixmaps .. "intellij-idea-ultimate-edition.png" },
   { "&Android Studio", "android-studio", pixmaps .. "android-studio.png" },
   { "&QtCreator", "qtcreator", app48 .. "QtProject-qtcreator.png" },
   { "Li&teIDE", "liteide", pixmaps .. "liteide.png" },
   { "PoE&dit", "poedit", app48 .. "poedit.png" },
   { "Scribus", "scribus", app32 .. "scribus.png" },
   { "&OmegaT", "omegat", pixmaps .. "omegat.svg" },
   { "Wiki & &Note", wikimenu },
}
libreofficemenu = {
   { "&Base", "lobase", app48 .. "libreoffice-base.png" },
   { "&Writer", "lowriter", app48 .. "libreoffice-writer.png" },
   { "&Calc", "localc", app48 .. "libreoffice-calc.png" },
   { "&Impress", "loimpress", app48 .. "libreoffice-impress.png" },
   { "&Draw", "lodraw", app48 .. "libreoffice-draw.png" },
   { "&Math", "lomath", app48 .. "libreoffice-math.png" },
}
wpsmenu = {
   { "WPS &Writer", "wps", app48 .. "wps-office2019-wpsmain.png" },
   { "WPS &Spreadsheets", "et", app48 .. "wps-office2019-etmain.png" },
   { "WPS &Presentation", "wpp", app48 .. "wps-office2019-wppmain.png" },
   { "Kingsoft PDF &Reader", "wpspdf", app48 .. "wps-office2019-pdfmain.png" },
}
officemenu = {
   { "&LibreOffice", libreofficemenu, app48 .. "libreoffice-main.png" },
   { "&WPS Office", wpsmenu, app32 .. "wps-office-kingsoft.png" },
   { "&Evince", "evince", apps .. "org.gnome.Evince.svg" },
   { "Calibre", "calibre --detach", app48 .. "calibre-gui.png" },
   { "Ok&ular", "okular", app48 .. "okular.png" },
   { "&GnuCash", "gnucash", app48 .. "gnucash-icon.png" },
   { "&FBReader", "FBReader", pixmaps .. "FBReader.png" },
   { "&XMind", "XMind", pixmaps .. "xmind.png" },
   { "&MindMaster", "mindmaster", "/usr/share/icons/mindmaster.png" },
   { "Kee&PassXC", "keepassxc", app48 .. "keepassxc.png"},
   { "&Zotero", "zotero", app48 .. "zotero.png" },
   { "Mendeley &Desktop", "mendeleydesktop", app48 .. "mendeleydesktop.png" },
}
terminalmenu = {
   { "&URxvt", "urxvt", app48g .. "terminal.png" },
   { "Xterm", "xterm", pixmaps .. "xterm-color_48x48.xpm" },
   { "UXterm", "uxterm", pixmaps .. "xterm-color_48x48.xpm" },
   { "&Gnome Terminal", "gnome-terminal", app48g .. "gnome-terminal.png" },
   { "&Roxterm", "roxterm", apps .. "roxterm.svg" },
   { "&Lxterminal", "lxterminal", app128 .. "lxterminal.png" },
   { "Tili&x", "tilix", app48 .. "com.gexperts.Tilix.png" },
   { "&Terminator", "terminator", app48 .. "terminator.png" },
   { "&Cool Retro Term", "cool-retro-term", app64 .. "cool-retro-term.png" },
}
colormenu = {
   { "G&color2", "gcolor2", pixmaps .. "gcolor2/icon.png" },
   { "G&pick", "gpick", app48 .. "gpick.png"}
}
graphicmenu = {
   { "&GIMP", "gimp", app48 .. "gimp.png" },
   { "&Inkscape", "inkscape", app48 .. "inkscape.png" },
   { "K&rita", "krita", app48 .. "calligrakrita.png" },
   { "&Blender", "blender", apps .. "blender.svg" },
   { "&OBS", "obs", app256 .. "com.obsproject.Studio.png" },
   { "&FreeCAD", "freecad", app48 .. "freecad.png" },
   { "&OpenSCAD", "openscad", pixmaps .. "openscad.png" },
   { "&Darktable", "darktable", app48 .. "darktable.png" },
   { "Gee&qie", "geeqie", pixmaps .. "geeqie.png" },
   { "g&thumb", "Gthumb", app48 .. "gthumb.png" },
   { "&Shotwell", "shotwell", app48 .. "shotwell.png" },
   { "&Color", colormenu },
}
pamenu = {
   { "&PulseAudio Manager", "paman", dev48g .. "audio-card.png" },
   { "Volume &Control", "pavucontrol", app48g .. "multimedia-volume-control.png" },
   { "Volume &Meter", "pavumeter", dev48g .."audio-input-microphone.png" },
}
multimediamenu = {
   { "&FeelUOwn", home_path .. ".local/bin/feeluown", home_path .. ".local/share/pixmaps/feeluown.png" },
   { "&NetEase Cloud Music", "netease-cloud-music", apps .. "netease-cloud-music.svg" },
   { "K&W Player", "kwplayer", app48 .. "kwplayer.png" },
   { "&PulseAudio Control", pamenu },
   { "&Ario", "ario", app48 .. "ario.png" },
   { "&Gmpc", "gmpc", app48 .. "gmpc.png" },
   { "&Lollypop", "lollypop", app48 .. "org.gnome.Lollypop.png" },
   { "&Osdlyrics", "osdlyrics", app64 .. "osdlyrics.png" },
   { "Len&mus" , "lenmus", pixmaps .. "lenmus.png" },
   { "Kid3", "kid3-qt", app48 .. "kid3-qt.png" },
   { "Audacity", "audacity", app48 .. "audacity.png" },
}
qtmenu = {
   { "Qt5 &Assistant", "assistant-qt5", app32 .. "assistant.png" },
   { "Qt4 Assistant", "assistant-qt4", app32 .. "assistant-qt4.png" },
   { "Qt5 &Designer", "designer-qt5", app128 .. "QtProject-designer.png" },
   { "Qt4 Designer", "designer-qt4", app128 .. "designer-qt4.png" },
}
sqlmenu = {
   { "&Sqlitebrowser", "sqlitebrowser", app256 .. "sqlitebrowser.png" },
   { "Sqlite&man", "sqliteman", app32 .. "sqliteman.png" },
   { "&Navicat", "navicat", "/opt/navicat/Navicat/help/img/icon_navicat.png" },
}
developmentmenu = {
   { "&Qt", qtmenu },
   { "&Sql", sqlmenu },
   { "&CMake", "cmake-gui", app32 .. "CMakeSetup.png" },
   -- { "&Genymotion", "genymotion", "/opt/genymotion/icons/icon.png" },
   -- { "&Astah", "astah" },
   { "&Devhelp", "devhelp", apps .. "org.gnome.Devhelp.svg" },
   { "Heimdall &Frontend", "heimdall-frontend", pixmaps .. "heimdall.png" },
   { "&BeanShell", "/usr/lib/jvm/default/bin/java -jar /usr/share/java/bsh.jar" },
   { "H&opper Disassembler v4", "/opt/hopper-v4/bin/hopper-launcher.sh", app48 .. "hopper-disassembler-v4.png" },
   { "&IDA Demo", "/opt/ida-demo/idaq", app64 .. "ida.png" },
}
webtoolsmenu = {
   { "Zenmap", "zenmap", "/usr/share/zenmap/pixmaps/zenmap.png" },
   { "&Zenmap (as root)", "gksudo zenmap", "/usr/share/zenmap/pixmaps/zenmap.png" },
   { "&Wireshark", "wireshark-gtk", app48 .. "wireshark.png" },
   { "&Burp Suite", "burpsuite", pixmaps .. "burpsuite.png" },
   { "Charles", "charles", app64 .. "charles.png" },
}
webcammenu = {
   { "&Guvcview", "guvcview", pixmaps .. "guvcview/guvcview.png" },
   { "&Cheese", "cheese", app48 .. "org.gnome.Cheese.png" },
}
bridgemenu = {
   { "&Bridge Master 2000", "dex " .. home_path .. ".local/share/applications/'Bridge Master 2000.desktop'" },
   { "&Learn to Play Bridge", "dex " .. home_path .. ".local/share/applications/wine/Programs/'Bridge Base Inc'/'Learn to Play Bridge.desktop'" },
}
winemenu = {
   -- { "&TIM", "/opt/deepinwine/apps/Deepin-TIM/run.sh", app48 .. "deepin.com.qq.office.svg" },
   -- { "&QQ", "/opt/deepinwine/apps/Deepin-QQ/run.sh", app48 .. "deepin.com.qq.im.svg" },
   -- { "&Wechat", "/opt/deepinwine/apps/Deepin-WeChat/run.sh", app48 .. "deepin.com.wechat.svg" },
   { "&RHWUD", "env WINEPREFIX=" .. home_path .. ".wine WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/Program\\ Files\\ \\(x86\\)/Random\\ House,\\ Inc/Random\\ House\\ Webster\\'s\\ Unabridged\\ Dictionary/RHUD30.EXE" },
   { "&CAJViewer", "env LANG=zh_CN.UTF8 WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/'Program Files (x86)'/TTKN/'CAJViewer 7.2'/CAJVieweru.exe" },
   { "&SsReader", "env LANG=zh_CN.UTF8 WINEDEBUG=-all wine " .. home_path .. ".wine/drive_c/'Program Files (x86)'/SSREADER36/SsReader.exe" },
   { "&Bridge", bridgemenu },
}
gamemenu = {
   { "Super&tux2", "supertux2", pixmaps .. "supertux.png"},
   { "&OpenRA", "opnra", app48 .. "openra-ra.png" },
   { "&mGBA", "mgba-qt", pixmaps .. "mgba.png" },
   { "&Fceux", "fceux", pixmaps .. "fceux.png" },
   { "Hi&gan", "higan", pixmaps .. "higan.png" },
   -- { "&Steam", "/usr/lib/steam/steam", app48 .. "steam.png" },
}
othermenu = {
   { "Shutter", "shutter", app48 .. "shutter.png" },
   { "&VirtualBox", "virtualbox", mime48 .. "virtualbox.png" },
   { "File &Cleaner", "bleachbit", pixmaps .. "bleachbit.png" },
   { "Manage &Printing", "xdg-open http://localhost:631/", app32 .. "cups.png" },
   { "&WebCam", webcammenu },
   { "&Bluetooth", "blueman-manager", app48 .. "blueman.png" },
   { "&Passwords and Keys", "seahorse", app48 .. "seahorse-preferences.png" },
   { "&Font Editor", "fontforge", app48 .. "org.fontforge.FontForge.png" },
   { "Hardware Topology", "lstopo" },
   { "&Stellarium", "stellarium", app48 .. "stellarium.png" },
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
                             { "&Files", "pcmanfm", "/usr/share/icons/gnome/48x48/places/gtk-directory.png" },
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
