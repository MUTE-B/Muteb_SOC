
class ThreatClassifier:


    def classify(self, event):

        text = event.lower()


        if "failed password" in text:

            return {

                "category":"BRUTE_FORCE",

                "mitre":"T1110",

                "name":"Brute Force"

            }


        if "sudo" in text:

            return {

                "category":"PRIVILEGE_ESCALATION",

                "mitre":"T1548",

                "name":"Privilege Escalation"

            }


        if "malware" in text:

            return {

                "category":"MALWARE",

                "mitre":"T1204",

                "name":"Malware Execution"

            }


        return {

            "category":"UNKNOWN",

            "mitre":"N/A",

            "name":"Unknown Activity"

        }



classifier = ThreatClassifier()

