#!/bin/bash
#
# MUTEB SOC
# Python Syntax Test
#


echo "=== PYTHON TEST ==="



find automation hunting threat_intel incident -name "*.py" | while read FILE

do


python3 -m py_compile "$FILE"


if [[ $? -eq 0 ]]

then

echo "[+] OK : $FILE"


else

echo "[-] ERROR : $FILE"


fi


done

