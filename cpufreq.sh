#!/bin/bash

echo 'Changing cpufreq to powersave...'

sudo cpufreq-set -c 0 -g powersave
sudo cpufreq-set -c 1 -g powersave
sudo cpufreq-set -c 2 -g powersave
sudo cpufreq-set -c 3 -g powersave
sudo cpufreq-set -c 4 -g powersave
sudo cpufreq-set -c 5 -g powersave
sudo cpufreq-set -c 6 -g powersave
sudo cpufreq-set -c 7 -g powersave

echo -e "\n\n"

cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

echo -e "\n\n"

echo 'Done.'

exit
