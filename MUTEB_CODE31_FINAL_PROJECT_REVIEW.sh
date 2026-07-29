#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL PROJECT REVIEW"
echo " CODE 31"
echo "======================================"

cd ~/Muteb-SOC || exit 1


REPORT="FINAL_PROJECT_REVIEW_REPORT.md"


cat > $REPORT <<EOF

# MUTEB SOC Enterprise v2.1.1

## Final Project Review Report


Date:
$(date)


## Version

$(cat VERSION 2>/dev/null)



## Git Information


Branch:

$(git branch --show-current)


Latest Commit:

$(git log -1 --oneline)



## Core Components


EOF



echo "Checking files..."


FILES="
README.md
ARCHITECTURE.md
PROJECT_OVERVIEW.md
RELEASE_V2.1.1.md
portfolio/PROJECT_SHOWCASE.md
showcase/COMPANY_PRESENTATION.md
frontend/src/App.jsx
frontend/src/App.css
app/core/application.py
"



for FILE in $FILES
do

if [ -f "$FILE" ]

then

echo "OK - $FILE" >> $REPORT

else

echo "MISSING - $FILE" >> $REPORT

fi

done



echo "" >> $REPORT
echo "## Services" >> $REPORT
echo "" >> $REPORT



echo "Backend:" >> $REPORT

curl -s http://localhost:8000/api/health >> $REPORT || echo "Backend unavailable" >> $REPORT



echo "" >> $REPORT


echo "Frontend:" >> $REPORT

curl -I -s http://localhost:5173 | head -1 >> $REPORT || echo "Frontend unavailable" >> $REPORT



echo ""
echo "======================================"
echo " REVIEW CREATED"
echo "======================================"



cat $REPORT


