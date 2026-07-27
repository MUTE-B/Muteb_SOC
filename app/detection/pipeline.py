

from app.detection.risk_engine import risk_engine

from app.models.alert import Alert

from app.models.incident import Incident

from app.database.database import db



class DetectionPipeline:



    def analyze(
        self,
        event
    ):



        result=risk_engine.calculate(

            event

        )



        if result["score"] >= 40:



            alert=Alert(

                title="Suspicious Security Event",

                source="Detection Engine",

                severity=result["severity"],

                status="NEW"

            )


            db.session.add(alert)



            incident=Incident(

                title="Security Incident Generated",

                severity=result["severity"],

                source="Detection Engine",

                description=event

            )


            db.session.add(incident)



            db.session.commit()



            return {


                "detected":True,

                "severity":result["severity"],

                "score":result["score"]


            }



        return {


            "detected":False,

            "score":result["score"]


        }




pipeline=DetectionPipeline()

