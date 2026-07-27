#!/bin/bash


SERVICE_FILE="systemd/muteb-soc-dashboard.service"


echo "[+] Installing MUTEB SOC Dashboard Service"


sudo cp "$SERVICE_FILE" /etc/systemd/system/


sudo systemctl daemon-reload


sudo systemctl enable muteb-soc-dashboard.service


echo "[+] Service Installed"


echo "Start with:"

echo "sudo systemctl start muteb-soc-dashboard"

