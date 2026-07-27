

class SeverityEngine:


    def calculate(self, threat):


        score=0


        if threat["category"]=="BRUTE_FORCE":

            score=80


        elif threat["category"]=="PRIVILEGE_ESCALATION":

            score=90


        elif threat["category"]=="MALWARE":

            score=95


        else:

            score=20



        if score >=90:

            level="CRITICAL"

        elif score >=70:

            level="HIGH"

        elif score >=40:

            level="MEDIUM"

        else:

            level="LOW"



        return {

            "score":score,

            "severity":level

        }



severity_engine=SeverityEngine()

