
from datetime import datetime


class SentinelEngine:


    def assessment(self,asset):

        return {

            "asset":asset,

            "status":"completed",

            "security_score":92,

            "risk":"LOW",

            "timestamp":str(datetime.utcnow())

        }



    def recommendation(self,risk):

        if risk=="HIGH":

            return "Immediate remediation required"

        if risk=="MEDIUM":

            return "Schedule security improvement"

        return "Security posture acceptable"



