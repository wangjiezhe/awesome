#!/usr/bin/env python3

import os
import time
import xml.etree.ElementTree as ET
from subprocess import (
    check_output,
    CalledProcessError,
    Popen,
    PIPE,
)
import logging
import logging.handlers

from configparser import ConfigParser, NoOptionError
import requests

try:
    import setproctitle
    setproctitle.setproctitle('update_github')
except ImportError:
    pass
logger = logging.getLogger(__name__)
logger.addHandler(logging.handlers.SysLogHandler(address='/dev/log'))
logger.setLevel(logging.INFO)


def get_proxy() -> None:
    gitconfig = os.path.expanduser('~/.gitconfig')
    config = ConfigParser()
    config.read(gitconfig)
    try:
        proxy = config.get('http', 'proxy')
        proxies = {'https': proxy}
    except NoOptionError:
        proxies = None
    return proxies


def github_contributed() -> bool:
    user = os.environ['USER']
    today = time.strftime('%Y-%m-%d')
    url = "https://github.com/users/%s/contributions" % user
    data = requests.get(url, timeout=30, proxies=get_proxy()).text
    svg = ET.fromstring(data)
    rect = svg.find('.//rect[@data-date="%s"]' % today)
    if rect is None:
        return False
    return int(rect.get('data-count')) > 0


def get_dbus() -> bool:
    if 'DBUS_SESSION_BUS_ADDRESS' in os.environ:
        return True

    cmd = ['pgrep', '-U%d' % os.getuid(), '-x', 'awesome']
    try:
        pid = check_output(cmd).strip().decode('ascii', errors='ignore')
    except CalledProcessError as e:
        if e.returncode == 1:
            # Awesome not running
            return False
        raise

    with open('/proc/%s/environ' % pid) as f:
        dbus = [
            x.split('=', 1)[1] for x in f.read().split('\0')
            if x.startswith('DBUS_SESSION_BUS_ADDRESS=')
        ]
    if not dbus:
        logger.error("can't get DBUS_SESSION_BUS_ADDRESS of awesome (pid %s)",
                     pid)
        return False
    dbus = dbus[0]

    os.environ['DBUS_SESSION_BUS_ADDRESS'] = dbus
    return True


def main() -> None:
    ok = get_dbus()
    if not ok:
        return

    try:
        s = str(github_contributed()).lower()
    except requests.exceptions.ConnectTimeout:
        logger.error('github timed out')
        return

    s = 'update_github(%s)' % s
    logger.info(s)

    client = Popen(['awesome-client'], stdin=PIPE)
    client.communicate(s.encode('ascii'))


if __name__ == '__main__':
    main()
