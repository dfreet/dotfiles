#!/bin/python

'''
Created by Devyn Freet
Script to display battery level/charging status
Last updated 3-16-2020
'''

# Try/Except to print when block is broken instead of simply not displaying
try:
    import gi     # For low battery notification
    import os     # To access current directory & set data file
    import psutil # To get battery information from the system

    # Ensure correct version of Notify is imported
    gi.require_version("Notify", "0.7")
    from gi.repository import Notify

    # Battery state icons: empty, 1/4, half, 3/4, full
    batteryStates = [ "", "", "", "", "" ]

    # Directory where battery state & previous charge are stored
    dataDir = os.path.join(os.path.dirname(__file__), "batteryData.csv")

    # Use psutil to get charge level & whether battery is currently charging
    battery = psutil.sensors_battery()
    if battery is not None:
        batPercent = int(battery.percent)
        batPlugged = battery.power_plugged

        # When to give low battery notification (-1 for never)
        warnPercent = 15

        # Read data file; if it doesn"t exist or is invalid, use default data values
        try:
            with open(dataDir, "r") as rf:
                data = [ int(num) for num in rf.read().split(",") ]
                if len(data) != 2:
                    raise ValueError
        except (FileNotFoundError, ValueError):
            data = [2, 50]

        # If battery is plugged in, change icon for charging animation; else, set icon & percent according to charge level
        if batPlugged:
            data[0] = data[0] % 3 + 1
            data[1] = batPercent
        else:
            # Send notification if battery is below warning level & wasn't before
            if batPercent <= warnPercent and data[1] > warnPercent:
                Notify.init("Battery Low!")
                batt = Notify.Notification.new("Battery Low!", "Your battery is below {0}%".format(warnPercent), "dialog-information")
                batt.show()
            data[0] = abs(batPercent - 1) // 20
            data[1] = batPercent

        # Write icon & charge data to file
        with open(dataDir, "w") as wf:
            wf.write(",".join([ str(item) for item in data ]))

        # Set output color based on battery level
        color = "red" if batPercent < 25 else "#eeeeee" if batPercent < 75 else "#00aa00"

        # Display formatted output
        if color == "yellow":
            print("{0} {1}%{2}".format(batteryStates[data[0]], batPercent, " ;)" if batPercent == 69 else ""))
        else:
            print("<span foreground='{0}'>{1} {2}%{3}</span>".format(color, batteryStates[data[0]], batPercent, " ;)" if batPercent == 69 else ""))

except Exception as e:
    print("<span foreground='red'>BATTERY BLOCK BROKEN</span>\n{0}: {1}".format(type(e), e))

