

import json



class EvidenceExporter:



    def export(self,data):


        package={


        "package":

        "MUTEB Audit Evidence Package",


        "records":

        data


        }



        return json.dumps(

        package,

        indent=4

        )



