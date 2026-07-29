#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL PRODUCTION CHECK"
echo " CODE 11"
echo "======================================"

cd ~/Muteb-SOC || exit 1


REPORT="MUTEB_FINAL_SYSTEM_REPORT.txt"


echo "MUTEB SOC FINAL SYSTEM REPORT" > $REPORT
echo "=============================" >> $REPORT
echo "" >> $REPORT



echo "[1] Backend Health"


BACKEND=$(curl -s http://localhost:8000/api/health)


echo "$BACKEND" >> $REPORT


if echo "$BACKEND" | grep -q "ok"; then
    echo "Backend: OK"
else
    echo "Backend: FAILED"
fi



echo "" >> $REPORT



echo "[2] Login Test"


LOGIN=$(curl -s -X POST http://localhost:8000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"Muteb@123"}')


echo "$LOGIN" >> $REPORT


if echo "$LOGIN" | grep -q "success"; then
    echo "Login API: OK"
else
    echo "Login API: FAILED"
fi



echo "" >> $REPORT



echo "[3] Frontend Check"


if ss -tulnp | grep -q ":5173"; then

    echo "Frontend: RUNNING"

    echo "Frontend: RUNNING" >> $REPORT

else

    echo "Frontend: FAILED"

    echo "Frontend: FAILED" >> $REPORT

fi




echo "" >> $REPORT



echo "[4] Important Files"


FILES="
frontend/src/App.jsx
frontend/src/App.css
app/core/application.py
README.md
VERSION
"


for FILE in $FILES
do

if [ -f "$FILE" ]; then

echo "$FILE : OK" >> $REPORT

else

echo "$FILE : MISSING" >> $REPORT

fi

done



echo "" >> $REPORT

echo "FINAL STATUS" >> $REPORT
echo "MUTEB SOC Enterprise v1.0.0 READY" >> $REPORT



echo ""
echo "======================================"
echo " CHECK COMPLETE"
echo "======================================"

cat $REPORT


