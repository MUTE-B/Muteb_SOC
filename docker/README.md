# MUTEB SOC Docker Deployment


## Build

docker build -f docker/Dockerfile -t muteb-soc .


## Run

docker run -it muteb-soc


## Compose

docker compose -f docker/docker-compose.yml up -d

