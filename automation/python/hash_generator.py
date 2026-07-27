#!/usr/bin/env python3

# ==========================================================
# الملف:
# hash_generator.py
#
# الهدف:
# إنشاء بصمات رقمية (Hashes) للملفات.
#
# يقوم هذا البرنامج بـ:
#
# - حساب MD5
# - حساب SHA1
# - حساب SHA256
# - حساب SHA512
#
# يستخدم أثناء التحقيقات الرقمية للتحقق
# من سلامة الملفات وعدم تعرضها للتعديل.
# ==========================================================


# ----------------------------------------------------------
# استيراد المكتبات
# ----------------------------------------------------------

import os
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
# تحديد مجلد التقارير
# ----------------------------------------------------------

REPORT_DIR = os.path.join(
    PROJECT_ROOT,
    "reports"
)

os.makedirs(
    REPORT_DIR,
    exist_ok=True
)


# ----------------------------------------------------------
# تحديد اسم التقرير
# ----------------------------------------------------------

REPORT_FILE = os.path.join(
    REPORT_DIR,
    "hash_report.txt"
)


# ----------------------------------------------------------
# دالة حساب البصمة الرقمية
# ----------------------------------------------------------

def calculate_hash(file_path, algorithm):

    hash_object = algorithm()

    with open(file_path, "rb") as file:

        while True:

            chunk = file.read(4096)

            if not chunk:

                break

            hash_object.update(chunk)

    return hash_object.hexdigest()


# ----------------------------------------------------------
# طلب اسم الملف من المستخدم
# ----------------------------------------------------------

print()

target_file = input("Enter file path: ").strip()


# ----------------------------------------------------------
# التحقق من وجود الملف
# ----------------------------------------------------------

if not os.path.isfile(target_file):

    print()

    print("File not found.")

    raise SystemExit(1)


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
        "                  File Hash Report\n"
    )

    report.write(
        "============================================================\n\n"
    )

    report.write(
        f"Generated : {datetime.datetime.now()}\n\n"
    )

    report.write(
        f"File : {target_file}\n\n"
    )


    md5 = calculate_hash(
        target_file,
        hashlib.md5
    )

    sha1 = calculate_hash(
        target_file,
        hashlib.sha1
    )

    sha256 = calculate_hash(
        target_file,
        hashlib.sha256
    )

    sha512 = calculate_hash(
        target_file,
        hashlib.sha512
    )


    report.write(f"MD5\n{md5}\n\n")

    report.write(f"SHA1\n{sha1}\n\n")

    report.write(f"SHA256\n{sha256}\n\n")

    report.write(f"SHA512\n{sha512}\n\n")


    report.write(
        "============================================================\n"
    )

    report.write(
        "Hash Generation Completed Successfully\n"
    )

    report.write(
        "============================================================\n"
    )


# ----------------------------------------------------------
# عرض النتائج للمستخدم
# ----------------------------------------------------------

print()

print("============================================================")

print("Hashes generated successfully.")

print()

print(f"MD5    : {md5}")

print()

print(f"SHA1   : {sha1}")

print()

print(f"SHA256 : {sha256}")

print()

print(f"SHA512 : {sha512}")

print()

print("Report saved to:")

print()

print(REPORT_FILE)

print()

print("============================================================")
