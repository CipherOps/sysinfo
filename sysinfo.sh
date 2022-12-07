#!/bin/bash

os=$(cat /etc/os-release | grep PRETTY_NAME | awk -F '"' '{print $2}')
disk_total=$(df -h / | tail -n 1 | awk '{print $2}')
disk_free=$(df -h / | tail -n 1 | awk '{print $4}')
ram_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
ram_total=$((ram_total / 1024 / 1024))
ram_free=$(grep MemFree /proc/meminfo | awk '{print $2}')
ram_free=$((ram_free / 1024 / 1024))
load=$(cat /proc/loadavg)
cpu_cores=$(grep -c ^processor /proc/cpuinfo)
uptime=$(uptime | awk '{print $3,$4}' | sed 's/,//')

echo -e '\033[0;33m'
echo "
/   /                                     /   /
| O |                                     | O |
|   |- - - - - - - - - - - - - - - - - - -|   |
| O |                                     | O |
|   |                                     |   |
| O |                                     | O |
|   |                                     |   |
| O |                                     | O |
|   |        C O M P U T E R              |   |
| O |                                     | O |
|   |        R E P O R T                  |   |
| O |                                     | O |
|   |                                     |   |
| O |                                     | O |
|   |                                     |   |
| O |                                     | O |
|   |                                     |   |
| O |- - - - - - - - - - - - - - - - - - -| O |
|   |                                     |   |
"

echo "Machine Info:"
echo "Operating System: $os"
echo "Uptime:"
echo "$uptime"
echo "Disk Space: $disk_total ($disk_free available)"
echo "RAM: $ram_total GB ($ram_free GB available)"
echo "Load Averages:"
echo "$load"
echo "CPU Cores: $cpu_cores"
echo "Top CPU Processes:"
ps aux | sort -nrk 3,3 | head -n 3 | awk '{print $11}'
echo "Top RAM Processes:"
ps aux | sort -nrk 4,4 | head -n 3 | awk '{print $11}'
echo -e '\033[0m'
