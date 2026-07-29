#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE UI VERIFICATION"
echo " CODE 34"
echo "======================================"

cd ~/Muteb-SOC || exit 1


REPORT="UI_FINAL_VERIFICATION_REPORT.md"


echo "# MUTEB SOC UI Verification Report" > $REPORT
echo "" >> $REPORT
echo "Date: $(date)" >> $REPORT
echo "" >> $REPORT



echo "[1] Frontend Check"


if curl -s http://localhost:5173 > /dev/null
then

echo "Frontend: OK" >> $REPORT
echo "Frontend: OK"

else

echo "Frontend: FAILED" >> $REPORT
echo "Frontend: FAILED"

fi



echo ""
echo "[2] Backend Check"


if curl -s http://localhost:8000 > /dev/null
then

echo "Backend: OK" >> $REPORT
echo "Backend: OK"

else

echo "Backend: FAILED" >> $REPORT
echo "Backend: FAILED"

fi



echo ""
echo "[3] UI Files"


FILES="
frontend/src/App.jsx
frontend/src/App.css
frontend/src/main.jsx
frontend/index.html
"



for FILE in $FILES

do

if [ -f "$FILE" ]

then

echo "OK: $FILE" >> $REPORT

else

echo "MISSING: $FILE" >> $REPORT

fi

done



echo ""
echo "[4] Network"


echo "Frontend URL:" >> $REPORT
echo "http://172.20.10.4:5173" >> $REPORT

echo "Backend URL:" >> $REPORT
echo "http://172.20.10.4:8000" >> $REPORT



echo ""
echo "======================================"
echo " UI VERIFICATION COMPLETE"
echo "======================================"



cat $REPORT


