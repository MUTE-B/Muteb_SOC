
from app.database.database import db


class Evidence(db.Model):


    id=db.Column(
        db.Integer,
        primary_key=True
    )


    case_id=db.Column(
        db.Integer
    )


    filename=db.Column(
        db.String(255)
    )


    hash_value=db.Column(
        db.String(255)
    )


    description=db.Column(
        db.Text
    )


    created_at=db.Column(
        db.DateTime,
        server_default=db.func.now()
    )

