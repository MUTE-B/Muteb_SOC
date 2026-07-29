

MITRE={

"Brute Force":"T1110",

"Command Shell":"T1059",

"Malware":"T1204"

}


def map_attack(name):

    return MITRE.get(
        name,
        "UNKNOWN"
    )

