#!/bin/bash


echo "================================"
echo " MUTEB SOC FULL TEST"
echo "================================"


bash tests/test_structure.sh

echo

bash tests/test_python.sh

echo

bash tests/test_permissions.sh


echo

echo "[+] TEST COMPLETED"

