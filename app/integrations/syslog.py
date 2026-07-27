

from datetime import datetime



class SyslogCollector:


    def receive(self,message):


        return {

            "source":"SYSLOG",

            "message":message,

            "time":str(datetime.utcnow()),

            "status":"RECEIVED"

        }



syslog_collector=SyslogCollector()

