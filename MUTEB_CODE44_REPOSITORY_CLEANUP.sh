#!/bin/bash

echo "======================================"
echo " MUTEB SOC REPOSITORY CLEANUP"
echo " CODE 44"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Create archive folders"


mkdir -p archive/backups
mkdir -p archive/scripts



echo "[2] Move old backup files"


find . -maxdepth 3 \
-name "*.backup*" \
-o -name "*.bak" \
-o -name "*.old" \
| while read FILE

do

if [ -f "$FILE" ]

then

mv "$FILE" archive/backups/

fi

done



echo "[3] Move old repair scripts"


find . -maxdepth 1 \
-name "MUTEB_*FIX*" \
-o -name "MUTEB_*BACKUP*" \
-o -name "MUTEB_*REPAIR*"


echo ""
echo "Review above files before moving."



echo "[4] Update gitignore"


cat >> .gitignore <<'EOF'


# MUTEB SOC Temporary Files

*.backup
*.backup*
*.bak
*.old

frontend.log
backend.pid
frontend.pid

__pycache__/
*.pyc

node_modules/

.env

archive/

EOF



echo "[5] Status"

git status --short



echo ""
echo "======================================"
echo " CLEANUP PREPARED"
echo "======================================"

