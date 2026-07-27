#!/bin/bash

# ==========================================================
# الهدف:
# تنظيف الملفات المؤقتة.
# ==========================================================

find . -type f -name "*.pyc" -delete

find . -type d -name "__pycache__" -exec rm -rf {} +

find . -type f -name "*.tmp" -delete

echo

echo "Temporary files removed successfully."
