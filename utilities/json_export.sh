#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# JSON Export Engine
# ==========================================================

json_export() {

print_title "JSON REPORT"

JSON_FILE="$REPORT_DIR/report_$(date +%F_%H-%M-%S).json"

cat > "$JSON_FILE" <<JSON
{
  "project":"MUTEB SOC",
  "version":"$APP_VERSION",
  "date":"$(date --iso-8601=seconds)",
  "hostname":"$(hostname)",
  "kernel":"$(uname -r)",
  "architecture":"$(uname -m)",
  "user":"$(whoami)",
  "uptime":"$(uptime -p)",
  "cpu_cores":"$(nproc)",
  "memory":{
      "total":"$(free -h | awk '/Mem:/ {print $2}')",
      "used":"$(free -h | awk '/Mem:/ {print $3}')"
  },
  "disk":{
      "total":"$(df -h / | awk 'NR==2 {print $2}')",
      "used":"$(df -h / | awk 'NR==2 {print $3}')",
      "usage":"$(df -h / | awk 'NR==2 {print $5}')"
  },
  "network":{
      "ip":"$(hostname -I | awk '{print $1}')"
  }
}
JSON

print_success "JSON Report Saved"
echo "$JSON_FILE"

}

