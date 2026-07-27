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
#!/bin/bash


# =====================================================
# Muteb SOC Service Monitor Script
#
# الهدف:
# مراقبة خدمات Linux المهمة
#
# يقوم السكربت بـ:
# - فحص حالة الخدمات
# - اكتشاف الخدمات المتوقفة
# - إنشاء تقرير مراقبة
# =====================================================



# إيقاف السكربت عند حدوث خطأ

set -e



# ملف التقرير

REPORT="service_monitor_report.txt"



# حذف التقرير القديم

rm -f $REPORT





echo "=================================" >> $REPORT

echo "    Muteb SOC Service Monitor     " >> $REPORT

echo "=================================" >> $REPORT



echo "" >> $REPORT





# =====================================================
# الخدمات المهمة
# =====================================================


SERVICES=(

"ssh"

"ufw"

"apache2"

)





# =====================================================
# فحص الخدمات
# =====================================================


echo "[+] Checking Services" >> $REPORT



for SERVICE in "${SERVICES[@]}"

do


    echo "" >> $REPORT


    echo "Service: $SERVICE" >> $REPORT



    STATUS=$(systemctl is-active $SERVICE 2>/dev/null || true)



    if [ "$STATUS" == "active" ]

    then


        echo "Status: RUNNING" >> $REPORT



    else


        echo "Status: NOT RUNNING" >> $REPORT



    fi



done





# =====================================================
# عرض جميع الخدمات العاملة
# =====================================================


echo "" >> $REPORT

echo "[+] Running Services" >> $REPORT



systemctl --type=service --state=running >> $REPORT





# =====================================================
# نهاية التقرير
# =====================================================


echo "" >> $REPORT

echo "Service Monitoring Completed" >> $REPORT



echo "================================="

echo "Service Monitor Finished"

echo "Report saved: $REPORT"

echo "================================="
