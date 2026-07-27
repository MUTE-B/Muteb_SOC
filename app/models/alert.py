
from app.database.database import db

class Alert(db.Model):

    id=db.Column(db.Integer,primary_key=True)

    severity=db.Column(db.String(50))

    source=db.Column(db.String(100))

    title=db.Column(db.String(255))

    status=db.Column(db.String(50),default="NEW")

    created_at=db.Column(
        db.DateTime,
        server_default=db.func.now()
    )
