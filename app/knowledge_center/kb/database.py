

class KnowledgeBase:



    articles=[


    "Threat Detection",

    "Log Analysis",

    "Network Monitoring",

    "Security Hardening",

    "Threat Hunting"


    ]



    def search(self):


        return {


        "articles":

        self.articles,


        "count":

        len(self.articles)



        }



