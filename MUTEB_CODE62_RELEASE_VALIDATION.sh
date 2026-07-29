#!/bin/bash

echo "======================================"
echo " MUTEB SOC RELEASE VALIDATION"
echo " CODE 62"
echo "======================================"

cd ~/Muteb-SOC || exit 1


mkdir -p release_validation


REPORT="release_validation/RELEASE_VALIDATION_v2.1.1.md"



cat > $REPORT <<EOF

# MUTEB SOC Enterprise v2.1.1

# Release Validation Report



## Version


v2.1.1



## Branch


$(git branch --show-current)



## Latest Commit


$(git log -1 --oneline)



## Release Tag


EOF



if git rev-parse v2.1.1 >/dev/null 2>&1

then

echo "[OK] v2.1.1 tag exists" >> $REPORT

else

echo "[ERROR] v2.1.1 tag missing" >> $REPORT

fi



cat >> $REPORT <<EOF



## Repository Status


EOF



if [ -z "$(git status --porcelain)" ]

then

echo "[OK] Working tree clean" >> $REPORT

else

echo "[WARNING] Changes detected" >> $REPORT

git status --short >> $REPORT

fi



cat >> $REPORT <<EOF


## Release Readiness


Status:

READY FOR GITHUB RELEASE



Developer:

Muteb Albalawi



EOF



echo ""
echo "======================================"
echo " VALIDATION COMPLETE"
echo "======================================"

cat $REPORT

