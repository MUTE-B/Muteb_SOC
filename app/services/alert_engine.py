
from app.database.database import db

from app.models.alert import Alert



class AlertEngine:


    def create_alert(
        self,
        title,
        severity,
        source
    ):


        alert=Alert(

            title=title,

            severity=severity,

            source=source

        )


        db.session.add(alert)

        db.session.commit()


        return alert



alert_engine=AlertEngine()

