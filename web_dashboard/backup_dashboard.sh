#!/bin/bash

BACKUP_DIR="backup"

DATE=$(date +"%Y%m%d_%H%M%S")


mkdir -p "$BACKUP_DIR"


tar -czf "$BACKUP_DIR/muteb_dashboard_$DATE.tar.gz" \
web_dashboard \
reports \
logs


echo "[+] Dashboard Backup Created"

