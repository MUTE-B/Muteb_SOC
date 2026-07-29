

from datetime import datetime



class AIDecisionEngine:



    def decide(self,event):


        event=str(event).lower()



        if "critical" in event:


            action="ISOLATE"


            priority="HIGH"



        elif "warning" in event:


            action="INVESTIGATE"


            priority="MEDIUM"



        else:


            action="MONITOR"


            priority="LOW"



        return {


        "event":

        event,


        "decision":

        action,


        "priority":

        priority,


        "timestamp":

        str(datetime.utcnow())



        }



