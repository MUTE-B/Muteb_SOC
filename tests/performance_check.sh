#!/bin/bash
#
# MUTEB SOC
# Performance Check
#


echo "=== PERFORMANCE CHECK ==="



echo

echo "CPU"

top -bn1 | grep Cpu



echo

echo "Memory"

free -h



echo

echo "Disk"

df -h /



echo

echo "Running Processes"

ps aux --sort=-%cpu | head -10



