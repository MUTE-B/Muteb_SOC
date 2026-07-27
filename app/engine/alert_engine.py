

class AlertEngine:


    def analyze(self,events):

        alerts=[]


        for event in events:


            if "Failed password" in event.get("log",""):

                alerts.append({

                    "severity":"HIGH",

                    "category":"SSH BRUTE FORCE",

                    "event":event

                })


        return alerts



alert_engine=AlertEngine()

