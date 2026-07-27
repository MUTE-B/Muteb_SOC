

def escalation_level(severity):


    levels={


        "LOW":

        "L1_ANALYST",


        "MEDIUM":

        "L2_ANALYST",


        "HIGH":

        "SOC_MANAGER",


        "CRITICAL":

        "SECURITY_DIRECTOR"

    }


    return levels.get(

        severity,

        "L1_ANALYST"

    )




def create_escalation(alert):


    return {


        "alert":

        alert.get("title"),


        "severity":

        alert.get("severity"),


        "assigned_to":

        escalation_level(

            alert.get("severity")

        )

    }

