from app.models.incident import Incident

from app.database.database import db



class IncidentEngine:



    def create_incident(
        self,
        title,
        severity,
        source,
        description
    ):


        incident = Incident(

            title=title,

            severity=severity,

            source=source,

            description=description

        )


        db.session.add(
            incident
        )

        db.session.commit()


        return incident



incident_engine = IncidentEngine()

