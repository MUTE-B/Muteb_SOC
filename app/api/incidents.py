from flask import Blueprint,request,jsonify

from app.database.database import db

from app.models.incident import Incident

from app.auth.decorators import permission_required



incident = Blueprint(
    "incident",
    __name__
)



@incident.route(
    "/",
    methods=["GET"]
)
@permission_required("incidents")
def all_incidents():


    rows = Incident.query.all()


    return jsonify([

        {

        "id":x.id,

        "title":x.title,

        "severity":x.severity,

        "status":x.status,

        "source":x.source

        }

        for x in rows

    ])




@incident.route(
    "/",
    methods=["POST"]
)
@permission_required("incidents")
def create():


    data=request.json


    row=Incident(

        title=data["title"],

        severity=data["severity"],

        source=data["source"],

        description=data["description"]

    )


    db.session.add(row)

    db.session.commit()



    return jsonify({

        "status":"created",

        "id":row.id

    })
