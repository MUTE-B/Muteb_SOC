#!/bin/bash

echo "======================================"
echo " MUTEB SOC GITHUB CLEAN PREPARATION"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Create .gitignore"


cat > .gitignore <<'EOF'
# Python
__pycache__/
*.pyc
venv/
.env

# Database
*.db
*.sqlite3

# Logs
*.log

# Node
frontend/node_modules/
frontend/dist/

# Backups
*.backup
*.before*
*.broken*
*.failed*
MUTEB_*.sh

# Temporary
.tmp/
EOF



echo "[2] Remove temporary files from tracking area"


find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true


echo "[3] Check clean status"


git status


echo ""
echo "======================================"
echo " READY FOR COMMIT"
echo "======================================"

