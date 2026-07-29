

#!/bin/bash


echo "MUTEB SYSTEM MONITOR"

echo "===================="


echo "CPU:"
top -bn1 | grep "Cpu"



echo "Memory:"

free -h



echo "Disk:"

df -h /



echo "Status: ONLINE"



