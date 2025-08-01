#!/bin/bash

# #####################################################################

# This scripts gives the server statistics
# Author: Sunayana

# #####################################################################

echo " ====== SERVER PERFORMACE REPORT ======="
echo " Generated on: $(date)"
echo " ======================================= "

# OS version
echo "OS Version"
cat /ect/*release | grep PRETTY_NAME | cut -d= -f2 | tr -d \"
echo

# uptime
echo "uptime:"
uptime -p
echo

# Load average
uptime | awk -F'load average:' '{print $2}'
echo

# Logged in user
echo "Logged in user:"
who
echo

# CPU usage
echo "CPU usage :"
top -bn1 | grep "Cpu(s)" | awk '{print "User: "$2"%  System: "$4"%  Idle: "$8"%"}'

# Memory Usage
echo "Memory Usage:"
free -h
used_mem= $(free | awk '/Mem:/ {printf("%.2f"), $2/$3*100}')
echo "Memory usage percentage: $used_mem%"
echo

# Disk usage
echo "Disk Usage:"
df -h --total | grep -E "Filesystem|total"
echo

# Top 5 processes by Memory
echo "Top 5 processes by Memory"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

# Top 5 processes by CPU
echo "Top 5 processes by CPU"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
echo

echo "============= END OF REPORT ============="