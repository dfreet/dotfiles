#!/bin/python

'''
Devyn Freet
Gets cpu usage
October 8, 2019
Last updated 3-16-2020
'''

# Wrap in try/except to display when block is broken
try:
    import psutil # To access CPU information

    # Get CPU usage percent
    percent = psutil.cpu_percent(1)

    # display formatted string
    print("<span foreground='#eeeeee'> " + str(percent) + "%</span>")

except Exception as e: 
    print('<span foreground="red">CPU BLOCK BROKEN</span>\n{0}: {1}'.format(type(e), e))

