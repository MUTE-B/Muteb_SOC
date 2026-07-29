#!/bin/bash


echo "======================================"
echo " MUTEB PRODUCTION DEPLOYMENT LAYER"
echo "======================================"


mkdir -p deployment/nginx
mkdir -p deployment/gunicorn
mkdir -p docker



####################################
# GUNICORN CONFIG
####################################


cat > deployment/gunicorn/gunicorn_config.py <<'PY'


bind = "0.0.0.0:8000"

workers = 4

timeout = 120

accesslog = "-"

errorlog = "-"



PY





####################################
# START SCRIPT
####################################


cat > deployment/gunicorn/start.sh <<'SH'


#!/bin/bash


echo "Starting MUTEB SOC Production Server"


gunicorn \

-c deployment/gunicorn/gunicorn_config.py \

run:app



SH


chmod +x deployment/gunicorn/start.sh




####################################
# NGINX CONFIGURATION
####################################


cat > deployment/nginx/muteb.conf <<'NGINX'


server {


listen 80;


server_name muteb-soc.local;



location / {


proxy_pass http://127.0.0.1:8000;


proxy_set_header Host $host;


proxy_set_header X-Real-IP $remote_addr;


}



}


NGINX





####################################
# DOCKER BACKEND
####################################


cat > docker/Dockerfile.backend <<'DOCKER'


FROM python:3.12-slim



WORKDIR /app



COPY . .



RUN pip install --upgrade pip



RUN pip install -r requirements.txt



CMD [

"gunicorn",

"-c",

"deployment/gunicorn/gunicorn_config.py",

"run:app"

]



DOCKER





####################################
# DOCKER COMPOSE FOUNDATION
####################################


cat > docker/docker-compose.yml <<'YAML'


services:


  backend:


    build:

      context: ..

      dockerfile: docker/Dockerfile.backend


    ports:

      - "8000:8000"



  database:


    image: postgres:16


    environment:


      POSTGRES_DB:

        muteb_soc


      POSTGRES_USER:

        muteb


      POSTGRES_PASSWORD:

        change_this_password



    ports:


      - "5432:5432"



YAML






####################################
# DEPLOYMENT DOCUMENTATION
####################################


cat > PRODUCTION_DEPLOYMENT.md <<'MD'


# MUTEB SOC Production Deployment



Architecture:


User

↓

Nginx

↓

Gunicorn

↓

Flask

↓

PostgreSQL



Components:


- Backend API

- Production WSGI Server

- Reverse Proxy

- Database Service

- Container Support



MD




echo ""

echo "======================================"

echo " CODE 110-B COMPLETE"

echo "======================================"


