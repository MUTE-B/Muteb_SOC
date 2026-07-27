

class ThreatScore:



    def calculate(

        self,

        ioc_score,

        mitre_count

    ):


        score=ioc_score


        score += mitre_count * 20


        if score > 100:

            score=100



        return score




threat_score=ThreatScore()

