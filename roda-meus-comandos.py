#!/usr/bin/env python3
import subprocess
import os
import signal
import gi
gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
from gi.repository import Gtk, AppIndicator3

currpath = os.path.dirname(os.path.realpath(__file__))

class Indicator():
    def __init__(self):
        self.app = 'update_setting'
        iconpath = currpath+"/icon.png"
        self.indicator = AppIndicator3.Indicator.new(
            self.app, iconpath,
            AppIndicator3.IndicatorCategory.SYSTEM_SERVICES)
        self.indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)       
        self.indicator.set_menu(self.create_menu())

    def getscripts(self):
        cmd_data = [l for l in open(
            os.path.join(currpath, "commands")
            ).read().splitlines()]
        cmd_data = [l.split("||") for l in cmd_data]  
        for cmd in cmd_data:
            menuitem = Gtk.MenuItem(cmd[0].strip())
            menuitem.connect("activate", self.run_script, cmd[1].strip())
            self.menu.append(menuitem)

    def create_menu(self):
        self.menu = Gtk.Menu()
        self.getscripts()
        # quit
        item_quit = Gtk.MenuItem('Quit')
        sep = Gtk.SeparatorMenuItem()
        self.menu.append(sep)
        item_quit.connect('activate', self.stop)
        self.menu.append(item_quit)
        self.menu.show_all()
        return self.menu

    def run_script(self, widget, script):
        subprocess.Popen(["/bin/zsh", "-c", script])

    def stop(self, source):
        Gtk.main_quit()

Indicator()
signal.signal(signal.SIGINT, signal.SIG_DFL)
Gtk.main()
