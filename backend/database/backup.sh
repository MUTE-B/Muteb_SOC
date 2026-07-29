
#!/bin/bash

mkdir -p backups

pg_dump muteb_soc > backups/database.sql

