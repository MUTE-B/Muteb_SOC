

MITRE_MAP={


"powershell":

{

"technique":"T1059.001",

"name":"PowerShell"

},


"failed login":

{

"technique":"T1110",

"name":"Brute Force"

},


"reverse_shell":

{

"technique":"T1059",

"name":"Command Shell"

}



}



class MITREEngine:



    def map_event(
        self,
        event
    ):


        results=[]


        for key,value in MITRE_MAP.items():


            if key.lower() in event.lower():

                results.append(value)



        return results




mitre_engine=MITREEngine()

