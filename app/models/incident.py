
from app.database.database import db

class Incident(db.Model):

    id=db.Column(db.Integer,primary_key=True)

    title=db.Column(db.String(255))

    severity=db.Column(db.String(50))

    status=db.Column(db.String(50),default="OPEN")

    source=db.Column(db.String(100))

    description=db.Column(db.Text)

    created_at=db.Column(
        db.DateTime,
        server_default=db.func.now()
    )
