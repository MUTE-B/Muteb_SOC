#!/bin/bash


# =====================================================
# Muteb SOC Security Check
#
# الهدف:
# إجراء فحص أمني أساسي على نظام Linux
#
# الفحوصات:
# - Open Ports
# - Firewall Status
# - Failed Login Attempts
# - Active Network Services
# - Current User
# =====================================================



echo "Starting Security Check"


echo ""
echo "=============================="
echo "Current User"
echo "=============================="


whoami



echo ""
echo "=============================="
echo "Open Network Ports"
echo "=============================="


ss -tulnp



echo ""
echo "=============================="
echo "Firewall Status"
echo "=============================="


sudo ufw status



echo ""
echo "=============================="
echo "Failed Login Attempts"
echo "=============================="


if [ -f /var/log/auth.log ]
then

    grep "Failed password" /var/log/auth.log | wc -l

else

    echo "Authentication log file not found"

fi



echo ""
echo "=============================="
echo "Active Services"
echo "=============================="


systemctl --type=service --state=running



echo ""

echo "Security Check Completed"
