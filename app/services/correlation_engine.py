
class CorrelationEngine:


    def analyze(
        self,
        events
    ):


        result = {

            "events_count":
            len(events),

            "risk":
            "NORMAL"

        }



        if len(events) >= 5:

            result["risk"]="HIGH"



        return result



correlation_engine = CorrelationEngine()

