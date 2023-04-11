#!/bin/bash

: '
This Bash script is designed to extract and display several
system statistics, including CPU usage, memory usage, disk usage,
and network traffic.
'

# CPU usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Memory usage
MEM=$(free -m | awk 'FNR == 2 {print $2" "$3" "$4}')
TOTAL_MEM=$(echo $MEM | awk '{print $1}')
USED_MEM=$(echo $MEM | awk '{print $2}')
FREE_MEM=$(echo $MEM | awk '{print $3}')

# Disk usage
DISK=$(df -BM / | awk 'NR==2{print $2" "$3" "$4}')
TOTAL_DISK=$(echo $DISK | awk '{print $1}')
USED_DISK=$(echo $DISK | awk '{print $2}')
FREE_DISK=$(echo $DISK | awk '{print $3}')

# Network traffic
RX_BYTES=$(ifconfig wlp2s0 | awk '/RX p/{print $5}')
TX_BYTES=$(ifconfig wlp2s0 | awk '/TX p/{print $5}')
RX_MB=$(echo "scale=2; $RX_BYTES/1024/1024" | bc)
TX_MB=$(echo "scale=2; $TX_BYTES/1024/1024" | bc)

# Get the current load average
LOAD=$(uptime | awk '{print $10 $11 $12}')

# Get the server uptime in days, hours, and minutes
UPTIME=$(awk '{print int($1/86400) " days " int(($1%86400)/3600) " hours " int((($1%86400)%3600)/60) " minutes"}' /proc/uptime)


echo "Stats for $(whoami) @ $(hostname)"
echo
echo -e "CPU usage: $CPU%"
echo -e "Memory (total):\t$TOTAL_MEM MB"
echo -e "Memory (used):\t$USED_MEM MB"
echo -e "Memory (free):\t$FREE_MEM MB"
echo -e "Disk (total):\t$TOTAL_DISK MB"
echo -e "Disk (used):\t$USED_DISK MB"
echo -e "Disk (free):\t$FREE_DISK MB"
echo -e "Network (RX):\t$RX_MB MB"
echo -e "Network (TX):\t$TX_MB MB"
echo -e "Load average:\t$LOAD"
echo -e "Server uptime:\t$UPTIME"