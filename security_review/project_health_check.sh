#!/bin/bash

echo "================================"
echo " MUTEB SOC FINAL HEALTH CHECK"
echo "================================"


echo

echo "[+] Git Status"

git status --short


echo

echo "[+] Shell Scripts"

find . -name "*.sh" | wc -l


echo

echo "[+] Python Modules"

find . -name "*.py" | wc -l


echo

echo "[+] Project Size"

du -sh .


echo

echo "[+] Health Check Completed"

