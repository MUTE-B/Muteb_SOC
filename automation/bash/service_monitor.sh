#!/bin/bash


# =====================================================
# Muteb SOC Service Monitor
#
# الهدف:
# مراقبة خدمات Linux الأساسية
#
# الفحوصات:
# - SSH Service
# - Firewall Service
# - Cron Service
# - Network Service
# - Running Services
# =====================================================



echo "Starting Service Monitoring"



# إنشاء قائمة بالخدمات المهمة

SERVICES=(
"ssh"
"cron"
"ufw"
"NetworkManager"
)



echo ""

echo "=============================="
echo "Important Services Status"
echo "=============================="



# المرور على كل خدمة وفحص حالتها

for SERVICE in "${SERVICES[@]}"
do


    echo ""

    echo "Checking service: $SERVICE"


    systemctl status "$SERVICE" --no-pager | grep Active


done



echo ""

echo "=============================="
echo "Running Services"
echo "=============================="


systemctl list-units --type=service --state=running



echo ""

echo "Service Monitoring Completed"
