
from datetime import datetime


class ThreatEngine:


    def score(self,severity):

        levels={

        "LOW":25,
        "MEDIUM":50,
        "HIGH":75,
        "CRITICAL":95

        }

        return levels.get(
            severity.upper(),
            0
        )


    def analyze(self,data):

        return {

        "platform":"MUTEB SOC",
        "event":data,
        "risk":
        self.score(
            data.get(
            "severity",
            "LOW")
        ),
        "time":
        str(datetime.now())

        }

