#!/bin/bash

BACKUP_FILE=$1


if [ -z "$BACKUP_FILE" ]; then

    echo "Usage: ./restore_dashboard.sh backup_file.tar.gz"

    exit 1

fi


tar -xzf "$BACKUP_FILE" -C .


echo "[+] Dashboard Restore Completed"

