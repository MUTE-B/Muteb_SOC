

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



