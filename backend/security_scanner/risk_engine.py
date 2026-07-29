

class RiskEngine:



    def calculate(self,data):


        score=0


        findings=[]



        headers=data.get(
            "headers",
            {}
        )


        if headers.get(
            "missing_headers"
        ):

            score+=30

            findings.append({

            "issue":
            "Missing Security Headers",

            "severity":
            "MEDIUM"

            })



        ssl=data.get(
            "ssl",
            {}
        )


        if ssl.get(
            "status"
        )!="secure":

            score+=40

            findings.append({

            "issue":
            "SSL/TLS Problem",

            "severity":
            "HIGH"

            })



        if score>=70:

            level="HIGH"

        elif score>=40:

            level="MEDIUM"

        else:

            level="LOW"



        return {


        "risk_score":score,

        "risk_level":level,

        "findings":findings


        }

