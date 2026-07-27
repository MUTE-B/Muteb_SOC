

def explain(threat):


    explanations={


        "SSH_BRUTE_FORCE":

        "Multiple authentication failures indicating possible credential attack.",


        "MALWARE":

        "Potential malicious software execution detected.",


        "SUSPICIOUS_IP":

        "Connection from potentially risky external source."

    }



    return explanations.get(

        threat,

        "Unknown security activity"

    )

