#!/usr/bin/env python3

import os


class Config:

    PROJECT_NAME = "MUTEB SOC"

    VERSION = "v1.3"

    HOST = "0.0.0.0"

    PORT = 5000

    REPORTS_DIR = "reports"

    LOGS_DIR = "logs"



    @staticmethod
    def check_directories():

        os.makedirs(
            Config.REPORTS_DIR,
            exist_ok=True
        )

        os.makedirs(
            Config.LOGS_DIR,
            exist_ok=True
        )


