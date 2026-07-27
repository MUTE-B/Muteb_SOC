from app.database.database import db


class AuditLog(db.Model):

    id = db.Column(
        db.Integer,
        primary_key=True
    )


    username = db.Column(
        db.String(100)
    )


    action = db.Column(
        db.String(150)
    )


    module = db.Column(
        db.String(100)
    )


    ip_address = db.Column(
        db.String(50)
    )


    created_at = db.Column(
        db.DateTime,
        server_default=db.func.now()
    )
