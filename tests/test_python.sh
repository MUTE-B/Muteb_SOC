#!/bin/bash

echo "=== PYTHON TEST ==="


find automation threat_intel incident hunting \
-name "*.py" \
-type f \
| while read FILE

do

python3 -m py_compile "$FILE"


if [[ $? -eq 0 ]]

then

echo "[+] OK : $FILE"

else

echo "[-] ERROR : $FILE"

fi


done

