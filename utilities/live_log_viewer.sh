#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Live Log Viewer
# ==========================================================


live_log_viewer() {


print_title "LIVE LOG VIEWER"


LOG_FILE="/var/log/auth.log"


if [[ ! -f "$LOG_FILE" ]]
then

echo "Log file not found"

return

fi


echo

echo "Monitoring: $LOG_FILE"

echo

tail -f "$LOG_FILE"


}


