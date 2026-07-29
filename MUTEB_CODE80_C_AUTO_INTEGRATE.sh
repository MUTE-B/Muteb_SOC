#!/bin/bash

echo "======================================"
echo " MUTEB SENTINEL X AUTO INTEGRATION"
echo "======================================"


TARGET=$(grep -R "Flask(__name__)" app -l | head -1)


if [ -z "$TARGET" ]; then

echo "ERROR: Flask application file not found"

exit 1

fi


echo "FOUND APPLICATION:"
echo "$TARGET"


cp "$TARGET" "$TARGET.backup_sentinel"


if grep -q "enable_sentinel" "$TARGET"; then

echo "Sentinel X already integrated"

else


python3 - <<PY

path="$TARGET"

with open(path,"r") as f:
    data=f.read()


inject="""

# MUTEB SOC SENTINEL X INTEGRATION

from app.sentinel_x.enable import enable_sentinel

enable_sentinel(app)

"""


data=data.replace(
"app = Flask(__name__)",
"app = Flask(__name__)"+inject
)


with open(path,"w") as f:
    f.write(data)

PY


echo "✓ SENTINEL X REGISTERED"


fi



echo ""
echo "BACKUP CREATED:"
echo "$TARGET.backup_sentinel"


echo ""
echo "======================================"
echo " INTEGRATION COMPLETE"
echo "======================================"

