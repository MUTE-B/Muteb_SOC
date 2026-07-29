

class DetectionEngine:


    def __init__(self):

        self.rules=[

            "failed login",
            "malware",
            "suspicious",
            "privilege escalation",
            "unauthorized"

        ]



    def analyze(self,event):


        alerts=[]


        text=str(event).lower()



        for rule in self.rules:


            if rule in text:


                alerts.append({

                    "title":rule,

                    "severity":"HIGH",

                    "event":event

                })



        return alerts



    def detect(self,event):

        return self.analyze(event)




def detect(event):


    engine=DetectionEngine()

    result=engine.analyze(event)


    if result:

        return result[0]


    return {

        "severity":"LOW",

        "alert":event

    }


