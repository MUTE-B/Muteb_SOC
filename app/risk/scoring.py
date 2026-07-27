

SEVERITY_SCORE = {


    "LOW":20,

    "MEDIUM":50,

    "HIGH":80,

    "CRITICAL":100

}



def calculate_risk(severity):


    return SEVERITY_SCORE.get(

        severity.upper(),

        0

    )




def classify(score):


    if score >= 90:

        return "CRITICAL"


    if score >= 70:

        return "HIGH"


    if score >= 40:

        return "MEDIUM"


    return "LOW"


