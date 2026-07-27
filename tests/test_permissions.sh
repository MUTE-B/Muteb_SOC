#!/bin/bash


echo "=== PERMISSION TEST ==="


find . -name "*.sh" \
-type f \
| while read FILE

do

if [[ -x "$FILE" ]]

then

echo "[+] EXEC : $FILE"

else

echo "[-] NOT EXEC : $FILE"

fi


done

