#!/usr/bin/env python3

# ==========================================================
# الملف:
# file_integrity.py
#
# الهدف:
# مراقبة سلامة الملفات (File Integrity Monitoring).
#
# يقوم هذا البرنامج بـ:
#
# - حساب بصمة SHA256 لجميع الملفات.
# - إنشاء قاعدة بيانات للبصمات.
# - مقارنة البصمات الحالية مع السابقة.
# - اكتشاف الملفات:
#   - الجديدة.
#   - المعدلة.
#   - المحذوفة.
#
# يستخدم لمراقبة ملفات النظام
# أو ملفات المشروع واكتشاف أي تغيير غير مصرح به.
# ==========================================================


# ----------------------------------------------------------
# استيراد المكتبات
# ----------------------------------------------------------

import os
import json
import hashlib
import datetime


# ----------------------------------------------------------
# تحديد المجلد الرئيسي للمشروع
# ----------------------------------------------------------

PROJECT_ROOT = os.path.abspath(
    os.path.join(
        os.path.dirname(__file__),
        "..",
        ".."
    )
)


# ----------------------------------------------------------
# تحديد الملفات والمجلدات المستخدمة
# ----------------------------------------------------------

DATABASE_FILE = os.path.join(
    PROJECT_ROOT,
    "reports",
    "file_integrity_database.json"
)

REPORT_FILE = os.path.join(
    PROJECT_ROOT,
    "reports",
    "file_integrity_report.txt"
)


os.makedirs(
    os.path.dirname(REPORT_FILE),
    exist_ok=True
)


# ----------------------------------------------------------
# حساب SHA256 للملف
# ----------------------------------------------------------

def calculate_sha256(file_path):

    hash_object = hashlib.sha256()

    with open(file_path, "rb") as file:

        while True:

            data = file.read(4096)

            if not data:

                break

            hash_object.update(data)

    return hash_object.hexdigest()


# ----------------------------------------------------------
# جمع جميع الملفات داخل المشروع
# ----------------------------------------------------------

current_database = {}

EXCLUDED = {

    ".git",

    "__pycache__",

    "venv",

    "backup"

}


for root, directories, files in os.walk(PROJECT_ROOT):

    directories[:] = [

        directory

        for directory in directories

        if directory not in EXCLUDED

    ]


    for filename in files:

        full_path = os.path.join(root, filename)

        relative_path = os.path.relpath(

            full_path,

            PROJECT_ROOT

        )

        try:

            current_database[relative_path] = calculate_sha256(full_path)

        except Exception:

            continue


# ----------------------------------------------------------
# قراءة قاعدة البيانات القديمة
# ----------------------------------------------------------

old_database = {}

if os.path.isfile(DATABASE_FILE):

    with open(

        DATABASE_FILE,

        "r",

        encoding="utf-8"

    ) as database:

        old_database = json.load(database)


# ----------------------------------------------------------
# مقارنة النتائج
# ----------------------------------------------------------

added_files = []

modified_files = []

deleted_files = []


for file_name, hash_value in current_database.items():

    if file_name not in old_database:

        added_files.append(file_name)

    elif old_database[file_name] != hash_value:

        modified_files.append(file_name)


for file_name in old_database:

    if file_name not in current_database:

        deleted_files.append(file_name)


# ----------------------------------------------------------
# حفظ قاعدة البيانات الجديدة
# ----------------------------------------------------------

with open(

    DATABASE_FILE,

    "w",

    encoding="utf-8"

) as database:

    json.dump(

        current_database,

        database,

        indent=4

    )


# ----------------------------------------------------------
# إنشاء التقرير
# ----------------------------------------------------------

with open(

    REPORT_FILE,

    "w",

    encoding="utf-8"

) as report:


    report.write(
        "============================================================\n"
    )

    report.write(
        "            File Integrity Monitoring Report\n"
    )

    report.write(
        "============================================================\n\n"
    )


    report.write(
        f"Generated : {datetime.datetime.now()}\n\n"
    )


    report.write("Added Files\n")

    report.write("----------------------------------------\n")

    for item in added_files:

        report.write(f"{item}\n")

    report.write("\n")


    report.write("Modified Files\n")

    report.write("----------------------------------------\n")

    for item in modified_files:

        report.write(f"{item}\n")

    report.write("\n")


    report.write("Deleted Files\n")

    report.write("----------------------------------------\n")

    for item in deleted_files:

        report.write(f"{item}\n")

    report.write("\n")


    report.write(
        "============================================================\n"
    )

    report.write(
        "Integrity Check Completed Successfully\n"
    )

    report.write(
        "============================================================\n"
    )


# ----------------------------------------------------------
# عرض النتائج
# ----------------------------------------------------------

print()

print("============================================================")

print("File integrity check completed successfully.")

print()

print(f"New Files      : {len(added_files)}")

print(f"Modified Files : {len(modified_files)}")

print(f"Deleted Files  : {len(deleted_files)}")

print()

print("Database saved to:")

print(DATABASE_FILE)

print()

print("Report saved to:")

print(REPORT_FILE)

print()

print("============================================================")
