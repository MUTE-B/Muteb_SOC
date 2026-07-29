

def map_mitre(findings):


    return [

    {

    "technique":"T1595",

    "name":"Active Scanning"

    }

    ]




def create_ioc(target):


    return {


    "type":"domain",

    "value":target


    }




def create_incident(result):


    if result.get("risk")=="HIGH":


        return {


        "created":True,

        "severity":"HIGH",

        "source":"Scanner"


        }


    return {


    "created":False

    }

