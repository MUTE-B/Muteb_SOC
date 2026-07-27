#!/bin/bash


echo "================================"
echo " DEPENDENCY CHECK"
echo "================================"


if [[ -f requirements.txt ]]

then

echo "[+] requirements.txt Found"

else

echo "[-] requirements.txt Missing"

fi


python3 --version

bash --version | head -1


echo

echo "[+] Dependency Check Completed"

