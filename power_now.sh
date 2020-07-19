#!/bin/sh
# Battery charge percentage
paste /sys/class/power_supply/BAT0/energy_now \
  /sys/class/power_supply/BAT0/energy_full | awk '{printf("%.1f% ", 100*$1/$2)}' 
# Current power consumption
awk '{printf("%.2fW", $1*10^-6)}' /sys/class/power_supply/BAT0/power_now
# Time remaining on battery
paste /sys/class/power_supply/BAT0/energy_now \
  /sys/class/power_supply/BAT0/power_now | awk '{printf(" %.2fh", $1/$2)}' 
