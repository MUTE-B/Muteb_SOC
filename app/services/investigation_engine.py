

from app.database.database import db

from app.models.case import Case



class InvestigationEngine:



    def open_case(
        self,
        incident_id,
        analyst
    ):


        case=Case(

            incident_id=incident_id,

            analyst=analyst

        )


        db.session.add(case)

        db.session.commit()


        return case




investigation_engine=InvestigationEngine()

