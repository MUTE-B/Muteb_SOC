

class ThreatAnalyzer:



    def analyze(self,indicator):


        severity=indicator.get(

        "severity",

        "LOW"

        )



        if severity=="CRITICAL":


            action="Immediate Investigation"



        elif severity=="HIGH":


            action="Priority Review"



        else:


            action="Continuous Monitoring"




        return {


        "indicator":

        indicator.get("indicator"),


        "risk":

        severity,


        "recommended_action":

        action



        }



