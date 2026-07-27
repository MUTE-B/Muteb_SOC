

def security_headers(response):


    response.headers["X-Frame-Options"]="DENY"

    response.headers["X-Content-Type-Options"]="nosniff"

    response.headers["X-XSS-Protection"]="1; mode=block"


    return response

