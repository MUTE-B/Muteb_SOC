#!/bin/bash

set -e

PROJECT=$(pwd)
BACKUP="$PROJECT/final_backup_$(date +%s)"

echo "% 10 BACKUP"

mkdir -p "$BACKUP"

cp backend/app.py "$BACKUP/" 2>/dev/null || true


echo "% 20 ENV SECURITY"


cd backend


if [ ! -f .env ]; then

cat > .env <<ENV
JWT_SECRET=$(openssl rand -hex 32)
DATABASE_PASSWORD=$(openssl rand -hex 16)
ADMIN_PASSWORD=$(openssl rand -hex 16)
ENV

fi


./venv/bin/pip install python-dotenv flask-limiter reportlab



echo "% 30 CREATE SECURITY CONFIG"


cat > security_config.py <<'PY'
import os
from dotenv import load_dotenv

load_dotenv()

JWT_SECRET=os.getenv(
"JWT_SECRET",
"CHANGE_ME"
)

DATABASE_PASSWORD=os.getenv(
"DATABASE_PASSWORD"
)

ADMIN_PASSWORD=os.getenv(
"ADMIN_PASSWORD"
)
PY



echo "% 40 DATABASE TABLES"



cat > production_database.py <<'PY'

import psycopg2


def migrate():

    con=psycopg2.connect(
        database="muteb_soc",
        user="muteb_admin",
        password="MutebDB@2026",
        host="localhost"
    )

    cur=con.cursor()


    cur.execute("""

    CREATE TABLE IF NOT EXISTS scans(

    id SERIAL PRIMARY KEY,

    target TEXT,

    risk TEXT,

    created TIMESTAMP DEFAULT NOW()

    );


    CREATE TABLE IF NOT EXISTS findings(

    id SERIAL PRIMARY KEY,

    scan_id INTEGER,

    issue TEXT,

    severity TEXT

    );


    CREATE TABLE IF NOT EXISTS reports(

    id SERIAL PRIMARY KEY,

    scan_id INTEGER,

    format TEXT,

    path TEXT

    );


    CREATE INDEX IF NOT EXISTS idx_scan_target

    ON scans(target);


    """)


    con.commit()

    con.close()


if __name__=="__main__":

    migrate()

PY



./venv/bin/python production_database.py



echo "% 60 PASSWORD HASH CHECK"



cat > password_security.py <<'PY'

from werkzeug.security import generate_password_hash,check_password_hash


def hash_password(password):

    return generate_password_hash(password)



def verify(password,hashed):

    return check_password_hash(
        hashed,
        password
    )

PY



echo "% 70 SECURITY HEADERS"


cat > security_headers.py <<'PY'


def apply_headers(response):

    response.headers["X-Frame-Options"]="DENY"

    response.headers["X-Content-Type-Options"]="nosniff"

    response.headers["Strict-Transport-Security"]="max-age=31536000"

    response.headers["Content-Security-Policy"]="default-src 'self'"


    return response

PY



echo "% 80 LOGIN RATE LIMIT"



cat > rate_limit.py <<'PY'

from flask_limiter import Limiter
from flask_limiter.util import get_remote_address


limiter=Limiter(

key_func=get_remote_address,

default_limits=["200 per day"]

)


PY



echo "% 100 SECURITY MODULE COMPLETE"


