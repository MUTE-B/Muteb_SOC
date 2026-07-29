

import os


LOG_FILES=[

"/var/log/auth.log",

"/var/log/syslog"

]



def collect():


    data=[]


    for file in LOG_FILES:


        if os.path.exists(file):

            with open(
            file,
            errors="ignore"
            ) as f:

                data.extend(
                f.readlines()[-50:]
                )


    return data


