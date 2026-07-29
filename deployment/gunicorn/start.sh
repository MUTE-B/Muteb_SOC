

#!/bin/bash


echo "Starting MUTEB SOC Production Server"


gunicorn \

-c deployment/gunicorn/gunicorn_config.py \

run:app



