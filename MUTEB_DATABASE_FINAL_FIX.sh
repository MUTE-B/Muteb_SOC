#!/bin/bash

echo "======================================"
echo " MUTEB SOC DATABASE FINAL FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup"

cp app/core/application.py app/core/application.py.before_db_fix


echo "[2] Writing database configuration"


cat > app/config/database_config.py <<'PY'

SQLALCHEMY_DATABASE_URI = "sqlite:///muteb_soc.db"
SQLALCHEMY_TRACK_MODIFICATIONS = False

PY



echo "[3] Updating application.py"


python3 - <<'PY'

from pathlib import Path

p=Path("app/core/application.py")

text=p.read_text()


if "app.config.from_object" not in text:

    text=text.replace(
        "app = Flask(__name__)",
        """
app = Flask(__name__)

app.config.from_mapping(
    SQLALCHEMY_DATABASE_URI="sqlite:///muteb_soc.db",
    SQLALCHEMY_TRACK_MODIFICATIONS=False
)
"""
    )


text=text.replace(
"db.init_app(app)",
"""
db.init_app(app)
"""
)


p.write_text(text)

print("application updated")

PY



echo "[4] Syntax Check"

python3 -m py_compile app/core/application.py



echo "[5] Restart Backend"

pkill -f "run.py" 2>/dev/null || true

sleep 2

nohup python3 run.py > backend.log 2>&1 &

sleep 5



echo "[6] STATUS"

sudo ss -tulpn | grep 8000 || true


echo "[7] LOG"

tail -50 backend.log


echo "======================================"
echo " DONE"
echo "======================================"

