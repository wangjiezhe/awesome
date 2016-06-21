#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import itertools


def find_icon(icon_name):
    home = os.getenv('HOME')
    xdg_data_dirs = os.getenv('XDG_DATA_DIRS') or '/usr/local/share:/usr/share'
    xdg_data_dirs = xdg_data_dirs.split(':')
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

    icon_search_home = (os.path.join(home, '.icons'),)
    icon_search_size = (
        os.path.join(
            data_dir, 'icons', theme, '{s}x{s}'.format(s=size), category
        )
        for data_dir in xdg_data_dirs
        for theme in theme_list
        for size in size_list
        for category in category_list
    )
    icon_search_scalable = (
        os.path.join(data_dir, 'icons', theme, 'scalable', category)
        for data_dir in xdg_data_dirs
        for theme in theme_list
        for category in category_list
    )
    icon_search_other = (
        os.path.join(data_dir, 'icons', s)
        for data_dir in xdg_data_dirs
        for s in ('mini', '', 'large')
    )
    icon_search_pixmaps = ('/usr/share/pixmaps',)

    icon_search_path = (
        this_dir for this_dir in itertools.chain(
            icon_search_home,
            icon_search_size,
            icon_search_pixmaps,
            icon_search_scalable,
            icon_search_other,
        )
        if os.path.isdir(this_dir)
    )

    for icon_dir in icon_search_path:
        for ext in ('', '.png', '.xpm', '.svg'):
            filename = os.path.join(
                icon_dir, icon_name + ext
            )
            if os.path.isfile(filename):
                return filename
