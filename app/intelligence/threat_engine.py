from datetime import datetime


class ThreatEngine:


    def analyze(self,event):

        risk=0
        level="LOW"


        if "malware" in event.lower():

            risk=90
            level="CRITICAL"


        elif "login" in event.lower():

            risk=60
            level="MEDIUM"


        elif "scan" in event.lower():

            risk=30
            level="LOW"



        return {

            "analysis":level,

            "risk_score":risk,

            "recommended_action":
            self.action(level)

        }



    def action(self,level):

        if level=="CRITICAL":

            return "Investigate Malware Event"


        if level=="MEDIUM":

            return "Review User Activity"


        return "Monitor Event"



