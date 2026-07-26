#!/bin/bash

# =====================================
# Muteb SOC
# Security Monitoring Framework
# Version 1.0
# Developer: Muteb Albalawi
# University: University of Tabuk
# =====================================


# Report File

REPORT="reports/Muteb_SOC_Report_$(date +%F).txt"



# =====================================
# Display Banner
# =====================================

echo "================================="
echo "          Muteb SOC"
echo " Security Monitoring Framework"
echo "================================="

echo

echo "Developer : Muteb Albalawi"
echo "Role      : SOC Analyst"
echo "University: University of Tabuk"
echo "Version   : 1.0"



# =====================================
# Create Report Header
# =====================================

echo "=================================" > $REPORT
echo "          Muteb SOC Report" >> $REPORT
echo "=================================" >> $REPORT

echo "Generated Date:" >> $REPORT
date >> $REPORT

echo >> $REPORT



# =====================================
# System Information
# =====================================


echo "===== System Information ====="


echo "Hostname:"
hostname


echo "Hostname:" >> $REPORT
hostname >> $REPORT


echo


echo "Current User:"
whoami


echo "Current User:" >> $REPORT
whoami >> $REPORT


echo


echo "Date:"
date


echo "Date:" >> $REPORT
date >> $REPORT


echo


echo "IP Address:"
hostname -I


echo "IP Address:" >> $REPORT
hostname -I >> $REPORT


echo


echo "System Uptime:"
uptime


echo "System Uptime:" >> $REPORT
uptime >> $REPORT


echo


echo "Disk Usage:"
df -h


echo "Disk Usage:" >> $REPORT
df -h >> $REPORT


echo


echo "Memory Usage:"
free -h


echo "Memory Usage:" >> $REPORT
free -h >> $REPORT



# =====================================
# Service Monitoring
# =====================================


echo

echo "===== Service Monitoring ====="


echo >> $REPORT
echo "===== Service Monitoring =====" >> $REPORT



SERVICES=("ssh" "apache2" "docker" "mysql")



for SERVICE in "${SERVICES[@]}"
do


STATUS=$(systemctl is-active $SERVICE)



if [ "$STATUS" = "active" ]

then


echo "$SERVICE : OK"

echo "$SERVICE : OK" >> $REPORT



else


echo "$SERVICE : WARNING"

echo "$SERVICE : WARNING" >> $REPORT



fi



done



# =====================================
# Finish
# =====================================


echo

echo "Report Saved:"
echo "$REPORT"


echo

echo "Muteb SOC Scan Completed"
