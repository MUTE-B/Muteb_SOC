

from log_collector import collect_linux_logs

from detection_engine import analyze



def run():


    logs=collect_linux_logs()


    alerts=analyze(logs)


    return {


    "events":len(logs),

    "alerts":alerts


    }



if __name__=="__main__":

    print(run())



