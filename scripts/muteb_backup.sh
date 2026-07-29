

#!/bin/bash


DATE=$(date +%Y%m%d_%H%M%S)


mkdir -p backups/$DATE



cp -r backend/logs backups/$DATE/

cp -r backend/reports backups/$DATE/


echo "Backup created: backups/$DATE"


