
import os
from datetime import datetime


class LogCollector:


    def collect_ssh(self):

        path="/var/log/auth.log"

        events=[]


        if os.path.exists(path):

            with open(path,"r",errors="ignore") as f:

                for line in f.readlines()[-100:]:

                    if "Failed password" in line:

                        events.append({

                            "type":"SSH_FAILED_LOGIN",

                            "log":line.strip(),

                            "time":str(datetime.utcnow())

                        })


        return events



    def collect_system(self):

        path="/var/log/syslog"

        events=[]


        if os.path.exists(path):

            with open(path,"r",errors="ignore") as f:

                for line in f.readlines()[-100:]:

                    events.append({

                        "type":"SYSTEM_EVENT",

                        "log":line.strip(),

                        "time":str(datetime.utcnow())

                    })


        return events



collector=LogCollector()

