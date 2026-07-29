

#!/bin/bash


echo "Starting MUTEB Cloud Deployment"


docker compose \
-f deployment/docker/docker-compose.yml \
up -d



echo "MUTEB Cloud Service Started"


