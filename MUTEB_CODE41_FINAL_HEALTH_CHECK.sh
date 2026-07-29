#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL ENTERPRISE HEALTH CHECK"
echo " CODE 41"
echo "======================================"

cd ~/Muteb-SOC || exit 1


REPORT="FINAL_HEALTH_CHECK_REPORT.md"


echo "# MUTEB SOC Enterprise v2.1.1" > $REPORT
echo "" >> $REPORT
echo "Final Health Check Report" >> $REPORT
echo "Date: $(date)" >> $REPORT
echo "" >> $REPORT



echo "## Version" >> $REPORT
cat VERSION >> $REPORT
echo "" >> $REPORT



echo "## Git Branch" >> $REPORT

git branch --show-current >> $REPORT

echo "" >> $REPORT



echo "## Latest Commit" >> $REPORT

git log -1 --oneline >> $REPORT

echo "" >> $REPORT



echo "## Tags" >> $REPORT

git tag | tail -10 >> $REPORT

echo "" >> $REPORT



echo "## Required Files" >> $REPORT


FILES="
README.md
ARCHITECTURE.md
PROJECT_OVERVIEW.md
FINAL_RELEASE_v2.1.1.md
portfolio/PROJECT_SHOWCASE.md
showcase/README.md
frontend/src/App.jsx
frontend/src/App.css
app/core/application.py
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



echo "" >> $REPORT
echo "## Services" >> $REPORT



echo "Backend:" >> $REPORT

curl -s http://localhost:8000/api/health >> $REPORT || echo "Backend unavailable" >> $REPORT



echo "" >> $REPORT


echo "Frontend:" >> $REPORT

curl -I -s http://localhost:5173 | head -1 >> $REPORT || echo "Frontend unavailable" >> $REPORT



echo ""
echo "======================================"
echo " HEALTH CHECK COMPLETE"
echo "======================================"



cat $REPORT


