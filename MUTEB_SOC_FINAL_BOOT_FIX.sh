#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL BOOT FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Fixing application blueprint..."

python3 - <<'PY'

from pathlib import Path

p=Path("app/core/application.py")

text=p.read_text()

text=text.replace(
"from app.api.soc import soc_bp\n        app.register_blueprint(soc_bp)",
"from app.api.soc import soc\n        app.register_blueprint(soc)"
)

p.write_text(text)

print("Blueprint fixed")

PY



echo "[2] Fixing Flask database configuration..."

python3 - <<'PY'

from pathlib import Path

files=[
"app/core/application.py",
"app/config/settings.py",
"app/core/config.py"
]


for f in files:

    p=Path(f)

    if p.exists():

        t=p.read_text()

        if "SQLALCHEMY_DATABASE_URI" not in t:

            t += """



SQLALCHEMY_DATABASE_URI = "sqlite:///muteb_soc.db"
SQLALCHEMY_TRACK_MODIFICATIONS = False

"""

            p.write_text(t)

            print("Updated",f)

PY



echo "[3] Rebuild frontend environment..."

echo "VITE_API_URL=http://localhost:8000" > frontend/.env



echo "[4] Restart Backend..."

pkill -f "run.py" 2>/dev/null || true

sleep 2

nohup python3 run.py > backend.log 2>&1 &


sleep 5



echo "[5] STATUS"

sudo ss -tulpn | grep 8000 || true


echo "[6] LOG"

tail -60 backend.log


echo "======================================"
echo " FINISHED"
echo "======================================"

