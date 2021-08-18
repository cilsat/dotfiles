#!/bin/sh
## Battery charge percentage
#paste /sys/class/power_supply/BAT0/energy_now \
#  /sys/class/power_supply/BAT0/energy_full | awk '{printf("%.1f%", 100*$1/$2)}' 

## Time remaining on battery
#paste /sys/class/power_supply/BAT0/energy_now \
#  /sys/class/power_supply/BAT0/power_now | awk '{printf(" %.2fh", $1/$2)}' 

## Current average CPU temperature
awk '{printf("%.1f℃",$1*10^-3)}' /sys/devices/platform/thinkpad_hwmon/hwmon/*/temp1_input

## Current power consumption
awk '{printf(" %.2fW", $1*10^-6)}' /sys/class/power_supply/BAT0/power_now
