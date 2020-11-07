#!/bin/python

'''
Devyn Freet
Get current audio volume
3-22-2020
'''

# Wrap in try/except to show when block is broken
try:
    import subprocess # To run amixer command that gets volume

    volumeLogos = ["🔇", "🔈", "🔉", "🔊"] # Speaker symbols to show with block

    # Get output of "amixer sget Master" to find volume & store in list
    output = subprocess.run(["amixer", "sget", "Master"], capture_output = True)
    lines = str(output).split("\\n")

    # Get output line that contains volume information
    volLine = lines[-2].replace("]", "")

    # Get volume and mute status from line
    data = volLine.split("[")
    volume = int(data[1].strip().replace("%", ""))

    # If unmuted, set logo & color based on current charge; else use muted, red, and add brackets around volume
    if data[-1].strip() == "on":
        logo = abs(volume - 2) // 33 + 1
        color = "#ffffff" if volume < 85 else "#ff0000"
        volume = str(volume) + "%"
    else:
        logo = 0
        color = "#00ff00"
        volume = "[{0}%]".format(str(volume))

    # Print formatted output
    print("<span foreground='{0}'>{1} {2}</span>".format(color, volumeLogos[logo], volume))

except Exception as e:
    print('<span foreground="red">VOLUME BLOCK BROKEN</span>\n', type(e), e)

