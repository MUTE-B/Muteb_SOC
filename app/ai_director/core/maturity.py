

class SecurityMaturity:



    def calculate(self,controls):


        score=min(
            controls*10,
            100
        )


        if score>=80:

            level="ADVANCED"


        elif score>=50:

            level="DEVELOPING"


        else:

            level="INITIAL"



        return {


        "maturity_score":

        score,


        "level":

        level



        }



