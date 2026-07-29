

class CorrelationEngine:



    def analyze(self,events):


        alerts=0



        for event in events:


            if event.get("severity") in [

            "high",

            "critical"

            ]:


                alerts+=1



        return {


        "events_analyzed":

        len(events),


        "correlated_alerts":

        alerts,


        "engine":

        "ACTIVE"



        }



