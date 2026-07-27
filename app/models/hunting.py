
from app.database.database import db


class HuntingQuery(db.Model):

    id = db.Column(
        db.Integer,
        primary_key=True
    )

    name = db.Column(
        db.String(200)
    )

    query = db.Column(
        db.Text
    )

    description = db.Column(
        db.Text
    )


class InvestigationNote(db.Model):

    id = db.Column(
        db.Integer,
        primary_key=True
    )

    analyst = db.Column(
        db.String(100)
    )

    note = db.Column(
        db.Text
    )

    severity = db.Column(
        db.String(50)
    )
