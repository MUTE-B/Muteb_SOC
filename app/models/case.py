
from app.database.database import db


class Case(db.Model):

    id=db.Column(
        db.Integer,
        primary_key=True
    )


    incident_id=db.Column(
        db.Integer
    )


    analyst=db.Column(
        db.String(100)
    )


    status=db.Column(
        db.String(50),
        default="OPEN"
    )


    priority=db.Column(
        db.String(50),
        default="HIGH"
    )


    notes=db.Column(
        db.Text
    )


    created_at=db.Column(
        db.DateTime,
        server_default=db.func.now()
    )

