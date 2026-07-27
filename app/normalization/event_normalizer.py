

class EventNormalizer:



    def normalize(
        self,
        raw
    ):


        severity="LOW"



        if "failed" in raw.lower():

            severity="HIGH"



        if "error" in raw.lower():

            severity="MEDIUM"



        return {


            "event":raw,


            "severity":severity,


            "source":"linux"



        }




normalizer=EventNormalizer()

