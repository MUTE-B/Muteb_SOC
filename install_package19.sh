
#!/bin/bash


echo "Installing MUTEB SOC Package 19 - Docker Production"



mkdir -p docker



# =====================================
# Dockerfile
# =====================================


cat > Dockerfile <<'EOF'

FROM python:3.12-slim


WORKDIR /app


COPY requirements.txt .


RUN pip install --no-cache-dir -r requirements.txt


COPY . .


EXPOSE 8000


CMD ["gunicorn",
"--bind",
"0.0.0.0:8000",
"run:app"]

EOF





# =====================================
# Docker Requirements
# =====================================


cat > docker/requirements.production.txt <<'EOF'

flask
flask-cors
flask-sqlalchemy
flask-jwt-extended
gunicorn

EOF





# =====================================
# Docker Compose
# =====================================


cat > docker-compose.yml <<'EOF'

version: "3.9"


services:


  muteb-soc:


    container_name:
      muteb-soc-enterprise


    build:
      .


    ports:

      - "8000:8000"


    volumes:

      - ./instance:/app/instance

      - ./logs:/app/logs

      - ./reports:/app/reports


    restart:
      always



EOF





# =====================================
# Production Environment
# =====================================


cat > .env.production <<'EOF'

FLASK_ENV=production

SECRET_KEY=MUTEB-SOC-PRODUCTION-KEY

JWT_SECRET_KEY=MUTEB-SOC-JWT-PRODUCTION-KEY

DATABASE_URL=sqlite:///muteb_soc.db

EOF





# =====================================
# Gunicorn Config
# =====================================


cat > gunicorn.conf.py <<'PY'


bind="0.0.0.0:8000"


workers=4


timeout=120


accesslog="-"


errorlog="-"


PY





# =====================================
# Production Start Script
# =====================================


cat > start_production.sh <<'SH'


#!/bin/bash


echo "Starting MUTEB SOC Production"


docker compose up -d --build


SH



chmod +x start_production.sh





python3 -m compileall app



echo "================================"
echo "PACKAGE 19 COMPLETE"
echo "DOCKER PRODUCTION READY"
echo "================================"


