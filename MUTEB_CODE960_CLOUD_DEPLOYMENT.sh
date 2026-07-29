#!/bin/bash


echo "======================================"
echo " MUTEB CLOUD DEPLOYMENT PACKAGE"
echo "======================================"


mkdir -p deployment/cloud
mkdir -p deployment/docker
mkdir -p deployment/cloud/scripts



####################################
# DOCKERFILE
####################################


cat > deployment/docker/Dockerfile <<'DOCKER'


FROM python:3.12-slim


WORKDIR /app


COPY . .


RUN pip install --upgrade pip


EXPOSE 5000


CMD ["python","app.py"]


DOCKER




####################################
# DOCKER COMPOSE
####################################


cat > deployment/docker/docker-compose.yml <<'YAML'


version: "3.9"


services:


  muteb:


    build:

      context: ../../


    container_name:

      muteb-enterprise


    ports:


      - "5000:5000"



    restart:

      always



YAML




####################################
# CLOUD START SCRIPT
####################################


cat > deployment/cloud/scripts/start_cloud.sh <<'SH'


#!/bin/bash


echo "Starting MUTEB Cloud Deployment"


docker compose \
-f deployment/docker/docker-compose.yml \
up -d



echo "MUTEB Cloud Service Started"


SH



chmod +x deployment/cloud/scripts/start_cloud.sh





####################################
# CLOUD CONFIG
####################################


cat > deployment/cloud/cloud_config.env <<'ENV'


APPLICATION=MUTEB_SOC_ENTERPRISE

VERSION=1.0.0

MODE=PRODUCTION

CONTAINERIZATION=ENABLED

CLOUD_READY=TRUE


ENV




####################################
# DOCUMENTATION
####################################


cat > CLOUD_DEPLOYMENT_GUIDE.md <<'MD'


# MUTEB Cloud Deployment Guide



Supported:


- Docker

- Cloud Servers

- Production Containers



Deployment:


1. Build Container

2. Start Services

3. Verify Health



Status:


Cloud Ready



MD




echo ""

echo "======================================"

echo " CODE 960 COMPLETE"

echo "======================================"


