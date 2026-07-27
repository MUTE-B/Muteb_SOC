

REPUTATION_DB = {


    "185.220.101.1":{


        "type":"IP",

        "country":"UNKNOWN",

        "risk":90,

        "malicious":True

    },


    "192.168.1.1":{


        "type":"IP",

        "risk":0,

        "malicious":False

    }


}



def check_reputation(value):


    return REPUTATION_DB.get(

        value,

        {

            "type":"UNKNOWN",

            "risk":0,

            "malicious":False

        }

    )




def add_indicator(value,data):


    REPUTATION_DB[value]=data


    return REPUTATION_DB[value]

