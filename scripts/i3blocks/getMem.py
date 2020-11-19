#!/bin/python

'''
Devyn Freet
Get memory usage
October 7, 2019
Last modified 3-22-2020
'''

# Wrap in try/except to show when block is broken
try:
    import psutil # To get RAM usage

    def convertBytes(memory):
            # byte unit conversions (^1=KB, ^2=MB, ^3=GB)
            byteConv = 1000
            unit = "B"
            
            if memory >= byteConv ** 3:
                    memory = round(memory / (byteConv ** 3), 2)
                    unit = "GB"
            elif memory >= byteConv ** 2:
                    memory = round(memory / (byteConv ** 2), 2)
                    unit = "MB"
            elif memory >= byteConv:
                    memory = round(memory / byteConv, 2)
                    unit = "KB"

            return memory, unit

    # Get RAM Data
    ram = psutil.virtual_memory()
    
    # Get used, free, and total RAM
    usedMem, usedUnit = convertBytes(ram.used)
    totMem, totUnit = convertBytes(ram.total)
    freeMem, freeUnit = convertBytes(ram.available)

    # format data with units
    used = str(usedMem) + usedUnit
    total = str(totMem) + totUnit
    free = str(freeMem) + freeUnit

    # print formatted string
    print(" <span foreground='#ff6666'>{0}</span>/<span foreground='#ffcc00'>{1}</span> (<span foreground='#00ff00'>{2}</span>)"
            .format(used, total, free))
    
except Exception as e:
    print('<span foreground="red">RAM BLOCK BROKEN</span>\n', type(e), e)

