

class ThreatFeedCollector:



    feeds=[


    "Open Threat Intelligence",

    "Malware Intelligence",

    "Network Reputation",

    "Vulnerability Intelligence"



    ]



    def collect(self):


        return {


        "feeds":

        self.feeds,


        "status":

        "CONNECTED"



        }



