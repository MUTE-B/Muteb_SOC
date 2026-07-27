

from flask_swagger_ui import get_swaggerui_blueprint



SWAGGER_URL="/docs"


API_URL="/static/swagger.json"



swagger = get_swaggerui_blueprint(

    SWAGGER_URL,

    API_URL,

    config={

        "app_name":
        "MUTEB SOC Enterprise API"

    }

)

