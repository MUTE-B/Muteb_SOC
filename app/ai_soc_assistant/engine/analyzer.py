

from datetime import datetime



class AISOCAnalyzer:



    def analyze(self,event):


        risk="LOW"



        event_text=str(event).lower()



        if "critical" in event_text:


            risk="CRITICAL"



        elif "warning" in event_text:


            risk="MEDIUM"



        return {


        "event":

        event,


        "risk":

        risk,


        "analysis":

        "AI security analysis completed",


        "time":

        str(datetime.utcnow())



        }




    def recommendation(self,risk):


        actions={


        "LOW":

        "Continue monitoring",


        "MEDIUM":

        "Review security logs",


        "CRITICAL":

        "Start incident response workflow"



        }


        return actions.get(

        risk,

        "Investigate"

        )



