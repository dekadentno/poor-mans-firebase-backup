#!/bin/bash

: '
This Bash script is designed to extract and display several
server statistics, including CPU usage, memory usage, disk usage,
network traffic, load average, and server uptime.
'
current_user=$(whoami)
host_name=$(hostname)

echo "Stats for $current_user @ $host_name"

# Get the CPU usage percentage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Get the total memory and used memory in megabytes
MEM=$(free -m | awk 'FNR == 2 {print $2" "$3}')

# Get the total disk space and used disk space in megabytes
DISK=$(df -BM / | awk 'NR==2{print $2" "$3}')

# Get the current network traffic in megabytes
RX_BYTES=$(ifconfig wlp2s0 | awk '/RX p/{print $5}')
TX_BYTES=$(ifconfig wlp2s0 | awk '/TX p/{print $5}')
# Incoming network traffic (received)
RX_MB=$(echo "scale=2; $RX_BYTES/1024/1024" | bc)
# Outgoing network traffic (transmitted)
TX_MB=$(echo "scale=2; $TX_BYTES/1024/1024" | bc)

# Get the current load average
LOAD=$(uptime | awk '{print $10 $11 $12}')

# Get the server uptime in days, hours, and minutes
UPTIME=$(awk '{print int($1/86400) " days " int(($1%86400)/3600) " hours " int((($1%86400)%3600)/60) " minutes"}' /proc/uptime)

# Print the statistics with tabs
echo -e "CPU usage:\t\t$CPU%"
echo -e "Memory usage:\t\t$MEM MB"
echo -e "Disk usage:\t\t$DISK MB"
echo -e "Network traffic (RX):\t$RX_MB MB"
echo -e "Network traffic (TX):\t$TX_MB MB"
echo -e "Load average:\t\t$LOAD"
echo -e "Server uptime:\t\t$UPTIME"