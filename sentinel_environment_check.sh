

#!/bin/bash


echo "MUTEB SOC Environment Check"


echo ""


echo "[+] Backend"


ps aux | grep python | grep run.py



echo ""


echo "[+] Frontend"


ps aux | grep vite | grep -v grep



echo ""


echo "[+] Ports"


ss -tulnp | grep -E "8000|5173"



