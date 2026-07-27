
from app.database.database import db


class DetectionRule(db.Model):

    id = db.Column(
        db.Integer,
        primary_key=True
    )

    name = db.Column(
        db.String(200),
        nullable=False
    )

    rule_type = db.Column(
        db.String(100)
    )

    severity = db.Column(
        db.String(50)
    )

    description = db.Column(
        db.Text
    )


class DetectionEvent(db.Model):

    id = db.Column(
        db.Integer,
        primary_key=True
    )

    indicator = db.Column(
        db.String(255)
    )

    detection_type = db.Column(
        db.String(100)
    )

    severity = db.Column(
        db.String(50)
    )

    technique = db.Column(
        db.String(100)
    )

    status = db.Column(
        db.String(50),
        default="NEW"
    )
