#!/bin/bash

echo "======================================"
echo " MUTEB SOC ONE CLICK REPAIR CODE 1"
echo "======================================"

PROJECT=$HOME/Muteb-SOC

cd $PROJECT || exit 1


echo "[1] Creating full backup..."

mkdir -p backup/full_repair_$(date +%s)

cp -r app backup/full_repair_$(date +%s)/ 2>/dev/null
cp run.py backup/full_repair_$(date +%s)/ 2>/dev/null


echo "[2] Restoring application.py if backup exists..."

BACKUP=$(find backup -path "*/app/core/application.py" | head -1)

if [ -f "$BACKUP" ]; then
    cp "$BACKUP" app/core/application.py
    echo "application.py restored"
fi


echo "[3] Checking Flask structure..."

python3 - <<'PY'

from pathlib import Path

p=Path("app/core/application.py")

text=p.read_text()

if "def create_app" not in text:
    print("ERROR: create_app missing")
    exit(1)

print("Flask structure OK")

PY


echo "[4] Fixing SQLAlchemy initialization..."

python3 - <<'PY'

from pathlib import Path

p=Path("app/core/application.py")

text=p.read_text()


if "db.init_app(app)" not in text:

    marker="app = Flask(__name__)"

    if marker in text:
        text=text.replace(
            marker,
            marker+"\n\n    from app.database.database import db\n    db.init_app(app)"
        )


text=text.replace(
"db.create_all()",
"""
with app.app_context():
        db.create_all()
"""
)


p.write_text(text)

print("SQLAlchemy patched")

PY



echo "[5] Python syntax check..."

python3 -m py_compile app/core/application.py

if [ $? -ne 0 ]; then
    echo "FAILED: application.py syntax error"
    exit 1
fi



echo "[6] Restart Backend..."

pkill -f "run.py" 2>/dev/null || true

sleep 2

nohup python3 run.py > backend.log 2>&1 &


sleep 6



echo "[7] Backend Port"

sudo ss -tulpn | grep 5000 || true



echo "[8] Backend Log"

tail -80 backend.log



echo "[9] Testing API"

curl -I http://localhost:5000 2>/dev/null || true



echo "======================================"
echo " REPAIR FINISHED"
echo "======================================"

