from app.database.database import db


class DetectionRule(db.Model):

    id = db.Column(
        db.Integer,
        primary_key=True
    )


    name = db.Column(
        db.String(150)
    )


    technique = db.Column(
        db.String(100)
    )


    severity = db.Column(
        db.String(50)
    )


    enabled = db.Column(
        db.Boolean,
        default=True
    )


    description = db.Column(
        db.Text
    )
