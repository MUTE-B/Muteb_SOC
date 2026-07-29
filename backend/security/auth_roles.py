

from functools import wraps

from flask import request,jsonify



USERS={


"admin":{

"role":"Admin"

},


"analyst":{

"role":"SOC Analyst"

},


"viewer":{

"role":"Viewer"

}


}



def require_role(*roles):


    def decorator(func):


        @wraps(func)

        def wrapper(*args,**kwargs):


            role=request.headers.get(
            "X-ROLE",
            "Viewer"
            )


            if role not in roles:


                return jsonify({

                "error":"Permission denied"

                }),403



            return func(*args,**kwargs)


        return wrapper


    return decorator

