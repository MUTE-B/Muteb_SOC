

from datetime import datetime



class SIEMConnector:



    def status(self):

        return {


        "connector":

        "SIEM Integration",


        "status":

        "READY",


        "supported":

        [

        "Wazuh",

        "Microsoft Sentinel",

        "Splunk"

        ],


        "last_sync":

        str(datetime.utcnow())


        }



