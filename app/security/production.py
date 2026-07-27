

from flask import request



def production_headers(response):


    response.headers["X-Frame-Options"]="DENY"


    response.headers["X-Content-Type-Options"]="nosniff"


    response.headers["X-XSS-Protection"]="1; mode=block"


    response.headers["Strict-Transport-Security"]="max-age=31536000"


    return response



