#!/bin/sh
paste /sys/class/power_supply/BAT0/energy_now \
  /sys/class/power_supply/BAT0/energy_full | awk '{printf("%.2f% ", 100*$1/$2)}' 
awk '{printf("%.2fW", $1*10^-6)}' /sys/class/power_supply/BAT0/power_now
paste /sys/class/power_supply/BAT0/energy_now \
  /sys/class/power_supply/BAT0/power_now | awk '{printf(" %.2fh", $1/$2)}' 
