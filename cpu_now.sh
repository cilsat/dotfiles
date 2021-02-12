#!/bin/sh
# Current average CPU load
#mpstat 2 1 | awk '$13 ~ /[0-9.]+/ {printf(" %.1f%", 100-$13)}'
# Current average CPU temperature
awk '{printf(" %.1f℃",$1*10^-3)}' /sys/devices/platform/thinkpad_hwmon/hwmon/*/temp1_input
# Current average CPU clock
#sort /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq | tail -n 1 |\
#  awk '{printf(" %.1fGHz",$1*10^-6)}'
