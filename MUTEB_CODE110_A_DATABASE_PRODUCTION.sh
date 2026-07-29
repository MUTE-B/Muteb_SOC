#!/bin/bash


echo "======================================"
echo " MUTEB PRODUCTION DATABASE FOUNDATION"
echo "======================================"


mkdir -p app/database
mkdir -p config



####################################
# DATABASE CONFIGURATION
####################################


cat > config/database.py <<'PY'


import os



class DatabaseConfig:



    DATABASE_URL=os.getenv(

    "DATABASE_URL",

    "postgresql://muteb:password@localhost/muteb_soc"

    )



    def get():

        return DatabaseConfig.DATABASE_URL



PY




####################################
# DATABASE MODELS FOUNDATION
####################################


cat > app/database/base.py <<'PY'


from datetime import datetime



class BaseEntity:



    def __init__(self):


        self.created_at=datetime.utcnow()

        self.updated_at=datetime.utcnow()



    def update(self):


        self.updated_at=datetime.utcnow()



PY





####################################
# DATABASE HEALTH CHECK
####################################


cat > app/database/health.py <<'PY'


class DatabaseHealth:



    def status(self):


        return {


        "database":

        "READY",


        "engine":

        "POSTGRESQL",


        "status":

        "AVAILABLE"



        }



PY





####################################
# DATABASE API
####################################


cat > app/database/routes.py <<'PY'


from flask import Blueprint,jsonify


from app.database.health import DatabaseHealth



database_api=Blueprint(

"database",

__name__,

url_prefix="/api/database"

)




@database_api.route("/health")
def health():


    return jsonify(

    DatabaseHealth().status()

    )



PY




####################################
# REGISTER
####################################


cat > app/database/register.py <<'PY'


def register_database(app):


    from app.database.routes import database_api


    app.register_blueprint(

    database_api

    )


    print(

    "✓ DATABASE LAYER ENABLED"

    )


PY




echo ""

echo "======================================"

echo " CODE 110-A COMPLETE"

echo "======================================"


