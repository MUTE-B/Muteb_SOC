

#!/bin/bash


DATE=$(date +%Y-%m-%d)


mkdir -p backups


tar -czf backups/muteb_backup_$DATE.tar.gz app docs release



echo "Backup completed"

