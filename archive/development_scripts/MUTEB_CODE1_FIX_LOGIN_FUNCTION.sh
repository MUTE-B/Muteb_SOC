#!/bin/bash

echo "======================================"
echo " MUTEB SOC LOGIN FUNCTION FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


python3 - <<'PY'

from pathlib import Path

p = Path("frontend/src/App.jsx")

text = p.read_text()


# إضافة import
if 'import { login as authLogin } from "./api/auth";' not in text:

    text=text.replace(
        'import "./App.css";',
        'import "./App.css";\nimport { login as authLogin } from "./api/auth";'
    )


# إصلاح الاستدعاء
text=text.replace(
    'const result = await login(username,password);',
    'const result = await authLogin(username,password);'
)


p.write_text(text)

print("App.jsx fixed")

PY


echo "[Restart Frontend]"

pkill -f vite 2>/dev/null || true

sleep 3

cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " DONE"
echo "======================================"

tail -20 ../frontend.log

