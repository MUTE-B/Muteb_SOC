

import subprocess


def collect_linux_logs():


    result=subprocess.check_output(

    "journalctl -n 50 --no-pager",

    shell=True,

    text=True

    )


    return result.splitlines()



