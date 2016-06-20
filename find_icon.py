#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os


def find_icon(icon_name):
    home = os.getenv('HOME')
    xdg_data_dirs = os.getenv('XDG_DATA_DIRS') or '/usr/local/share:/usr/share'
    xdg_data_dirs = xdg_data_dirs.split(':')
    icon_search_path = ['/']
    category_list = (
        'apps', 'places', 'devices', 'actions', 'animations',
        'categories', 'emblems', 'emotes', 'filesystems', 'intl',
        'mimetypes', 'status', 'stock',
    )
    size_list = (
        16, 20, 22, 24, 26, 32, 36, 40, 48, 64, 72, 96,
        128, 192, 256, 384, 512, 1024,
    )
    theme_list = ('hicolor', 'gnome')

    this_dir = os.path.join(home, '.icons')
    if os.path.exists(this_dir):
        icon_search_path.append(this_dir)

    for data_dir in xdg_data_dirs:
        for theme in theme_list:
            for size in size_list:
                for category in category_list:
                    this_dir = os.path.join(
                        data_dir, 'icons', theme,
                        '{s}x{s}'.format(s=size), category
                    )
                    if os.path.isdir(this_dir):
                        icon_search_path.append(this_dir)

            this_dir = os.path.join(
                data_dir, 'icons', theme, 'scalable', category
            )
            if os.path.isdir(this_dir):
                icon_search_path.append(this_dir)

            this_dir = os.path.join(data_dir, 'icons', 'mini')
            if os.path.isdir(this_dir):
                icon_search_path.append(this_dir)

            this_dir = os.path.join(data_dir, 'icons')
            if os.path.isdir(this_dir):
                icon_search_path.append(this_dir)

            this_dir = os.path.join(data_dir, 'icons', 'large')
            if os.path.isdir(this_dir):
                icon_search_path.append(this_dir)

    icon_search_path.append('/usr/share/pixmaps')

    for icon_dir in icon_search_path:
        for ext in ('', '.png', '.xpm', '.svg'):
            filename = os.path.join(
                icon_dir, icon_name + ext
            )
            if os.path.isfile(filename):
                return filename
