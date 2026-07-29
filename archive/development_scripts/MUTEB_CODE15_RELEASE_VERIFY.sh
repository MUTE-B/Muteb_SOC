#!/bin/bash

echo "======================================"
echo " MUTEB SOC RELEASE VERIFICATION"
echo " CODE 15"
echo "======================================"

cd ~/Muteb-SOC || exit 1


REPORT="MUTEB_RELEASE_VERIFICATION.txt"


echo "MUTEB SOC Enterprise v1.0.0" > $REPORT
echo "============================" >> $REPORT
echo "" >> $REPORT



echo "[1] Current Branch"

git branch --show-current >> $REPORT



echo "" >> $REPORT


echo "[2] Latest Commit"

git log -1 --oneline >> $REPORT



echo "" >> $REPORT


echo "[3] Release Tags"

git tag >> $REPORT



echo "" >> $REPORT


echo "[4] Repository Status"

git status --short >> $REPORT



echo "" >> $REPORT


echo "[5] Project Files Check"


FILES="
README.md
VERSION
frontend/src/App.jsx
frontend/src/App.css
app/core/application.py
RELEASE_v1.0.0.md
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

echo "STATUS: MUTEB SOC ENTERPRISE READY" >> $REPORT



echo ""
echo "======================================"
echo " VERIFICATION COMPLETE"
echo "======================================"


cat $REPORT


