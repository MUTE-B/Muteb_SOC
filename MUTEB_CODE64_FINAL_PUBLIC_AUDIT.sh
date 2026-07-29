#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL PUBLIC AUDIT"
echo " CODE 64"
echo "======================================"

cd ~/Muteb-SOC || exit 1


mkdir -p final_audit


REPORT="final_audit/PUBLIC_AUDIT_REPORT.md"



cat > $REPORT <<EOF

# MUTEB SOC Enterprise v2.1.1

# Final Public Repository Audit



Date:

$(date)



## Git Status


Branch:

$(git branch --show-current)


Latest Commit:

$(git log -1 --oneline)



## Version


$(cat VERSION 2>/dev/null)



EOF



echo "## Repository Size" >> $REPORT

du -sh . >> $REPORT



echo "" >> $REPORT

echo "## Main Files" >> $REPORT



FILES="
README.md
ARCHITECTURE.md
PROJECT_OVERVIEW.md
frontend/src/App.jsx
frontend/src/App.css
app/api/auth_final.py
final_delivery/
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

echo "## Security Scan" >> $REPORT



if grep -RniE \
"password=|secret=|api_key=|token=|CHANGE_PASSWORD" \
--exclude-dir=node_modules \
--exclude-dir=.git \
--exclude-dir=archive \
. >/dev/null 2>&1

then

echo "[REVIEW REQUIRED] Sensitive pattern found" >> $REPORT

else

echo "[OK] No sensitive patterns found" >> $REPORT

fi



echo "" >> $REPORT

echo "## Working Tree" >> $REPORT



if [ -z "$(git status --porcelain)" ]

then

echo "[OK] Clean" >> $REPORT

else

echo "[WARNING] Changes exist" >> $REPORT

git status --short >> $REPORT

fi



echo ""
echo "======================================"
echo " AUDIT FINISHED"
echo "======================================"

cat $REPORT


