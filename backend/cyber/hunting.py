

def process_hunt(processes):


    suspicious=[]


    keywords=[

    "nc",

    "nmap",

    "mimikatz",

    "powershell"

    ]


    for p in processes:


        for k in keywords:


            if k in p.lower():

                suspicious.append(p)


    return suspicious

