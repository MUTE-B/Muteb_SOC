#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL ENTERPRISE AUDIT"
echo " CODE 28"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo ""
echo "[1] PROJECT VERSION"

cat VERSION 2>/dev/null || echo "VERSION FILE NOT FOUND"



echo ""
echo "[2] GIT STATUS"

git status



echo ""
echo "[3] CURRENT BRANCH"

git branch --show-current



echo ""
echo "[4] LATEST COMMIT"

git log -1 --oneline



echo ""
echo "[5] RELEASE TAGS"

git tag | tail -10



echo ""
echo "[6] BACKEND CHECK"

curl -s http://localhost:8000/api/health || echo "Backend not responding"



echo ""
echo "[7] FRONTEND CHECK"

curl -I -s http://localhost:5173 | head -1 || echo "Frontend not responding"



echo ""
echo "[8] CORE FILES"


FILES="
README.md
ARCHITECTURE.md
PROJECT_OVERVIEW.md
RELEASE_NOTES.md
RELEASE_V2.1.1.md
portfolio/PROJECT_SHOWCASE.md
frontend/src/App.jsx
frontend/src/App.css
app/core/application.py
"


for FILE in $FILES
do

if [ -f "$FILE" ]

then

echo "OK   $FILE"

else

echo "MISS $FILE"

fi

done



echo ""
echo "======================================"
echo " MUTEB SOC AUDIT COMPLETE"
echo "======================================"

