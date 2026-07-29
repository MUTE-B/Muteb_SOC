#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL TAG VERIFICATION"
echo " CODE 58"
echo "======================================"

cd ~/Muteb-SOC || exit 1


REPORT="FINAL_TAG_VERIFICATION_v2.1.1.md"



cat > $REPORT <<EOF

# MUTEB SOC Enterprise v2.1.1

## Final Tag Verification


Date:

$(date)



## Current Branch


$(git branch --show-current)



## Latest Commit


$(git log -1 --oneline)



## Current Version


$(cat VERSION 2>/dev/null)



## Available Tags


$(git tag --list)



## Release Information


Expected Release:

v2.1.1


Status:

Portfolio Release Candidate



EOF



echo "[1] Checking tag v2.1.1"



if git rev-parse v2.1.1 >/dev/null 2>&1

then

echo "[OK] Tag v2.1.1 exists" >> $REPORT

else

echo "[WARNING] Tag v2.1.1 missing" >> $REPORT

fi



echo "" >> $REPORT

echo "## Working Tree" >> $REPORT


if [ -z "$(git status --porcelain)" ]

then

echo "[OK] Clean working tree" >> $REPORT

else

echo "[WARNING] Uncommitted changes" >> $REPORT

git status --short >> $REPORT

fi



echo ""
echo "======================================"
echo " TAG VERIFICATION COMPLETE"
echo "======================================"



cat $REPORT


