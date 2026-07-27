

from datetime import datetime



class SIEMFormatter:


    def format_event(
        self,
        source,
        event,
        severity="MEDIUM"
    ):


        return {


            "timestamp":
            str(datetime.utcnow()),


            "source":
            source,


            "event":
            event,


            "severity":
            severity,


            "platform":
            "MUTEB SOC"

        }




formatter=SIEMFormatter()

