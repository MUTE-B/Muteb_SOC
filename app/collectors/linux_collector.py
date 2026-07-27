

import os



class LinuxCollector:



    def read_file(
        self,
        path,
        lines=50
    ):


        events=[]


        if not os.path.exists(path):

            return events



        with open(
            path,
            "r",
            errors="ignore"
        ) as file:


            data=file.readlines()[-lines:]



        for line in data:

            events.append(
                line.strip()
            )


        return events




linux_collector=LinuxCollector()

