from app.database.database import db
from datetime import datetime



class User(db.Model):

    id=db.Column(
        db.Integer,
        primary_key=True
    )

    username=db.Column(
        db.String(50),
        unique=True
    )

    role=db.Column(
        db.String(50)
    )

    created=db.Column(
        db.DateTime,
        default=datetime.utcnow
    )





class Alert(db.Model):

    id=db.Column(
        db.Integer,
        primary_key=True
    )

    alert_id=db.Column(
        db.String(50)
    )

    name=db.Column(
        db.String(100)
    )

    level=db.Column(
        db.String(20)
    )

    created=db.Column(
        db.DateTime,
        default=datetime.utcnow
    )





class Incident(db.Model):

    id=db.Column(
        db.Integer,
        primary_key=True
    )

    incident_id=db.Column(
        db.String(50)
    )

    title=db.Column(
        db.String(200)
    )

    status=db.Column(
        db.String(50)
    )

    created=db.Column(
        db.DateTime,
        default=datetime.utcnow
    )





class AuditLog(db.Model):

    id=db.Column(
        db.Integer,
        primary_key=True
    )

    username=db.Column(
        db.String(50)
    )

    action=db.Column(
        db.String(200)
    )

    timestamp=db.Column(
        db.DateTime,
        default=datetime.utcnow
    )

