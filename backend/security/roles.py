

ROLES={

"admin":[

"scan",

"report",

"manage"

],


"soc_analyst":[

"scan",

"report"

],


"viewer":[

"view"

]

}



def allowed(role,action):

    return action in ROLES.get(
        role,
        []
    )

