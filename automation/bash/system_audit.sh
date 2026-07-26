#!/bin/bash


# =====================================================
# Muteb SOC System Audit
#
# الهدف:
# جمع معلومات النظام الأساسية
#
# المعلومات:
# - Kernel
# - CPU
# - Memory
# - Storage
# - Network
# - Users
# =====================================================



echo "Starting System Audit"


echo ""

echo "System Hostname"

hostname



echo ""

echo "Kernel Information"

uname -r



echo ""

echo "CPU Information"

lscpu | grep "Model name"



echo ""

echo "Memory Information"

free -h



echo ""

echo "Disk Information"

df -h



echo ""

echo "Network Information"

ip addr



echo ""

echo "Current Users"

who



echo ""

echo "Audit Completed"
