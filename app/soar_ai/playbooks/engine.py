

class SOARPlaybookEngine:



    playbooks={


    "malware": [

        "isolate_host",

        "collect_evidence",

        "notify_soc"

    ],



    "phishing": [

        "analyze_email",

        "block_sender",

        "create_case"

    ],



    "intrusion": [

        "block_ip",

        "start_investigation",

        "alert_manager"

    ]



    }



    def execute(self,type):


        return {


        "incident_type":

        type,


        "actions":

        self.playbooks.get(type,[]),


        "status":

        "EXECUTED"



        }



