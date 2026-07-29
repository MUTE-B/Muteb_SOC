#!/bin/bash

echo "======================================"
echo " MUTEB SOC PUBLIC REPOSITORY REVIEW"
echo " CODE 48"
echo "======================================"

cd ~/Muteb-SOC || exit 1


REPORT="PUBLIC_REPOSITORY_REVIEW.md"


cat > $REPORT <<EOF

# MUTEB SOC Enterprise v2.1.1

## Public Repository Review


Generated:

$(date)



## Repository


Branch:

$(git branch --show-current)



Latest Commit:

$(git log -1 --oneline)



## Version


$(cat VERSION 2>/dev/null)



## Main Project Files


EOF



FILES="
README.md
ARCHITECTURE.md
PROJECT_OVERVIEW.md
FINAL_RELEASE_v2.1.1.md
frontend/src/App.jsx
frontend/src/App.css
app/api/auth_final.py
portfolio/
showcase/
"



for FILE in $FILES

do

if [ -e "$FILE" ]

then

echo "[OK] $FILE" >> $REPORT

else

echo "[MISSING] $FILE" >> $REPORT

fi

done



echo "" >> $REPORT
echo "## Security Check" >> $REPORT


if grep -RniE "password=|secret=|api_key=|token=" \
--exclude-dir=node_modules \
--exclude-dir=.git \
--exclude-dir=archive \
. >/dev/null 2>&1

then

echo "[WARNING] Sensitive pattern detected" >> $REPORT

else

echo "[OK] No sensitive patterns detected" >> $REPORT

fi



echo "" >> $REPORT
echo "## Git Status" >> $REPORT

git status --short >> $REPORT



echo ""
echo "======================================"
echo " REVIEW COMPLETE"
echo "======================================"

cat $REPORT


