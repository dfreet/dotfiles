#!/bin/python

'''
Devyn Freet
Get Wifi & VPN info (connection, ping, ip
'''

#try:

import subprocess

wifi = ""
output = wifi + " "
connected = False
proc = subprocess.run(["nmcli", "c", "show"], encoding="utf-8", stdout=subprocess.PIPE, stderr=subprocess.PIPE)
data = proc.stdout.split("\n")
nameEnd = data[0].find("UUID")
uuidEnd = data[0].find("TYPE")
typeEnd = data[0].find("DEVICE")
items = []
for item in data[1:-1]:
    name = item[:nameEnd].strip()
    uuid = item[nameEnd:uuidEnd].strip()
    ctype = item[uuidEnd:typeEnd].strip()
    device = item[typeEnd:].strip()
    items.append((name, uuid, ctype, device))

for item in items:
    if item[-1] != "--":
        output += '<span foreground="green">Conn: {0}</span> | '.format(item[0])
        connected = True
        break;
else:
    output += '<span foreground="red">Conn: --</span>'

if connected:
    ipIndex = 1
    proc = subprocess.run(["protonvpn", "status"], encoding="utf-8", stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    data = proc.stdout.split("\n")
    status = data[0].split()[1]

    if status == "Disconnected":
        output += '<span foreground="red">VPN: --</span> | '
    else:
        server = data[3].split()[1]
        output += '<span foreground="green">VPN: {0}</span> | '.format(server)
        ipIndex = 2


#except:
#    print('<span foreground="red">WIFI BLOCK BROKEN</span>')

