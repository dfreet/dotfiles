#!/usr/bin/env python

import sys, time, gi
gi.require_version("Playerctl", "2.0")
from gi.repository import Playerctl, GLib

icons = [ "🎵", "" ]
supportedPlayers = [ "spotify" ]
players = [ Playerctl.Player.new(name) for name in supportedPlayers if name in 
        [ player.name for player in Playerctl.list_players() ] ]
primary = None

if len(players) > 0:
    for player in players:
        if int(player.get_property("playback-status")) == 0:
            primary = player
    else:
        primary = players[0]

button = 0
if len(sys.argv) > 1:
    try:
        button = int(sys.argv[1])
        if button == 1:
            primary.play_pause()
        elif button == 3:
            primary.stop()
        elif button == 9:
            primary.next()
        elif button == 8:
            primary.previous()
    except ValueError:
        button = 0

if primary is not None:
    if primary.get_property("player-name") == "spotify":
        pangoEscape = lambda s: s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("'", "&#39;")
        player = Playerctl.Player.new("spotify")
        color = "#00ff00" if int(player.get_property("playback-status")) == (1 if button == 1 else 0) else "#999999"
        icon = 1
        artist = pangoEscape(player.get_artist())
        title = pangoEscape(player.get_title())
        artist = artist[:50] + "..." if len(artist) > 53 else artist
        title = title[:50] + "..." if len(title) > 53 else title
        print("<span foreground='{0}'>{1} {2} - {3}</span>".format(color, icons[icon], artist, title))
else:
    print("<span foreground='#999999'></span>")

