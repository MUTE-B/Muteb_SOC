

#!/bin/bash


DATE=$(date +%F)


mkdir -p backups


tar -czf backups/muteb-$DATE.tar.gz app reports docs 2>/dev/null


echo "Backup Created: $DATE"



