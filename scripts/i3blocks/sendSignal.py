#!/usr/bin/env python

'''
Devyn Freet
---description---
3-30-2020
'''

import gi, os, signal, subprocess as sp

gi.require_version("Playerctl", "2.0")
from gi.repository import Playerctl, GLib

supportedPlayers = [ "spotify" ]

manager = Playerctl.PlayerManager()

def sendSig(app = "i3blocks", sig = signal.SIGRTMIN+1):
#    pids = list(map(int, sp.check_output(["pidof", app]).split()))
#    for pid in pids:
#        os.kill(pid, sig)

def add_player(manager, name):
    if name.name in supportedPlayers:
        player = Playerctl.Player.new_from_name(name)
        manager.manage_player(player)
        player.connect("metadata", on_metadata)

def on_player_vanished(manager, player):
    sendSig()

def on_metadata(player, playback_status):
    sendSig()

manager.connect("name-appeared", add_player)
manager.connect("player-vanished", on_player_vanished)
for name in manager.get_property("player-names"):
    add_player(manager, name)

GLib.MainLoop().run()

