#!/bin/bash
#
# MUTEB SOC
# Evidence Collector
#


OUTPUT="incident/evidence_$(date +%F_%H-%M).txt"


echo "=== MUTEB SOC EVIDENCE COLLECTION ===" > "$OUTPUT"



echo "Hostname:" >> "$OUTPUT"

hostname >> "$OUTPUT"



echo "Users:" >> "$OUTPUT"

cat /etc/passwd >> "$OUTPUT"



echo "Processes:" >> "$OUTPUT"

ps aux >> "$OUTPUT"



echo "Network:" >> "$OUTPUT"

ss -tulnp >> "$OUTPUT"



echo "Logs:" >> "$OUTPUT"

tail -100 /var/log/auth.log >> "$OUTPUT"



echo "[+] Evidence Saved: $OUTPUT"

