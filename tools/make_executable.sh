#!/bin/bash

# ==========================================================
# الهدف:
# منح جميع سكربتات المشروع صلاحية التنفيذ.
# ==========================================================

find . -type f -name "*.sh" -exec chmod +x {} \;

find . -type f -name "*.py" -exec chmod +x {} \;

echo

echo "Executable permissions applied successfully."
