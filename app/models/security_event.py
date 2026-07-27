from app.database.database import db


class SecurityEvent(db.Model):

    id = db.Column(
        db.Integer,
        primary_key=True
    )


    event_type = db.Column(
        db.String(100)
    )


    source = db.Column(
        db.String(100)
    )


    severity = db.Column(
        db.String(50),
        default="LOW"
    )


    source_ip = db.Column(
        db.String(50)
    )


    username = db.Column(
        db.String(100)
    )


    raw_data = db.Column(
        db.Text
    )


    created_at = db.Column(
        db.DateTime,
        server_default=db.func.now()
    )
