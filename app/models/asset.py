from app.database.database import db


class Asset(db.Model):

    id = db.Column(
        db.Integer,
        primary_key=True
    )


    hostname = db.Column(
        db.String(120),
        nullable=False
    )


    ip_address = db.Column(
        db.String(50)
    )


    asset_type = db.Column(
        db.String(50),
        default="SERVER"
    )


    criticality = db.Column(
        db.String(50),
        default="MEDIUM"
    )


    status = db.Column(
        db.String(50),
        default="ACTIVE"
    )


    created_at = db.Column(
        db.DateTime,
        server_default=db.func.now()
    )
