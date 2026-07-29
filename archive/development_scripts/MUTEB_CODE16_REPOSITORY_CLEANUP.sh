#!/bin/bash

echo "======================================"
echo " MUTEB SOC REPOSITORY CLEANUP"
echo " CODE 16"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup gitignore"

cp .gitignore .gitignore.before_cleanup 2>/dev/null || true



echo "[2] Update gitignore"



cat >> .gitignore <<'EOF'


# =========================
# MUTEB SOC Cleanup
# =========================

# Python
__pycache__/
*.pyc
*.pyo
*.pyd


# Virtual Environment
venv/
.env


# Node
node_modules/
dist/


# Logs
*.log
logs/


# Runtime
*.pid


# Database
*.db
*.sqlite


# Backups
*.backup
*.bak
*_backup/
backup/
backups/


# Temporary Reports
*.tmp


# IDE
.vscode/
.idea/


EOF




echo "[3] Remove ignored files from Git tracking"

git rm -r --cached . 2>/dev/null || true


echo "[4] Re-add Clean Project"

git add .



echo "[5] Status"

git status --short



echo ""
echo "======================================"
echo " CLEANUP COMPLETE"
echo "======================================"

echo "Review status before commit"

