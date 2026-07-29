#!/bin/bash

echo "=========================================="
echo " MUTEB SOC FINAL CERTIFICATION "
echo " Enterprise Production Validation "
echo "=========================================="

PROJECT=$(pwd)

REPORT="$PROJECT/MUTEB_FINAL_CERTIFICATION_REPORT.txt"

echo "MUTEB SOC FINAL CERTIFICATION REPORT" > $REPORT
echo "DATE: $(date)" >> $REPORT
echo "PROJECT: $PROJECT" >> $REPORT
echo "" >> $REPORT


echo "% 10 PROJECT ANALYSIS"

echo "[PROJECT SIZE]" >> $REPORT
du -sh . >> $REPORT


echo "[STRUCTURE]" >> $REPORT
find . -maxdepth 2 -type d \
-not -path "./node_modules*" \
-not -path "./.git*" | head -50 >> $REPORT



echo "% 20 BACKEND CHECK"


echo "[BACKEND SERVICE]" >> $REPORT

systemctl status muteb-backend.service \
--no-pager | head -20 >> $REPORT


echo "[BACKEND PORT]" >> $REPORT

ss -tulpn | grep 8000 >> $REPORT || echo "Backend port missing" >> $REPORT



echo "% 30 FRONTEND CHECK"


echo "[FRONTEND]" >> $REPORT

cat frontend/package.json | \
grep -E "react|vite|version|name" >> $REPORT



echo "[BUILD TEST]"

cd frontend

npm run build >> $REPORT 2>&1

cd ..



echo "% 40 DATABASE CHECK"


echo "[POSTGRESQL]" >> $REPORT

systemctl is-active postgresql >> $REPORT


sudo -u postgres psql -lqt | \
grep muteb >> $REPORT



echo "% 50 API SECURITY TEST"



echo "[HEALTH]" >> $REPORT

curl -s http://127.0.0.1:8000/health \
>> $REPORT || echo "Health Failed" >> $REPORT



echo "[LOGIN TEST]" >> $REPORT


curl -s \
-X POST \
http://127.0.0.1:8000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"Muteb@Admin2026"}' \
>> $REPORT



echo "% 60 SECURITY SCAN"



echo "[SECRETS CHECK]" >> $REPORT


grep -R \
-E "password=|SECRET_KEY=|JWT_SECRET" \
backend \
--exclude-dir=venv \
>> $REPORT



echo "% 70 SERVICES"



echo "[SERVICES]" >> $REPORT


systemctl is-active muteb-backend.service \
>> $REPORT


systemctl is-active muteb-frontend.service \
>> $REPORT


systemctl is-active nginx \
>> $REPORT



echo "% 80 NGINX CHECK"



nginx -t >> $REPORT 2>&1



echo "% 90 FINAL SYSTEM STATUS"



echo "========== FINAL STATUS ==========" >> $REPORT


echo "Backend:" >> $REPORT
systemctl is-active muteb-backend.service >> $REPORT


echo "Frontend:" >> $REPORT
systemctl is-active muteb-frontend.service >> $REPORT


echo "Database:" >> $REPORT
systemctl is-active postgresql >> $REPORT


echo "Nginx:" >> $REPORT
systemctl is-active nginx >> $REPORT



echo "% 100 COMPLETE"



echo ""
echo "=========================================="
echo " MUTEB SOC CERTIFICATION COMPLETE "
echo "=========================================="

echo ""

echo "REPORT:"
echo "$REPORT"

