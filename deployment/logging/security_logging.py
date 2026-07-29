

import logging



logging.basicConfig(

filename="muteb_security.log",

level=logging.INFO,

format="%(asctime)s %(levelname)s %(message)s"

)



def security_event(message):


    logging.info(message)



