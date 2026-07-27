

class CorrelationEngine:


    def correlate(self, events):


        result=[]


        if len(events)>=3:

            result.append({

                "alert":"Multiple suspicious events",

                "severity":"HIGH",

                "action":"Investigate"

            })


        return result



correlation_engine=CorrelationEngine()

