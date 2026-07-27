
from app.database.database import db


class SecurityEvent(db.Model):

    id = db.Column(
        db.Integer,
        primary_key=True
    )

    event_type = db.Column(
        db.String(100),
        nullable=False
    )

    source = db.Column(
        db.String(100)
    )

    severity = db.Column(
        db.String(50)
    )

    message = db.Column(
        db.Text
    )

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.now()
    )
