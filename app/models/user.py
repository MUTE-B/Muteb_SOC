from werkzeug.security import (
    generate_password_hash,
    check_password_hash
)

from app.database.database import db



class User(db.Model):


    id=db.Column(
        db.Integer,
        primary_key=True
    )


    username=db.Column(
        db.String(80),
        unique=True,
        nullable=False
    )


    email=db.Column(
        db.String(120),
        unique=True,
        nullable=False
    )


    password=db.Column(
        db.String(255),
        nullable=False
    )


    role=db.Column(
        db.String(50),
        default="VIEWER"
    )


    is_active=db.Column(
        db.Boolean,
        default=True
    )



    def set_password(
        self,
        password
    ):

        self.password = generate_password_hash(
            password
        )



    def check_password(
        self,
        password
    ):

        return check_password_hash(
            self.password,
            password
        )
