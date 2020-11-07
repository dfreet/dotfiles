#!/bin/python

'''
Created by Devyn Freet
Get/Format date & time for i3blocks
Last updated 3-16-2020
'''

# Wrap in try/except to display when block is broken
try:
    import datetime # To get current date & time

    # Define day & month names
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    # Get current time
    now = datetime.datetime.now()

    # Format time
    output = "{0}, {1} {2}, {3} {4}:{5}".format(days[now.weekday()], months[now.month - 1], str(now.day), str(now.year), str(now.hour), str(now.minute).rjust(2, "0"))

    # Output formatted time
    print("<span foreground='#eeeeee'> " + output + "</span>")

except Exception as e:
    print("<span foreground='red'>DATE BLOCK BROKEN</span>\n{0}: {1}".format(type(e), e))

