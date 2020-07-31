#!/bin/sh
# Current average CPU load
mpstat 2 1 | awk '$13 ~ /[0-9.]+/ {printf(" %.1f%", 100-$13)}'
# Current average CPU temperature
paste /sys/class/thermal/thermal_zone*/temp |\
  awk '{t=0; for(i=1;i<=NF;i++) t+=$i; printf(" %.1f°C",10^-3*t/NF)}'
# Current average CPU clock
paste /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq |\
  awk '{c=0; for(i=1;i<=NF;i++) c+=$i; printf(" %.1fGHz",10^-6*c/NF)}'
