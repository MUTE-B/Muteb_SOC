class IOCScanner:


    def scan(self,text):

        indicators=[]


        suspicious=[

            "malware",
            "powershell",
            "cmd.exe",
            "reverse_shell",
            "ransomware",
            "bruteforce"

        ]


        for item in suspicious:

            if item.lower() in text.lower():

                indicators.append(item)


        return indicators



ioc_scanner = IOCScanner()
