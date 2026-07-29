#!/bin/bash


echo "======================================"
echo " MUTEB FINAL HARDENING"
echo " SECURITY RELEASE PREPARATION"
echo "======================================"


mkdir -p .github docs security



#################################
# GITIGNORE
#################################

cat > .gitignore <<'EOF'


__pycache__/

*.pyc

.env

*.log

.vscode/

.idea/

venv/

node_modules/

dist/

build/


