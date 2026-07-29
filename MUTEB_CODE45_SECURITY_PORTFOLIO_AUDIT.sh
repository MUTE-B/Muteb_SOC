#!/bin/bash

echo "======================================"
echo " MUTEB SOC SECURITY PORTFOLIO AUDIT"
echo " CODE 45"
echo "======================================"

cd ~/Muteb-SOC || exit 1


REPORT="SECURITY_PORTFOLIO_AUDIT_REPORT.md"


cat > $REPORT <<EOF

# MUTEB SOC Enterprise v2.1.1

## Security & Portfolio Audit Report


Date:

$(date)



EOF



echo "## Sensitive Files Check" >> $REPORT
echo "" >> $REPORT


FILES="
.env
.env.production
id_rsa
credentials.json
secrets.yaml
"



for FILE in $FILES

do

if [ -e "$FILE" ]

then

echo "[WARNING] Sensitive file found: $FILE" >> $REPORT

else

echo "[OK] $FILE not found" >> $REPORT

fi

done



echo "" >> $REPORT
echo "## Password Pattern Scan" >> $REPORT


grep -RniE \
"password=|secret=|api_key=|token=" \
--exclude-dir=node_modules \
--exclude-dir=.git \
. \
>> $REPORT 2>/dev/null



echo "" >> $REPORT
echo "## Git Status" >> $REPORT

git status --short >> $REPORT



echo "" >> $REPORT
echo "## Repository Status" >> $REPORT

echo "Branch:" >> $REPORT
git branch --show-current >> $REPORT


echo "Latest Commit:" >> $REPORT
git log -1 --oneline >> $REPORT



echo ""
echo "======================================"
echo " AUDIT COMPLETE"
echo "======================================"

cat $REPORT


