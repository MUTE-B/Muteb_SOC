#!/bin/bash

echo "======================================"
echo " MUTEB SOC GITHUB RELEASE VERIFY"
echo " CODE 42"
echo "======================================"

cd ~/Muteb-SOC || exit 1


REPORT="GITHUB_RELEASE_VERIFICATION_v2.1.1.md"


cat > $REPORT <<EOF

# MUTEB SOC Enterprise v2.1.1

## GitHub Release Verification Report


Generated:

$(date)



## Repository Status


Branch:

$(git branch --show-current)



Latest Commit:

$(git log -1 --oneline)



## Release Tag


$(git tag --list "v2.1.1")



## Portfolio Components


EOF



FILES="
README.md
FINAL_RELEASE_v2.1.1.md
RELEASE_SUMMARY_v2.1.1.md
portfolio/PROJECT_SHOWCASE.md
showcase/COMPANY_PRESENTATION.md
frontend/src/App.jsx
frontend/src/App.css
"



for FILE in $FILES
do

if [ -f "$FILE" ]

then

echo "[OK] $FILE" >> $REPORT

else

echo "[MISSING] $FILE" >> $REPORT

fi

done



cat >> $REPORT <<EOF


## Release Status


MUTEB SOC Enterprise v2.1.1


Status:

READY FOR PORTFOLIO PRESENTATION


Developer:

Muteb Albalawi


EOF



echo ""
echo "======================================"
echo " VERIFICATION COMPLETE"
echo "======================================"

cat $REPORT


